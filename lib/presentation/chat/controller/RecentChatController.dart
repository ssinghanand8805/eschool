import 'package:learnladderfaculity/apiHelper/chat_api_repo.dart';
import 'package:learnladderfaculity/apiHelper/userData.dart';
import 'package:learnladderfaculity/presentation/profile/model/Profile.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/RecentChat.dart';



class RecentChatController extends GetxController {
  UserData userData = Get.put(UserData());
  ChatApiRespository apiRespository = ChatApiRespository(apiClient:Get.find(tag: 'chatApi'));
  Rx<RecentChat> recentChatModelObj = RecentChat().obs;
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
    var data  = await apiRespository.getApiCallByJson(Constants.getRecentChatUrl,);
    print("DATA @@@@ ${data.body}");
    recentChatModelObj.value = RecentChat.fromJson(data.body);
    print("111111111111111111111 ${recentChatModelObj.value.toJson()}");
    update();
  }
}
