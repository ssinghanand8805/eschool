import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/apiHelper/popular_product_repo.dart';
import 'package:http/http.dart' as http;

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/api.dart';
import '../../../apiHelper/userData.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import '../../login_screen/models/Faculity.dart';
import 'DataModal.dart';

class StudentDetailsController extends GetxController{

  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());


  Rx<TextEditingController> searchC = TextEditingController().obs;

  CommonApiController commonApiController = Get.put(CommonApiController());


  @override
  void onInit() async {
    super.onInit();
  }



  studentByClassSection() async {

    Map<String, dynamic> body = {
      "class_id" : commonApiController.selectedClassId.value,
      "section_id":commonApiController.selectedSectionId.value
    };

    var data = await apiRespository.postApiCallByJson(Constants.studentDetails, body);

    print("DATA @@@@ ${data.body}");

    updateStudentDetailsList = data.body;

  }


  List studentDetailsList = [];
  List<StudentDetailsDataModal> get getStudentDetailsList =>
      List<StudentDetailsDataModal>.from(((searchC.value.text == ''
          ? studentDetailsList
          : studentDetailsList.where((element) => (element['firstname']
          .toString()
          .toLowerCase()
          .trim())
          .trim()
          .contains(
          searchC.value.text.toLowerCase().trim())))
          .map((element) => StudentDetailsDataModal.fromJson(element))));
  set updateStudentDetailsList(List val){
    studentDetailsList = val;
    update();
  }

  searchStuInfo(searchKey) async {
    Map<String, dynamic> body = {
      "searchTerm":searchKey.toLowerCase().trim(),
    };
    var data = await apiRespository.postApiCallByJson(Constants.searchStudentInfo, body);

    print("SEARCHDATA @@@@ ${data.body}");

    updateSearchStudentInfo = data.body;
  }

  List searchStudentInfoList = [];
  List<StudentDetailsDataModal> get getSearchStudentInfoList =>
      List<StudentDetailsDataModal>.from(((searchC.value.text == ''
          ? searchStudentInfoList
          : searchStudentInfoList.where((element) => (element['firstname']
          .toString()
          .toLowerCase()
          .trim())
          .trim()
          .contains(
          searchC.value.text.toLowerCase().trim())))
          .map((element) => StudentDetailsDataModal.fromJson(element))));
  set updateSearchStudentInfo(List val){
    studentDetailsList = val;
    update();
  }


}