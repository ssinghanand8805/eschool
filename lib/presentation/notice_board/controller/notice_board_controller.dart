import 'package:lerno/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/NoticeBoard.dart';


class NoticeBoardController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<NotiiceBoard> noticeBoardModelObj = NotiiceBoard().obs;
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
      "type" : userData.getRole
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getNotificationsUrl, body);
    print("DATA @@@@ ${data.body}");
    print("userData getRole ${userData.getRole}");
    noticeBoardModelObj.value = NotiiceBoard.fromJson(data.body);
    print("111111111111111111111 ${noticeBoardModelObj.value.toJson()}");
    update();
  }
}
