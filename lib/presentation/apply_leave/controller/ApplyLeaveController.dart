import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learnladder/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/ApplyLeave.dart';



class ApplyLeaveController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<ApplyLeave> applyLeaveModelObj = ApplyLeave().obs;
  late Future<void> fetchDataFuture;

  final Rx<DateTime> applyDate = DateTime.now().obs;
  Rx<DateTime?> fromDate = Rx<DateTime?>(null);
  Rx<DateTime?> toDate = Rx<DateTime?>(null);
  Rx<TextEditingController> reasonController = TextEditingController().obs;
  Rx<TextEditingController> applyDateController = TextEditingController().obs;
  Rx<TextEditingController> fromDateController = TextEditingController().obs;
  Rx<TextEditingController> toDateController = TextEditingController().obs;

  Rx<File?> image = Rx<File?>(null);

  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
   fetchDataFuture = getData(); // Initialize the future when the controller is created
  }
  saveData() async
  {
    Map<String,dynamic> body = {
      "student_id" : userData.getUserStudentId,
      "apply_date" : applyDateController.value.value.text,
      "from_date" : fromDateController.value.value.text,
      "to_date" : toDateController.value.value.text,
      "reason" : reasonController.value.value.text,
      "file":image.value!.path
    };
    print("############${body}");
    var data  = await apiRespository.postApiCallByFormData(Constants.addleaveUrl, body);
  }
  Future<void> getData() async
  {
    Map<String,dynamic> body = {
      "student_id" : userData.getUserStudentId
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getApplyLeaveUrl, body);
    print("DATA @@@@ ${data.body}");
    print("111111111111111111111 ${applyLeaveModelObj.value.toJson()}");
     applyLeaveModelObj.value = ApplyLeave.fromJson(data.body);
     print("111111111111111111111 ${applyLeaveModelObj.value.toJson()}");
    update();
  }
}
