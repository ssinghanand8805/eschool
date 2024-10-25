import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import 'content_type_modal.dart';

class ContentTypeController extends GetxController {

  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<TextEditingController> searchC = TextEditingController().obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  Rx<ContentTypeModal> filteredContentTypeList = ContentTypeModal().obs;
  int contentTypeId = 0;
  late Future<void> fetchDataFuture;
  final formKey = GlobalKey<FormState>().obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    super.onInit();
    fetchDataFuture = initializeData();
}

  // Store the original data list separately
  List<Data> originalContentTypeList = [];

// Function to perform search
  Future<void> searchContentType(String searchKey) async {
    // Check if the searchKey is empty or not
    if (searchKey.isEmpty) {
      // Reset to the original list when searchKey is cleared
      filteredContentTypeList.update((val) {
        val?.data = originalContentTypeList;  // Reset to original list
      });
    } else {
      // Filter the list based on the searchKey
      List<Data> filteredList = originalContentTypeList
          .where((element) => element.name != null &&
          element.name!.toLowerCase().contains(searchKey.toLowerCase().trim()))  // Perform case-insensitive search
          .toList();

      // Update the filtered list
      filteredContentTypeList.update((val) {
        val?.data = filteredList;
      });
    }
  }

// Call this function once when you first load the data to store the original list
  void initializeOriginalList() {
    originalContentTypeList = List.from(filteredContentTypeList.value.data!);  // Make a copy of the original data
  }

  Future<void> initializeData() async  {
    isLoading.value = true;
    try
        {
          var body = {};
          var data = await apiRespository.postApiCallByJson(Constants.getcontenttypelistUrl, body);

          filteredContentTypeList.value = ContentTypeModal.fromJson(data.body);
          initializeOriginalList();
          update();
        }
        catch(e)
    {

    }

    // Initialize fetchDataFuture here
  }


  void getcontenttypebyId(context,id) async
  {

    var body = {
      "id":id
    };
    var data = await apiRespository.postApiCallByFormData(Constants.getcontenttypebyidUrl, body);
    var da = ContentTypeModal.fromJson(data.body);
    if(da != null)
      {
        contentTypeId = id;
        nameC.text = da.data![0].name.toString();
        descriptionC.text = da.data![0].description.toString();
        update();
      }

  }

  void deletecontenttypebyId(context,id) async
  {

    var body = {
      "id":id
    };
    var data = await apiRespository.postApiCallByFormData(Constants.contenttypedeleteUrl, body);
    String msgFor = "Delete";
    if(data.body['status'] == 'success')
    {

      Get.showSnackbar(Ui.SuccessSnackBar(message: '${msgFor}d Success'));
      initializeData();

    }
    else
    {
      Get.showSnackbar(Ui.ErrorSnackBar(message: 'Error Occurred while ${msgFor}'));
    }

  }

  void saveContentType(context) async
  {
    String desc = descriptionC.value.text.trim().toString();
    var body = {
   "name":nameC.value.text.trim().toString(),
      "description":desc.isNotEmpty ? desc : ""
    };
    String url = Constants.save_content_typeUrl;
    String msgFor = "Save";
    if(contentTypeId != 0)
      {
        body['id'] = contentTypeId.toString();
        url = Constants.contenttypeeditUrl;
        msgFor = "Update";
      }
    var data = await apiRespository.postApiCallByFormData(url, body);
    if(data.body['status'] == 'success')
    {
      nameC.text = "";
      Get.showSnackbar(Ui.SuccessSnackBar(message: '${msgFor}d Success'));
      initializeData();
      Navigator.pop(context);
    }
    else
      {
        Get.showSnackbar(Ui.ErrorSnackBar(message: 'Error Occurred while ${msgFor}'));
      }

  }

}