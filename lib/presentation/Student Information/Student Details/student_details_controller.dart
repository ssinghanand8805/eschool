import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/apiHelper/popular_product_repo.dart';
import 'package:http/http.dart' as http;

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/api.dart';
import '../../../apiHelper/userData.dart';
import '../../Front Office/admission _enquiry/CustomScaffoldController.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import '../../login_screen/models/Faculity.dart';
import 'DataModal.dart';

class StudentDetailsController extends GetxController{

  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());


  Rx<TextEditingController> searchC = TextEditingController().obs;

  CommonApiController commonApiController = Get.put(CommonApiController());
  late Future<void> fetchDataFuture;
  RxString selectedClassName = "".obs;
  RxString selectedSectionName = ''.obs;
  @override
  void onInit() async {
    super.onInit();
    Map<String, RxString> chipData  = {
      'Class': selectedClassName,
      'Section': selectedSectionName
    };
    CustomScaffoldController customScaffoldController = Get.put(CustomScaffoldController());
    customScaffoldController.updateChipDataList = chipData;
    customScaffoldController.watchRxStringVariables(chipData);

    fetchDataFuture = initializeData();
  }
  Future<void> initializeData() async  {
    studentDetailsList = [];

 // Initialize fetchDataFuture here
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
  List searchStudentInfoList = [];

  List<StudentDetailsDataModal> get getStudentDetailsList =>
      List<StudentDetailsDataModal>.from((searchC.value.text == ''
          ? studentDetailsList
          : studentDetailsList.where((element) => (element['firstname']
          .toString()
          .toLowerCase()
          .trim())
          .contains(searchC.value.text.toLowerCase().trim()))
      ).map((element) => StudentDetailsDataModal.fromJson(element))
      );

  set updateStudentDetailsList(List val) {
    studentDetailsList = val;
    update();
  }

  Future<void> searchStuInfo(String searchKey) async {
    Map<String, dynamic> body = {
      "searchTerm": searchKey.toLowerCase().trim(),
    };

    var data = await apiRespository.postApiCallByJson(Constants.searchStudentInfo, body);
    print("SEARCH DATA @@@@ ${data.body}");

    updateSearchStudentInfo = data.body;
  }
  set updateSearchStudentInfo(List val) {
    searchStudentInfoList = val;
    studentDetailsList = searchStudentInfoList;
    update();
  }


}