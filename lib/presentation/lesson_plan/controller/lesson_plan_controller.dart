import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/userData.dart';
import '../modal/lesson_modal.dart';

class LessonPlanController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<LessonPlan> lessonPlanModelObj = LessonPlan().obs;
  RxString dateFrom = "".obs;
  RxString dateTo = "".obs;
  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchDataFuture = getData();
  }



  Map<String, DateTime> getMondayAndSaturday() {
    DateTime now = DateTime.now();
    // Calculate the current week's Monday
    DateTime monday = now.subtract(Duration(days: now.weekday - 1));
    // Calculate the current week's Saturday
    DateTime sunday = monday.add(Duration(days: 6));

    return {
      'monday': DateTime(monday.year, monday.month, monday.day),
      'sunday': DateTime(sunday.year, sunday.month, sunday.day),
    };
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<void> getData() async {
    Map<String, dynamic> body = {
      "student_id": userData.getUserStudentId,
      "date_from": formatDate(getMondayAndSaturday()['monday']!),
      "date_to": formatDate(getMondayAndSaturday()['sunday']!),
    };
    print("Body @@@@ ${body}");
    var data =
        await apiRespository.postApiCallByJson(Constants.lessonPlanUrl, body);
    print("DATA @@@@ ${data.body}");
    lessonPlanModelObj.value = LessonPlan.fromJson(data.body);
    print("111111111111111111111 ${lessonPlanModelObj.value.toJson()}");
    update();
  }
}
