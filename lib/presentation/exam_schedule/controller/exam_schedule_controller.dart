import 'dart:convert';

import 'package:lerno/apiHelper/userData.dart';
import 'package:lerno/presentation/login_screen/models/userDataModal.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../../dashboard/dashboard_screen.dart';
import '../model/Examschedule.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class ExamScheduleController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<ExamSchedule> examScheduleModelObj = ExamSchedule().obs;

  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
    fetchDataFuture = getExamSchedule();
  }

  getExamSchedule()async{
    var body = {
      "student_session_id" : userData.getStudent_session_id };

    print("nkjnjnjnjnjn${userData.getStudent_session_id}");

      var data  = await apiRespository.postApiCallByJson(Constants.getCbseexamtimetableUrl, body);

      print("vsvsgsgvvsgv${body}");
      print("vsvsgsgvvsgv${data.body}");
if(data.statusCode == 200 && data.body.length > 0)
  {
    print("ggggg");
    examScheduleModelObj.value = ExamSchedule.fromJson(data.body);
    print(examScheduleModelObj.value.toJson());
    update();
  }
else
  {

  }


    print("getCbseexamtimetableUrl ${data.body}");


  }

}
