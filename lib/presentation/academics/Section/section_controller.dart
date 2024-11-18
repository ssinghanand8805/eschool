import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Section/section_modal.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';

class SectionController extends GetxController {
  Rx<TextEditingController> sectionC = TextEditingController().obs;
  Rx<TextEditingController> newSectionC = TextEditingController().obs;
  Rx<TextEditingController> searchC = TextEditingController().obs;
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<SectionListDataModal> sectionList = SectionListDataModal().obs;

  late Future<void> fetchDataFuture;
  void onInit() {
    super.onInit();
    fetchDataFuture = sectionListData();
  }


  // Future<void> searchContentType(String searchKey) async {
  //   // Check if the searchKey is empty or not
  //   if (searchKey.isEmpty) {
  //     // Reset to the original list when searchKey is cleared
  //     sectionList.update((val) {
  //       val?.data!.sectionlist = originalContentTypeList; // Reset to original list
  //     });
  //   } else {
  //     // Filter the list based on the searchKey
  //     List<SectionListDataModal> filteredList = originalContentTypeList
  //         .where((element) =>
  //     element.bookTitle != null &&
  //         element.bookTitle!.toLowerCase().contains(searchKey.toLowerCase().trim())) // Perform case-insensitive search
  //         .toList();
  //
  //     // Update the filtered list
  //     sectionList.update((val) {
  //       val!.data!.sectionlist = filteredList;
  //     });
  //   }
  // }

  sectionListData() async {
    try {
      var body = {};
      var data = await apiRespository.postApiCallByJson(
          Constants.getSectionList, body);
      print("Section List: ${data.body}");

      sectionList.value = SectionListDataModal.fromJson(data.body);
      print(sectionList.value.toJson());
      update();
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

  Future<void> addSection() async {
    try {
      var body = {
        "section": newSectionC.value.text,
      };
      var data = await apiRespository.postApiCallByFormData(
          Constants.addSectionList, body);

      if (data.body['status'] == 1) {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: data.body['msg'].toString()));
        sectionList.refresh();
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: data.body['msg'].toString()));
      }
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

  Future<void> editSection(String id, String newSectionName) async {
    try {
      var body = {
        "id": id,
        "section": newSectionName,
      };
      var data = await apiRespository.postApiCallByFormData(
          Constants.editSectionList, body);

      if (data.body['status'] == 1) {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: data.body['msg'].toString()));
        sectionList.refresh();
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: data.body['msg'].toString()));
      }
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

  deleteSection(context, id) async {
    try {
      var body = {"id": id};
      var data = await apiRespository.postApiCallByFormData(
          Constants.deleteSectionList, body);

      if (data.body['status'] == 1) {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: data.body['msg'].toString()));
        sectionList.refresh();
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
