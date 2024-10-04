import 'dart:collection';

import 'package:intl/intl.dart';
import 'package:lerno/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/Attendance.dart';

class AttendanceController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<String> year = "".obs;
  Rx<String> month = "".obs;
  Rx<String> currentMont = "".obs;
  Rx<AttendanceDataModal> attendanceModelObj = AttendanceDataModal().obs;
  RxMap<DateTime, List<Event>> _kEventSource = <DateTime, List<Event>>{}.obs;
  final Rx<LinkedHashMap<DateTime, List<Event>>> kEvents =
  Rx<LinkedHashMap<DateTime, List<Event>>>(LinkedHashMap());
  late Future<void> fetchDataFuture;
  RxBool isLoading = false.obs;

  @override
  void onClose() {
    super.onClose();
  }

  // Retrieve events by date
  List<Event>? getEvents(DateTime date) {
    // print("##################${date}");
    return kEvents.value[date];
  }


  changeMonth(DateTime now)
  {
    currentMont.value = getCurrentMonthName(now);
    //update();
  }
  @override
  void onInit() {
    super.onInit();
    kEvents.value = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )
      ..addAll(_kEventSource.value);
    DateTime now = DateTime.now();

    getDataFromApi(now);
  }

  String getCurrentMonthName(DateTime now) {
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];


    return months[now.month - 1];
  }

  void getDataFromApi(DateTime now) {
    String year = DateFormat('yyyy').format(now); // Extracts the year
    String month = DateFormat('MM').format(now); // Extracts the month
    fetchDataFuture = getData(year, month);
   changeMonth(now);
    update();
  }

  // Method to fetch data from API
  Future<void> getData(String year, String month) async {
    isLoading.value = true; // Show loader before fetching data
    Map<String, dynamic> body = {
      "student_id": userData.getUserStudentId,
      "year": year,
      "month": month,
      "date": "",
    };
    print("Body @@@@ ${body}");
    var data = await apiRespository.postApiCallByJson(
        Constants.getAttendenceRecordsUrl, body);
    print("DATA @@@@ ${data.body}");

    attendanceModelObj.value = AttendanceDataModal.fromJson(data.body);

    if (attendanceModelObj.value.data != null &&
        attendanceModelObj.value.data!.isNotEmpty) {
      var eventsSource = attendanceModelObj.value.data!;
      for (var eventData in eventsSource) {
        DateTime date = DateTime.parse(eventData.date!);
        String type = eventData.type!;

        _kEventSource.putIfAbsent(date, () => []);
        _kEventSource[date]?.add(Event('$type'));
      }
    }

    kEvents.value = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )
      ..addAll(_kEventSource.value);

    print("111111111111111111111 ${kEvents}");
    isLoading.value = false; // Hide loader once data is fetched
    update();
  }


  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

}