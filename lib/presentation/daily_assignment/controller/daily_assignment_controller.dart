import 'dart:convert';

import 'package:learnladder/apiHelper/userData.dart';
import 'package:learnladder/presentation/login_screen/models/userDataModal.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../../dashboard/dashboard_screen.dart';
import '../model/DailyAssignment.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class DailyAssignmentController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<AssignmentModal> assignmentModelObj = AssignmentModal().obs;

  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
    fetchDataFuture = getAssignment(); // Initialize the future when the controller is created
  }

  getAssignment()async{
    Map<String,dynamic> body = {
      "student_id" : userData.getUserStudentId };

      var data  = await apiRespository.postApiCallByJson(Constants.getdailyassignmentUrl, body);

    assignmentModelObj.value = AssignmentModal.fromJson(data.body);

    print("getdailyassignmentUrl ${data.body}");
    // //UsersData usersData = UsersData.fromJson(data.body);
    // Map<dynamic, dynamic> jsonData = data.body;//json.decode(data.body);


  }

}
