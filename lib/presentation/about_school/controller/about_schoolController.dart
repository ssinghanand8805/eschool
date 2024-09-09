import 'package:lerno/apiHelper/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';



class AboutSchoolController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  // Rx<NotiiceBoard> noticeBoardModelObj = NotiiceBoard().obs;
  RxString schoolName = "".obs;
  RxString schoolAddress = "".obs;
  RxString schoolPhone = "".obs;
  RxString schoolEmail = "".obs;
  RxString schoolSchoolCode = "".obs;
  RxString schoolCurrentSession = "".obs;
  RxString schoolStartMonth= "".obs;
  RxString schoolImage= "".obs;
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
  changeSchool()
  async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.toNamed('/s_screen');
  }
  Future<void> getData() async
  {
    final prefs = await SharedPreferences.getInstance();
      schoolName.value = prefs.getString("schoolName")!;
    schoolAddress.value = prefs.getString("schoolAddress")!;
    schoolPhone.value = prefs.getString("schoolPhone")!;
    schoolEmail.value = prefs.getString("schoolEmail")!;
    schoolSchoolCode.value = prefs.getString("schoolSchoolCode")!;
    schoolCurrentSession.value = prefs.getString("schoolCurrentSession")!;
    schoolStartMonth.value = prefs.getString("schoolStartMonth")!;
    schoolImage.value = prefs.getString("schoolImage")!;


    // Map<String,dynamic> body = {
    //   "student_id" : userData.getUserStudentId
    // };
    // print("Body @@@@ ${body}");
    // var data  = await apiRespository.postApiCallByJson(Constants.getNotificationsUrl, body);
    // print("DATA @@@@ ${data.body}");
    // // noticeBoardModelObj.value = NotiiceBoard.fromJson(data.body);
    // // print("111111111111111111111 ${noticeBoardModelObj.value.toJson()}");
    // update();
  }
}
