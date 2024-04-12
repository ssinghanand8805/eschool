import 'dart:convert';

import 'package:learnladder/apiHelper/userData.dart';
import 'package:learnladder/presentation/login_screen/models/userDataModal.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../../dashboard/dashboard_screen.dart';
import '../model/Homework.dart';
import '../model/StudentSubjects.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class HomeWorkController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  RxString currentSelectedSubejectId = "0".obs;
  RxString status = "pending".obs;
  Rx<Homework> homeworkModelObj = Homework().obs;
  Rx<StudentSubjects> studentSubjectsModelObj = StudentSubjects().obs;
  Rx<Subjectlist> currentSelectedSubject = Subjectlist().obs;
  late Future<void> fetchDataFuture;
  late Future<void> fetchDataFutureForSubjects;
  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
    fetchDataFuture = getData();
    fetchDataFutureForSubjects = getSubjects(); // Initialize the future when the controller is created
   // Initialize the future when the controller is created
  }
  // @override
  // void initState() {
  //   studentSubjectsModelObj.value
  //
  // }


  Future<void> getSubjects()async{
    Map<String,dynamic> body = {
      "student_id" : userData.getUserStudentId };

      var data  = await apiRespository.postApiCallByJson(Constants.getstudentsubjectUrl, body);
    //
    //
    print("DATA @@@@ ${data.body}");
    studentSubjectsModelObj.value = StudentSubjects.fromJson(data.body);
   var newSubjet =  Subjectlist(
      subjectGroupSubjectsId: "0",
      subjectGroupClassSectionsId: "0",
      name: "All",
      code: "",
      subjectId: "0",
    );
    studentSubjectsModelObj.value.subjectlist!.insert(0, newSubjet);
    print("*****${studentSubjectsModelObj.value.toJson()}");
    // Map<dynamic, dynamic> jsonData = data.body;//json.decode(data.body);


  }

  Future<void> getData() async
  {
    Map<String,dynamic> body = {
      "student_id" : userData.getUserStudentId,
      "homework_status" : status.value,
      "subject_group_subject_id" : currentSelectedSubejectId.value == "0" ? "" : currentSelectedSubejectId.value
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getHomeworkUrl, body);
    print("DATA @@@@ ${data.body}");

    homeworkModelObj.value = Homework.fromJson(data.body);
    print("111111111111111111111 ${homeworkModelObj.value.toJson()}");
    update();
  }
}
