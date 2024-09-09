import 'package:lerno/apiHelper/userData.dart';
import 'package:lerno/presentation/profile/model/Profile.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';



class ProfileController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<Profile> profileModelObj = Profile().obs;
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
      "user_type" : userData.getRole
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getStudentProfileUrl, body);
    print("DATA @@@@ ${data.body}");
    profileModelObj.value = Profile.fromJson(data.body);
    print("111111111111111111111 ${profileModelObj.value.toJson()}");
    update();
  }
}
