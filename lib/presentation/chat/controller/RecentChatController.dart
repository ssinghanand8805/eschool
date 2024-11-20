import 'package:intl/intl.dart';
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
  String formatChatDateString(String dateTimeString) {
    try {
      // Parse the input string into a DateTime object
      DateTime dateTime = DateTime.parse(dateTimeString);

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(Duration(days: 1));

      if (dateTime.isAfter(today)) {
        // If the date is today, return time only
        return DateFormat.jm().format(dateTime); // e.g., 2:30 PM
      } else if (dateTime.isAfter(yesterday)) {
        // If the date is yesterday, return "Yesterday"
        return "Yesterday";
      } else {
        // Else, return the date only
        return DateFormat.yMMMd().format(dateTime); // e.g., Aug 20, 2023
      }
    } catch (e) {
      // Handle invalid date strings gracefully
      return "Invalid date";
    }
  }
}
