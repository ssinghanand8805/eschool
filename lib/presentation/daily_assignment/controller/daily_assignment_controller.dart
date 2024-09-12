import 'dart:convert';

import 'package:lerno/apiHelper/userData.dart';
import 'package:lerno/presentation/daily_assignment/model/student_Subject.dart';
import 'package:lerno/presentation/login_screen/models/userDataModal.dart';
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
  RxString currentSelectedSubejectId = "0".obs;
  RxString status = "pending".obs;
  Rx<AssignmentModal> homeworkModelObj = AssignmentModal().obs;
  Rx<StudentSubjects> studentSubjectsModelObj = StudentSubjects().obs;
  Rx<Subjectlist> currentSelectedSubject = Subjectlist().obs;
  late Future<void> fetchDataFuture;
  late Future<void> fetchDataFutureForSubjects;
 late  TabController tabController;
  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
    fetchDataFuture = getAssignment();
    fetchDataFutureForSubjects = getSubjects(); // Initialize the future when the controller is created
    // Initialize the future when the controller is created
  }
  // @override
  // void initState() {
  //   studentSubjectsModelObj.value
  //
  // }
  Rx<DateTime> selectedDate = DateTime.now().obs;

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)

      selectedDate.value = picked;
    getAssignment(selectedDate: selectedDate.value);
    update();
  }

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
  Future<void> getAssignment({DateTime? selectedDate}) async {
    String formattedDate = selectedDate != null
        ? "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}"
        : "";

    Map<String, dynamic> body = {
      "student_id": userData.getUserStudentId,
      "homework_status": status.value,
      "subject_group_subject_id": currentSelectedSubejectId.value == "0"
          ? ""
          : currentSelectedSubejectId.value,
      "date": formattedDate // Pass the formatted date if provided
    };

    print("Body @@@@ $body");

    var data = await apiRespository.postApiCallByJson(Constants.getAssignment, body);

    print("DATA @@@@ ${data.body}");

    homeworkModelObj.value = AssignmentModal.fromJson(data.body);
    print("homework data ${homeworkModelObj.value.toJson()}");


    if (homeworkModelObj.value.homeworklist != null && selectedDate != null) {
      homeworkModelObj.value.homeworklist = homeworkModelObj.value.homeworklist!
          .where((homework) =>
      homework.homeworkDate == formattedDate) // Compare the string format
          .toList();
      update();
    }

    print("Filtered homework list: ${homeworkModelObj.value.homeworklist}");
    // update();
  }


}
