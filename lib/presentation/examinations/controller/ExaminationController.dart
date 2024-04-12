import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learnladder/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';




class ExaminationController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  // Rx<ApplyLeave> applyLeaveModelObj = ApplyLeave().obs;
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

  Future<void> getData() async
  {
    Map<String,dynamic> body = {
      "student_id" : userData.getUserStudentId
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getApplyLeaveUrl, body);
    print("DATA @@@@ ${data.body}");
    // print("111111111111111111111 ${applyLeaveModelObj.value.toJson()}");
    //  applyLeaveModelObj.value = ApplyLeave.fromJson(data.body);
    //  print("111111111111111111111 ${applyLeaveModelObj.value.toJson()}");
    update();
  }
}
