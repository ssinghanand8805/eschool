import 'dart:developer';

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
    log("111111111111111111111 ${recentChatModelObj.value.toJson()}");
    update();
  }
  DateTime utcToLocal(String dateTime) {
    // Parse the input UTC datetime string
    DateTime utcDateTime = DateTime.parse(dateTime).toUtc();

    // Convert UTC datetime to local datetime
    return utcDateTime.toLocal();
  }
  String formatChatDateString(String dateTimeString) {
    try {
      // Parse the input string into a DateTime object
      DateTime dateTime = utcToLocal(dateTimeString);//DateTime.parse(dateTimeString);

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

  void addIncomingMessage(Map<String, dynamic> messageData) {
    try {
      // Convert the incoming data to a Conversations object
      Conversations newMessage = Conversations.fromJson(messageData);

      // Check if the conversation already exists
      if(newMessage.isGroup == 0)
        {
          int existingIndex = recentChatModelObj.value.data?.conversations?.indexWhere(
                (conversation) => conversation.userId == newMessage.fromId,
          ) ??
              -1;

          if (existingIndex != -1) {
            // Update the existing conversation
            recentChatModelObj.value.data?.conversations?[existingIndex].message = newMessage.message;
            recentChatModelObj.value.data?.conversations?[existingIndex].createdAt = newMessage.createdAt;
          } else {
            // Add the new conversation to the list
            recentChatModelObj.value.data?.conversations?.add(newMessage);
          }
        }
      else
        {
          int existingIndex = recentChatModelObj.value.data?.conversations?.indexWhere(
                (conversation) => conversation.groupId == newMessage.groupId,
          ) ??
              -1;

          if (existingIndex != -1) {
            // Update the existing conversation
            recentChatModelObj.value.data?.conversations?[existingIndex].message = newMessage.message;
            recentChatModelObj.value.data?.conversations?[existingIndex].createdAt = newMessage.createdAt;
          } else {
            // Add the new conversation to the list
            recentChatModelObj.value.data?.conversations?.add(newMessage);
          }
        }


      // Notify listeners of the update
      update();
    } catch (e) {
      print("❌ Error adding incoming message: $e");
    }
  }
}
