import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/userData.dart';
import '../modal/lesson_modal.dart';

class TeacherLessonPlanController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<LessonPlan> lessonPlanModelObj = LessonPlan().obs;


  Rx<TextEditingController> addLessonDate = TextEditingController().obs;
  Rx<TextEditingController> timeFrom = TextEditingController().obs;
  Rx<TextEditingController> timeTo = TextEditingController().obs;
  Rx<TextEditingController> subtopic = TextEditingController().obs;
  Rx<TextEditingController> lectureYoutubeUrl = TextEditingController().obs;
  Rx<TextEditingController> teachingMethod = TextEditingController().obs;
  Rx<TextEditingController> generalObjectives = TextEditingController().obs;
  Rx<TextEditingController> previousKnowledge = TextEditingController().obs;
  Rx<TextEditingController> comprehensiveQuestions = TextEditingController().obs;
  Rx<HtmlEditorController> presentation = HtmlEditorController().obs;

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('HH:mm').format(dateTime);
  }
  RxString dateFrom = "2024-04-08".obs;
  RxString dateTo = "2024-04-14".obs;
  final Rx<DateTime> applyDate = DateTime.now().obs;
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

  final List students = [
    {"id": 1001, "classId": "0202", "name": "Hindi"},
    {"id": 1002, "classId": "0203", "name": "English"},
    {"id": 1003, "classId": "0204", "name": "Math"},
  ];
  final List lesson = [
    {"id": 1001, "classId": "0202", "name": "Hindi"},
    {"id": 1002, "classId": "0203", "name": "English"},
    {"id": 1003, "classId": "0204", "name": "Math"},
  ];

  Future<void> getData() async
  {
    Map<String,dynamic> body = {
      "student_id" : userData.getUserStudentId,
      "date_from" : dateFrom.value,
      "date_to" : dateTo.value,
    };
    print("Body @@@@ ${body}");
    // var data  = await apiRespository.postApiCallByJson(Constants.lessonPlanUrl, body);
    // print("DATA @@@@ ${data.body}");
    // lessonPlanModelObj.value = LessonPlan.fromJson(data.body);
    // print("111111111111111111111 ${lessonPlanModelObj.value.toJson()}");
    update();
  }
}