import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/apiHelper/toastMessage.dart';


import '../../../../apiHelper/popular_product_repo.dart';
import '../../../../apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import 'SubjectGroup.dart';
import 'class_timetable_modal.dart';

class ClassTimetableController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<CLassTimeTable> classTimeTableList = CLassTimeTable().obs;
  var dayWiseRecords = <String, List<Record>>{}.obs;
  RxList<SubjectGroup> subjectGroupList = <SubjectGroup>[].obs;
  Rx<TextEditingController> startTimeC = TextEditingController().obs;
  Rx<TextEditingController> durationC = TextEditingController().obs;
  Rx<TextEditingController> intervalC = TextEditingController().obs;
  Rx<TextEditingController> roomNoC = TextEditingController().obs;
  Rx<TextEditingController> AddMoreController = TextEditingController().obs;
  List<TextEditingController> controllers = [];
  Rx<String> selectedSubjectGroupId = "".obs;
  RxBool isSelectedClassSubject = RxBool(false);
  Rx<TimeTableList> timeTableList = TimeTableList().obs;
  var selectedDay = 'Monday'.obs;
  void updateSelectedDay(String day) {
    selectedDay.value = day;
  }
  // Method to get records based on selected day
  List<Record>? getRecordsForSelectedDay() {
    switch (selectedDay.value) {
      case 'Monday':
        var p = timeTableList.value.dayWisePriviousRecord?.monday?.record;
        if (p == null || p.isEmpty) {
          p = [
            Record(
              subjectGroupSubjectId: "0", // default or empty values
              staffId: "0",
              timeFrom: '',
              timeTo: '',
              roomNo: '',
            )
          ];
        }
        timeTableList.value.dayWisePriviousRecord?.monday?.record = p;
        return p;
      case 'Tuesday':
        var p = timeTableList.value.dayWisePriviousRecord?.tuesday?.record;
        if (p == null || p.isEmpty) {
          p = [
            Record(
              subjectGroupSubjectId: "0", // default or empty values
              staffId: "0",
              timeFrom: '',
              timeTo: '',
              roomNo: '',
            )
          ];
        }
        timeTableList.value.dayWisePriviousRecord?.tuesday?.record = p;
        return p;
      case 'Wednesday':
        var p = timeTableList.value.dayWisePriviousRecord?.wednesday?.record;
        if (p == null || p.isEmpty) {
          p = [
            Record(
              subjectGroupSubjectId: "0", // default or empty values
              staffId: "0",
              timeFrom: '',
              timeTo: '',
              roomNo: '',
            )
          ];
        }
        timeTableList.value.dayWisePriviousRecord?.wednesday?.record = p;
        return p;
      case 'Thursday':
        var p = timeTableList.value.dayWisePriviousRecord?.thursday?.record;
        if (p == null || p.isEmpty) {
          p = [
            Record(
              subjectGroupSubjectId: "0", // default or empty values
              staffId: "0",
              timeFrom: '',
              timeTo: '',
              roomNo: '',
            )
          ];
        }
        timeTableList.value.dayWisePriviousRecord?.thursday?.record = p;
        return p;
      case 'Friday':
        var p = timeTableList.value.dayWisePriviousRecord?.friday?.record;
        if (p == null || p.isEmpty) {
          p = [
            Record(
              subjectGroupSubjectId: "0", // default or empty values
              staffId: "0",
              timeFrom: '',
              timeTo: '',
              roomNo: '',
            )
          ];
        }
        timeTableList.value.dayWisePriviousRecord?.friday?.record = p;
        return p;
      case 'Saturday':
        var p = timeTableList.value.dayWisePriviousRecord?.saturday?.record;
        if (p == null || p.isEmpty) {
          p = [
            Record(
              subjectGroupSubjectId: "0", // default or empty values
              staffId: "0",
              timeFrom: '',
              timeTo: '',
              roomNo: '',
            )
          ];
        }
        timeTableList.value.dayWisePriviousRecord?.saturday?.record = p;
        return p;
      case 'Sunday':
        var p = timeTableList.value.dayWisePriviousRecord?.sunday?.record;
        if (p == null || p.isEmpty) {
          p = [
            Record(
              subjectGroupSubjectId: "0", // default or empty values
              staffId: "0",
              timeFrom: '',
              timeTo: '',
              roomNo: '',
            )
          ];
        }
        timeTableList.value.dayWisePriviousRecord?.sunday?.record = p;
        return p;
      default:
        return null;
    }
  }
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
  TimeOfDay formatTimeFromDatabase(String time) {
    if (time.isEmpty) {
      return TimeOfDay.now(); // Return current time if the string is empty
    }

    // Trim the time string to remove any leading/trailing spaces
    time = time.trim().toUpperCase();

    // Check if the time string contains AM or PM
    bool isPM = time.endsWith("PM");
    bool isAM = time.endsWith("AM");

    // Remove AM/PM from the time string
    if (isPM || isAM) {
      time = time.substring(0, time.length - 2).trim();
    }

    final timeParts = time.split(":");
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    // Convert to 24-hour format if necessary
    if (isPM && hour < 12) {
      hour += 12;
    } else if (isAM && hour == 12) {
      hour = 0;
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  String formatTimeForDisplay(String time) {
    TimeOfDay timeOfDay = formatTimeFromDatabase(time);
    return timeOfDay.format(Get.context!); // Format according to local time settings
  }


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
      'subject': 'Class',
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
      'subject': 'Class 4',
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
    {
      'studentId': 18002,
      'class': 'Class 4',
      'subject': 'Class 4',
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

  Rx<TextEditingController> timeFromC = TextEditingController().obs;
  Rx<TextEditingController> timeTo = TextEditingController().obs;
  Rx<TextEditingController> roomNumberC = TextEditingController().obs;

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

  final List<String> days = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  String isTapped = "Monday";
  String get getIsTapped => isTapped;
  set updateIsTapped(String val){
    isTapped = val;
    update();
  }



  filterData() async {

    CommonApiController commonApiController = Get.put(CommonApiController());
    print(commonApiController.selectedClassId.value);
    print(commonApiController.selectedSectionId.value);

    if(commonApiController.selectedClassId.value.isNotEmpty && commonApiController.selectedSectionId.value.isNotEmpty)
    {


      var body = {
        "class_id": commonApiController.selectedClassId.value,
        "section_id": commonApiController.selectedSectionId.value
      };
      print("Body @@@@ ${body}");
      var data = await apiRespository.postApiCallByJson(
          Constants.getClasstimetablelistUrl, body);
      print("DATA @@@@ ${data.body}");
      classTimeTableList.value = CLassTimeTable.fromJson(data.body);
      // approveLeaveList.value.assignAll(ss.resultlist!);
      //
      // filteredStudentListModel.assignAll(ss.resultlist!);

      update();
    }
    else
    {
      print("Filter Data not valid");
    }


  }
getCreateListData() async {

    CommonApiController commonApiController = Get.put(CommonApiController());
    print(commonApiController.selectedClassId.value);
    print(commonApiController.selectedSectionId.value);

    if(commonApiController.selectedClassId.value.isNotEmpty && commonApiController.selectedSectionId.value.isNotEmpty && selectedSubjectGroupId.value.isNotEmpty)
    {


      var body = {
        "class_id": commonApiController.selectedClassId.value,
        "section_id": commonApiController.selectedSectionId.value,
        "subject_group_id": selectedSubjectGroupId.value
      };
      print("Body @@@@ ${body}");
      var data = await apiRespository.postApiCallByJson(
          Constants.getTimetablecreateUrl, body);
      print("DATA @@@@ ${data.body}");
      timeTableList.value = TimeTableList.fromJson(data.body);


      isSelectedClassSubject.value = true;
      // approveLeaveList.value.assignAll(ss.resultlist!);
      //
      // filteredStudentListModel.assignAll(ss.resultlist!);

      update();
    }
    else
    {
      print("Filter Data not valid");
    }


  }


  Map<String, List<Record>?> getAllDayRecords() {
    return {
      'Monday': timeTableList.value.dayWisePriviousRecord?.monday?.record,
      'Tuesday': timeTableList.value.dayWisePriviousRecord?.tuesday?.record,
      'Wednesday': timeTableList.value.dayWisePriviousRecord?.wednesday?.record,
      'Thursday': timeTableList.value.dayWisePriviousRecord?.thursday?.record,
      'Friday': timeTableList.value.dayWisePriviousRecord?.friday?.record,
      'Saturday': timeTableList.value.dayWisePriviousRecord?.saturday?.record,
      'Sunday': timeTableList.value.dayWisePriviousRecord?.sunday?.record,
    };
  }
  List<Record> getAllRecords() {
    List<Record> allRecords = [];

    // Collect records for each day and add them to the allRecords list
    allRecords.addAll(timeTableList.value.dayWisePriviousRecord?.monday?.record ?? []);
    allRecords.addAll(timeTableList.value.dayWisePriviousRecord?.tuesday?.record ?? []);
    allRecords.addAll(timeTableList.value.dayWisePriviousRecord?.wednesday?.record ?? []);
    allRecords.addAll(timeTableList.value.dayWisePriviousRecord?.thursday?.record ?? []);
    allRecords.addAll(timeTableList.value.dayWisePriviousRecord?.friday?.record ?? []);
    allRecords.addAll(timeTableList.value.dayWisePriviousRecord?.saturday?.record ?? []);
    allRecords.addAll(timeTableList.value.dayWisePriviousRecord?.sunday?.record ?? []);

    return allRecords;
  }


// Save method to process the records
  Future<void> saveDayWiseRecords() async {
    var allDayRecords =  getAllDayRecords();

    Map<String, dynamic> jsonDayWiseRecords = {};

    allDayRecords.forEach((day, records) {
      if (records != null && records.isNotEmpty) {
        jsonDayWiseRecords[day] = records.map((record) => record.toJson()).toList();
      }
    });


    var body = {
      "saveJson": jsonDayWiseRecords
    };

    var data = await apiRespository.postApiCallByJson(
        Constants.getSaveNewTimeTableUrl, body);
    if(data.statusCode == 200)
      {
        Get.showSnackbar(Ui.SuccessSnackBar(message: 'Saved Success'));
      }
    else if(data.statusCode == -1)
      {
        Get.showSnackbar(Ui.ErrorSnackBar(message: 'No Internet'));
      }
    else if(data.statusCode == -2)
    {
      Get.showSnackbar(Ui.ErrorSnackBar(message: 'Something went wrong ! please try again'));
    }
    else
    {
      Get.showSnackbar(Ui.ErrorSnackBar(message: data.statusText.toString()));
    }

    // print("DATA @@@@ ${data.body}");

    // var d = jsonEncode(jsonDayWiseRecords);
    // log(d);
  }
  Future<void> getSubjectGroup() async {
    CommonApiController commonApiController = Get.put(CommonApiController());
    print(commonApiController.selectedClassId.value);
    print(commonApiController.selectedSectionId.value);

    if(commonApiController.selectedClassId.value.isNotEmpty && commonApiController.selectedSectionId.value.isNotEmpty)
    {


      var body = {
        "class_id": commonApiController.selectedClassId.value,
        "section_id": commonApiController.selectedSectionId.value
      };
      print("Body @@@@ ${body}");
      var data = await apiRespository.postApiCallByJson(
          Constants.getSubjectGroupByClassSectionUrl, body);
      print("DATA @@@@ ${data.body}");
      data.body.forEach((v) {
        subjectGroupList.value!.add(new SubjectGroup.fromJson(v));
      });

      update();
    }
    else
    {
      print("Filter Data not valid");
    }
  }


}