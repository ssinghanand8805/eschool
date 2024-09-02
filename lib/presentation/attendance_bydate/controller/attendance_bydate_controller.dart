import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../apiHelper/Constants.dart';
import '../../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/userData.dart';
import '../../add_homework/model/addHomework.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import '../../common_widgets/controller/CommonController.dart';
import '../../student_attendence/model/Student_Attendance.dart';



class AttendanceByDateController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<String> year = "".obs;
  Rx<String> month = "".obs;
   Rx<Attendance> attendanceModelObj = Attendance().obs;
  Rx<TextEditingController> attendanceDate = TextEditingController().obs;
  RxMap<DateTime, List<Event>> _kEventSource = <DateTime, List<Event>>{}.obs;
  final Rx<LinkedHashMap<DateTime, List<Event>>> kEvents = Rx<LinkedHashMap<DateTime, List<Event>>>(LinkedHashMap());
  Rx<bool> isLoadingStudentList = false.obs;
  Rx<bool> isSearchExpand = true.obs;
  RxList<Resultlist> studentReportListModel = <Resultlist>[].obs;
  late Future<void> fetchDataFuture;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<Resultlist> filteredStudentListModel = <Resultlist>[].obs;
  @override
  void onClose() {
    super.onClose();

  }

  final Rx<DateTime> applyDate = DateTime.now().obs;
  final List students = [
    {"id": 1001, "classId": "0202", "name": "Hudson1"},
    {"id": 1002, "classId": "0203", "name": "Hudson2"},
    {"id": 1003, "classId": "0204", "name": "Hudson2"},
  ];
  // Retrieve events by date
  List<Event>? getEvents(DateTime date) {
    // print("##################${date}");
    return kEvents.value[date];
  }
  @override
  void onInit() {
    super.onInit();
    searchController.value.addListener(() {
      filterStudentList();
    });
    kEvents.value = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_kEventSource.value);
    DateTime now = DateTime.now();
    getData();
 // Initialize the future when the controller is created
  }
  void filterStudentList() {
    final query = searchController.value.text.toLowerCase();

    if (query.isEmpty) {
      filteredStudentListModel.assignAll(studentReportListModel);
      print("all List Length: ${studentReportListModel.value.length}");
    } else {
      final filteredList = studentReportListModel.where((student) {
        return student.firstname?.toLowerCase().contains(query) ?? false;
      }).toList();

      print("Filtered List Length: ${filteredList.length}"); // Debugging line

      filteredStudentListModel.assignAll(filteredList);
    }

    update();
  }
  Future<void> getFilterData() async {
    CommonController controller2 =
    Get.put(CommonController());
    CommonApiController commonApiController = Get.put(CommonApiController());
    print(commonApiController.selectedClassId.value);
    print(commonApiController.selectedSectionId.value);
    print(attendanceDate.value.text.toString());
    if(commonApiController.selectedClassId.value.isNotEmpty && commonApiController.selectedSectionId.value.isNotEmpty && attendanceDate.value.text.toString().isNotEmpty)
      {
        DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(attendanceDate.value.text.toString());
        String formattedDate = DateFormat("MM/dd/yyyy").format(parsedDate);
        var body = {
          "class_id": commonApiController.selectedClassId.value,
          "section_id": commonApiController.selectedSectionId.value,
          "date": formattedDate,
          "holiday": "",
          "search": "search"
        };
        print("Body @@@@ ${body}");
        var data = await apiRespository.postApiCallByJson(
            Constants.getstudentAttendenceUrl, body);
        print("DATA @@@@ ${data.body}");
        StudentAttendence ss = StudentAttendence.fromJson(data.body);
        // Assign the result list to studentListModel and filteredStudentListModel
        studentReportListModel.assignAll(ss.resultlist!);
        filteredStudentListModel.assignAll(ss.resultlist!);

        // Debugging to ensure data is loaded correctly
        print("studentListModel Length: ${studentReportListModel.length}");
        print("filteredStudentListModel Length: ${filteredStudentListModel.length}");
        controller2.isSearchExpand.value = true;

        update();
      }
    else
      {
        print("Filter Data not valid");
      }

  }


  setMonthAndYear()
  {
    year.value = "";
    month.value = "";
    update();
  }
  Future<void> getData() async {
    CommonApiController controller3 = Get.put(CommonApiController());
    controller3.getClassList();
    update();
  }
  Future<void> getData2(String year,String month) async
  {
    Map<String,dynamic> body = {
      "student_id" : userData.getUserStudentId,
      "year":year,
      "month":month,
      "date":"",
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getAttendenceRecordsUrl, body);
    print("DATA @@@@ ${data.body}");
    attendanceModelObj.value = Attendance.fromJson(data.body);
    if(attendanceModelObj.value.data!.length > 0)
      {
        var eventsSource = attendanceModelObj.value.data!;
        for (var eventData in eventsSource) {
          DateTime date = DateTime.parse(eventData.date!);
          String type = eventData.type!;

          // Check if the date is already in the map, if not, initialize it
          _kEventSource.putIfAbsent(date, () => []);

          // Add the event to the list for this date
          _kEventSource[date]?.add(Event('$type'));
        }
      }
    kEvents.value = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_kEventSource.value);
     print("111111111111111111111 ${kEvents}");
    update();
  }
  // final kEvents = LinkedHashMap<DateTime, List<Event>>(
  //   equals: isSameDay,
  //   hashCode: getHashCode,
  // )..addAll(_kEventSource);
  // Map<DateTime, List<Event>> _kEventSource = {};

  // final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
  //     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
  //     value: (item) => List.generate(
  //         item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  //   ..addAll({
  //     kToday: [
  //       Event('Today\'s Event 1'),
  //       Event('Today\'s Event 2'),
  //     ],
  //   });
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
