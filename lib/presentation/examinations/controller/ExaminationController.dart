import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lerno/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/Examination.dart';




class ExaminationController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
   Rx<ExamListModel> examListObj = ExamListModel().obs;
  late Future<void> fetchDataFuture;




  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
   fetchDataFuture = getData(); // Initialize the future when the controller is created
  }
  Future<void> refreshDataVideo() async {
    await getData(); // Assuming getData fetches and updates the list
    update(); // This triggers a UI update if using GetX for state management
  }

  Future<void> getData() async
  {
    Map<String,dynamic> body = {
      "student_id" : userData.getUserStudentId
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getExamListUrl, body);
    print("DATA @@@@ ${data.body}");
    // print("111111111111111111111 ${applyLeaveModelObj.value.toJson()}");
    examListObj.value = ExamListModel.fromJson(data.body);
    //  print("111111111111111111111 ${applyLeaveModelObj.value.toJson()}");
    update();
  }
}
