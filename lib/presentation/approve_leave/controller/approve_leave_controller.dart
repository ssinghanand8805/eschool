import 'dart:collection';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../apiHelper/Constants.dart';
import '../../../../apiHelper/popular_product_repo.dart';
import '../../../../apiHelper/userData.dart';
import '../model/ApproveLeave.dart';



class ApproveLeaveController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<String> year = "".obs;
  Rx<String> month = "".obs;
   Rx<Attendance> attendanceModelObj = Attendance().obs;
  RxMap<DateTime, List<Event>> _kEventSource = <DateTime, List<Event>>{}.obs;
  final Rx<LinkedHashMap<DateTime, List<Event>>> kEvents = Rx<LinkedHashMap<DateTime, List<Event>>>(LinkedHashMap());
  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();

  }
  List<Map<String, dynamic>> data = [
    {
      'studentName': 'Edward Thomas',
      'studentId': 18001,
      'class': 'Class 4',
      'section': 'A',
      'applyDate': DateTime(2024, 4, 5),
      'fromDate': DateTime(2024, 4, 9),
      'toDate': DateTime(2024, 4, 9),
      'status': 'Approved (04/05/2024)',
      'approvedBy': 'Joe Black',
      'approvedId': 9000,
    },
    {
      'studentName': 'Kriti Singh',
      'studentId': 18010,
      'class': 'Class 4',
      'section': 'B',
      'applyDate': DateTime(2024, 4, 4),
      'fromDate': DateTime(2024, 4, 22),
      'toDate': DateTime(2024, 4, 26),
      'status': 'Pending',
      'approvedBy': 'Joe Black',
      'approvedId': 9001,
    },
    // Add more data as needed
  ];
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
    kEvents.value = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_kEventSource.value);
    DateTime now = DateTime.now();

    getDataFromApi( now);// Initialize the future when the controller is created
  }

  getDataFromApi(DateTime now)
  {
    String year = DateFormat('yyyy').format(now);  // Extracts the year as "2024"
    String month = DateFormat('MM').format(now);
    fetchDataFuture = getData(year,month);
  }
  setMonthAndYear()
  {
    year.value = "";
    month.value = "";
    update();
  }
  Future<void> getData(String year,String month) async
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
