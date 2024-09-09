import 'package:lerno/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/SyllabusStatus.dart';


class SyllabusStatusController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<SyllabusStatus> syllabusStatusModelObj = SyllabusStatus().obs;
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
      "student_id" : userData.getUserStudentId
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getsyllabussubjectsUrl, body);
    print("DATA @@@@ ${data.body}");
    syllabusStatusModelObj.value = SyllabusStatus.fromJson(data.body);
    print("111111111111111111111 ${syllabusStatusModelObj.value.toJson()}");
    update();
  }
}
