import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/userData.dart';
import '../modal/lesson_modal.dart';

class LessonPlanController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<LessonPlan> lessonPlanModelObj = LessonPlan().obs;
  RxString dateFrom = "2024-04-08".obs;
  RxString dateTo = "2024-04-14".obs;
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
  Future<void> getData() async
  {
    Map<String,dynamic> body = {
      "student_id" : userData.getUserStudentId,
      "date_from" : dateFrom.value,
      "date_to" : dateTo.value,
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.lessonPlanUrl, body);
    print("DATA @@@@ ${data.body}");
    lessonPlanModelObj.value = LessonPlan.fromJson(data.body);
    print("111111111111111111111 ${lessonPlanModelObj.value.toJson()}");
    update();
  }
}