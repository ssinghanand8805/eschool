import 'package:get/get.dart';

import '../../../../apiHelper/Constants.dart';
import '../../../../apiHelper/popular_product_repo.dart';
import '../../../../apiHelper/userData.dart';

class ExamResultController extends GetxController{
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  // Rx<ExamListModel> examListObj = ExamListModel().obs;
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
      "exam_group_class_batch_exam_id":"1"
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getExamResultUrl, body);
    print("DATA @@@@ ${data.body}");
    // print("111111111111111111111 ${applyLeaveModelObj.value.toJson()}");
    // examListObj.value = ExamListModel.fromJson(data.body);
    //  print("111111111111111111111 ${applyLeaveModelObj.value.toJson()}");
    update();
  }
}