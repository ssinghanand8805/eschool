import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import 'staff_modal.dart';

class StaffController extends GetxController{

  TextEditingController searchC = TextEditingController();
  final staffIdC = TextEditingController();
  final firstNameC = TextEditingController();
  final lastNameC = TextEditingController();
  final fatherNameC = TextEditingController();
  final motherNameC = TextEditingController();
  final emailC = TextEditingController();
  final dateOfBirthC = TextEditingController();
  final dateOfJoiningC = TextEditingController();
  final phoneC = TextEditingController();
  final emergencyContactC = TextEditingController();
  final addressC = TextEditingController();
  final permanentAddressC = TextEditingController();
  final qualificationC = TextEditingController();
  final workExperienceC = TextEditingController();
  final noteC = TextEditingController();
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx< StaffListModal> sttafListModal =  StaffListModal().obs;
  Rx<TextEditingController> attendanceDate = TextEditingController().obs;
  TextEditingController titleC = TextEditingController();
  Rx<HtmlEditorController> HtmlController = HtmlEditorController().obs;
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
      var data = await apiRespository.postApiCallByJson(Constants.getStaffList, body);

      sttafListModal.value =  StaffListModal.fromJson(data.body);
      print(sttafListModal.value.toJson());
      update();
    }
    catch(e)
    {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }


  }


}