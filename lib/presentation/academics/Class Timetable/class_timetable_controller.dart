import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../../../apiHelper/popular_product_repo.dart';
import '../../../../apiHelper/userData.dart';
import 'class_timetable_modal.dart';

class ClassTimetableController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<ClassTimetableModal> lessonPlanModelObj = ClassTimetableModal().obs;
  Rx<TextEditingController> startTimeC = TextEditingController().obs;
  Rx<TextEditingController> durationC = TextEditingController().obs;
  Rx<TextEditingController> intervalC = TextEditingController().obs;
  Rx<TextEditingController> roomNoC = TextEditingController().obs;
  Rx<TextEditingController> AddMoreController = TextEditingController().obs;
  List<TextEditingController> controllers = [];

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('HH:mm').format(dateTime);
  }
  RxString dateFrom = "2024-04-08".obs;
  RxString dateTo = "2024-04-14".obs;
  final Rx<DateTime> applyDate = DateTime.now().obs;
   Future<void> ? fetchDataFuture;
  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
 //  fetchDataFuture = getData(); // Initialize the future when the controller is created
  }

  final List lesson = [
    {"id": 1001, "classId": "0202", "name": "Hindi"},
    {"id": 1002, "classId": "0203", "name": "English"},
    {"id": 1003, "classId": "0204", "name": "Math"},
  ];



  List<Map<String, dynamic>> lessonTopics = [
    {
      'title': '1. झूला',
      'subtopics': [
        {'title': 'कार्यालयी की व्याख्या', 'isChecked': false},
        {'title': 'प्रश्न-अभ्यास', 'isChecked': false},
        {'title': 'बाटचीत :', 'isChecked': false},
      ]
    },
    {
      'title': ' 2. आप की कहानी',
      'subtopics': [
        {'title': 'विकेत्ता का सारांश', 'isChecked': false},
        {'title': 'प्रश्न-अभ्यास', 'isChecked': false},
      ]
    },
    {
      'title': '3. आम की टोकरी ',
      'subtopics': [
        {'title': 'कविता का सारांश', 'isChecked': false},
        {'title': 'कार्यालयी की व्याख्या', 'isChecked': false},
      ]
    },
  ];


  List<Map<String, dynamic>> data = [
    {
      'studentId': 18001,
      'class': 'Class 4',
      'section': 'A',
      'subjectGroup': 'Class 1st Subject Group',
      'subjects': ['Hindi (230)', 'Math (231)', 'English (235)', 'Science (232)'],
      'lesson': "A Happy Child",
      'submissionDate': DateTime(2024, 4, 9),
      'evaluationDate': DateTime(2024, 4, 9),
      'createdBy': 'Joe Black',
      'approvedId': 9000,
    },
    {
      'studentId': 18002,
      'class': 'Class 4',
      'section': 'A',
      'subjectGroup': 'Class 1st Subject Group',
      'subjects': ['Hindi (230)', 'Math (231)', 'English (235)', 'Science (232)'],
      'lesson': "A Kite (Poem)",
      'submissionDate': DateTime(2024, 4, 9),
      'evaluationDate': DateTime(2024, 4, 9),
      'createdBy': 'Kirti Singh',
      'approvedId': 9000,
    },
    // Add more data as needed
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