import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import 'news_modal.dart';

class  NewsController extends GetxController{

  TextEditingController searchC = TextEditingController();
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx< NoticeModal> noticeModalList =  NoticeModal().obs;
  Rx<TextEditingController> dateC = TextEditingController().obs;

  TextEditingController titleC = TextEditingController();
  Rx<HtmlEditorController> HtmlController = HtmlEditorController().obs;
  RxString featureImage = "".obs;
  Rx<File?> pickedFile = Rx<File?>(null);
  late Future<void> fetchDataFuture;
  List<Data> originalContentTypeList = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    super.onInit();
    fetchDataFuture = initializeData();
  }
  // void initializeOriginalList() {
  //   originalContentTypeList = List.from(filteredContentTypeList.value.data!);  // Make a copy of the original data
  // }
  // Future<void> searchContentType(String searchKey) async {
  //   // Check if the searchKey is empty or not
  //   if (searchKey.isEmpty) {
  //     // Reset to the original list when searchKey is cleared
  //     filteredContentTypeList.update((val) {
  //       val?.data = originalContentTypeList;  // Reset to original list
  //     });
  //   } else {
  //     // Filter the list based on the searchKey
  //     List<Data> filteredList = originalContentTypeList
  //         .where((element) => element.name != null &&
  //         element.name!.toLowerCase().contains(searchKey.toLowerCase().trim()))  // Perform case-insensitive search
  //         .toList();
  //
  //     // Update the filtered list
  //     filteredContentTypeList.update((val) {
  //       val?.data = filteredList;
  //     });
  //   }
  // }
  addNews(
      context,
      ) async {
    try {
      var description = await HtmlController.value.getText();
      DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(dateC.value.text.toString());
      String formattedDate = await GlobalData().ConvertToSchoolDateTimeFormat(parsedDate);
      var formData = {
        "title": titleC.value.text,
        "description": description,
        "date":formattedDate,
        "image":featureImage.value
      };

      var data = await apiRespository.postApiCallByFormData(
          Constants.createNoticeList, formData);

      print("formData @${formData}");
      print("data @${data.body}");

      if (data.body['status'] == 1) {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: data.body['msg'].toString()));
        initializeData();
      } else {

        Get.showSnackbar(
            Ui.ErrorSnackBar(message: data.body['msg'].toString()));

      }
    } catch (e) {
      print("error: ${e}");
      update();
    }
  }
  Future<void> initializeData() async  {
    //isLoading.value = true;
    DateTime now = DateTime.now();
    var d =  await GlobalData().ConvertToSchoolDateTimeFormat(now);
    dateC.value.text = d;
    try
    {
      var body = {};
      var data = await apiRespository.postApiCallByJson(Constants.getNoticeList, body);

      noticeModalList.value =  NoticeModal.fromJson(data.body);
      print(noticeModalList.value.toJson());
      // initializeOriginalList();
      update();
    }
    catch(e)
    {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

  deleteEvent(context, slug) async {
    try {
      var body = {"slug": slug};
      var data = await apiRespository.postApiCallByFormData(
          Constants.deleteNoticeList, body);

      if (data.body['status'] == 1) {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: data.body['msg'].toString()));
        initializeData();
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: data.body['msg'].toString()));
      }
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

}