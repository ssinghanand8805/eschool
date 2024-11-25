import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import 'media_manager_modal.dart';

class MediaManagerController extends GetxController {
  TextEditingController searchC = TextEditingController();
  TextEditingController titleC = TextEditingController();

  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<MediaManagerModal> mediaManagerList = MediaManagerModal().obs;
  Rx<MediaTypeListModal> mediaType = MediaTypeListModal().obs;
  List<dynamic> listToSearch = [];
  Rx<TextEditingController> attendanceDate = TextEditingController().obs;
  Rx<File?> pickedFile = Rx<File?>(null);
  late Future<void> fetchDataFuture;
  List<Data> originalContentTypeList = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    super.onInit();
    fetchDataFuture = initializeData();
    getMediaType();
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

  Future<void> initializeData() async {
    try {
      var body = {};
      var data = await apiRespository.postApiCallByJson(
          Constants.getAllMediaList, body);

      mediaManagerList.value = MediaManagerModal.fromJson(data.body);
      print(mediaManagerList.value.toJson());
      update();
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }



  Future<void> getMediaType() async {
    try {
      var body = {};
      var data = await apiRespository.postApiCallByJson(
          Constants.getMediaTypeList, body);

      mediaType.value = MediaTypeListModal.fromJson(data.body);

       listToSearch = data.body['data']['mediaTypes']?.entries
          .map((entry) => {"key": entry.key, "value": entry.value})
          .toList() ??
          [];

print("LIST TO SEARCH ${listToSearch}");

      print(mediaType.value.data!.mediaTypes);
      update();
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

  deleteEvent(context, recordId) async {
    try {
      var body = {"record_id": recordId};
      var data = await apiRespository.postApiCallByFormData(
          Constants.deleteMediaItem, body);

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
