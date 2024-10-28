import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/download_center/Upload%20Content/upload_share_content_modal.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import '../Content Type/content_type_modal.dart';

class UploadShareContentController extends GetxController {
  // Variables
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  var isLoading = false.obs;
  var hasMore = true.obs;
  var page = 1.obs;
  var dataList = [].obs;

  RxList<File?> pickedFile = RxList<File?>([]);
  var searchC = TextEditingController();
  TextEditingController videoLinkC = TextEditingController();
  Rx<ContentTypeModal> filteredContentTypeList = ContentTypeModal().obs;
  RxString selectedContentTypeId = "".obs;
  var checkboxStates = <String, bool>{}.obs;

  // Toggle checkbox state and save it in the map
  void toggleCheckboxState(String itemId, bool value) {
    checkboxStates[itemId] = value;
  }
  Future<void> fetchData({bool isRefresh = false}) async {
    if (isRefresh) {
      page.value = 1;
      dataList.clear();
    }

    isLoading.value = true;

    // Call your API here (Replace with actual API call)
    var newData = await fetchDataFromApi(page.value, searchC.text);

    if (newData.isEmpty) {
      hasMore.value = false;
    } else {

      dataList.addAll(newData);
      page.value++;
    }

    isLoading.value = false;
  }

  Future<List<dynamic>> fetchDataFromApi(int page, String search) async {
    // Replace this with your actual data-fetching logic
    var body = {'data[page]' : page,'data[search]': search};
    var data = await apiRespository.postApiCallByFormData(Constants.getuploaddataUrl, body);
    if(data.body != null)
      {
        var da = UploadContent.fromJson(data.body);
        return da.content!; // Simulate data
      }
    else
      {
        return [];
      }

    //await Future.delayed(Duration(seconds: 1)); // Simulate network delay

  }

  @override
  void onInit() {
    super.onInit();
    fetchData(isRefresh: true); // Initial data load
  }


  void deletecontenttypebyId(context,id) async
  {

    var body = {
      "id":id
    };
    print("rrrrr${body}");
    var data = await apiRespository.postApiCallByFormData(Constants.deleteuploaddataUrl, body);
    String msgFor = "Delete";
    print(data.body);
    if(data.statusCode == 200)
    {

      Get.showSnackbar(Ui.SuccessSnackBar(message: '${msgFor}d Success'));
      fetchData(isRefresh: true);

    }
    else
    {
      Get.showSnackbar(Ui.ErrorSnackBar(message: 'Error Occurred while ${msgFor}'));
    }

  }
  getContypeList()
  async {
    try
    {
      var body = {};
      var data = await apiRespository.postApiCallByJson(Constants.getcontenttypelistUrl, body);

      filteredContentTypeList.value = ContentTypeModal.fromJson(data.body);

      update();
    }
    catch(e)
    {

    }
  }

  void saveContentType(context) async
  {
    Map<String, String> body = {
      "content_type":selectedContentTypeId.value,

    };

    FormData bodyForm = FormData({});

    if (pickedFile.isNotEmpty) {
      for (var file in pickedFile) {
        if (await file!.exists()) {
          print(file.path);
          // Create MultipartFile from the file
          var multipartFile = MultipartFile(
            file.path,
            filename: file.path.split('/').last,
          );
          print(multipartFile);
          // Add the file to the FormData
          bodyForm.files.add(MapEntry('upload[]', multipartFile)); // Use 'files[]' to match your API
        }
      }
    }
    else
      {
        body = {
          "content_type":selectedContentTypeId.value,
          "url":videoLinkC.value.text.toString()
        };
      }
    bodyForm.fields.addAll(body.entries);
    // print(bodyForm.files[0].key);


    var data = await apiRespository.postApiCallByFormData(Constants.ajaxuploadUrl, bodyForm);
    if(data.statusCode == 200)
    {

      Get.showSnackbar(Ui.SuccessSnackBar(message: '${"saved"}d Success'));
      // initializeData();
      fetchData(isRefresh: true);
     Navigator.pop(context);
    }
    else
    {
      Get.showSnackbar(Ui.ErrorSnackBar(message: 'Error Occurred while ${"saving"}'));
    }

  }
}
