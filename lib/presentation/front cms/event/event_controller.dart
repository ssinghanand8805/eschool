import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import 'event_modal.dart';

class EventController extends GetxController{

  TextEditingController searchC = TextEditingController();
  TextEditingController titleC = TextEditingController();
  Rx<TextEditingController> eventStartDate = TextEditingController().obs;
  Rx<TextEditingController> eventEndDate = TextEditingController().obs;
  Rx<HtmlEditorController> HtmlController = HtmlEditorController().obs;
  TextEditingController venueC = TextEditingController();
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx< EventModal> eventModalList =  EventModal().obs;
  Rx<TextEditingController> attendanceDate = TextEditingController().obs;
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

  Future<void> initializeData() async  {
    //isLoading.value = true;
    try
    {
      var body = {};
      var data = await apiRespository.postApiCallByJson(Constants.getEventList, body);

      eventModalList.value =  EventModal.fromJson(data.body);
      print(eventModalList.value.toJson());
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
          Constants.deleteEventList, body);

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