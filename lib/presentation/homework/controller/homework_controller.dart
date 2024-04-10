import 'dart:convert';

import 'package:anand_s_application1/apiHelper/userData.dart';
import 'package:anand_s_application1/presentation/login_screen/models/userDataModal.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../../dashboard/dashboard_screen.dart';
import '../model/Homework.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class HomeWorkController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  RxInt currentSelectedSubejectId = 0.obs;
  RxString status = "pending".obs;
  Rx<Homework> homeworkModelObj = Homework().obs;

  @override
  void onClose() {
    super.onClose();

  }


  getSubjects(context)async{
    Map<String,dynamic> body = {
      "student_id" : userData.getUserStudentId };

      var data  = await apiRespository.postApiCallByJson(Constants.getstudentsubjectUrl, body);
    //
    //
    print("DATA @@@@ ${data.body}");
    // //UsersData usersData = UsersData.fromJson(data.body);
    // Map<dynamic, dynamic> jsonData = data.body;//json.decode(data.body);


  }

  getData(context) async
  {
    Map<String,dynamic> body = {
      "student_id" : userData.getUserStudentId,
      "homework_status" : status.value,
      "subject_group_subject_id" : currentSelectedSubejectId.value == 0 ? "" : currentSelectedSubejectId.value
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getHomeworkUrl, body);
    print("DATA @@@@ ${data.body}");
    homeworkModelObj.value = Homework.fromJson(data.body);
    print("111111111111111111111 ${homeworkModelObj.value.toJson()}");
    update();
  }
}
