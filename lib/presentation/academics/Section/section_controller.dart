import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Section/section_modal.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';

class SectionController extends GetxController{
  Rx<TextEditingController> sectionC = TextEditingController().obs;
  Rx<TextEditingController> searchC = TextEditingController().obs;
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx< SectionListDataModal> sectionList =  SectionListDataModal().obs;
  void onInit() {
    super.onInit();
    sectionListData();
  }



  sectionListData() async {
  try
  {
  var body = {};
  var data = await apiRespository.postApiCallByJson(Constants.getSectionList, body);
  print("Section List: ${data.body}");

  sectionList.value =  SectionListDataModal.fromJson(data.body);
  print(sectionList.value.toJson());
  update();
  }
  catch(e)
  {
  print("EEEEEEEEEEEEEEEEEEEE${e}");
  update();
  }
  }
  // Future<void> editSection(int id, String newSectionName) async {
  //   try {
  //     // Simulate API call for editing a section
  //     await Future.delayed(Duration(seconds: 1));
  //
  //     // Replace this with actual API call
  //     final index = sectionList.indexWhere((section) => section.id == id);
  //     if (index != -1) {
  //       sectionList[index].section = newSectionName;
  //       sectionList.refresh();
  //     }
  //   } catch (e) {
  //     print("Error editing section: $e");
  //   }
  // }

  Future<void> deleteSection(int id) async {
    try {

      await Future.delayed(Duration(seconds: 1));

      //sectionList!.removeWhere((section) => section.id == id);
      sectionList.refresh();
    } catch (e) {
      print("Error deleting section: $e");
    }
  }
}

