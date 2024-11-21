import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../apiHelper/chat_api_repo.dart';
import '../../../apiHelper/userData.dart';
import '../model/Chat.dart';
import 'ChatController.dart';

class ChatGlobalController extends GetxController {
  UserData userData = Get.put(UserData());
  ChatApiRespository apiRespository = ChatApiRespository(
      apiClient: Get.find(tag: 'chatApi'));
  Rx<Chat> ChatModelObj = Chat().obs;
  RxList<dynamic> flattenedMessages = RxList<dynamic>();
  Map<String, List<Conversations>> groupMessagesByDate(
      List<Conversations> messages) {
    Map<String, List<Conversations>> groupedMessages = {};

    for (var message in messages) {
      DateTime messageDate = DateTime.parse(message.createdAt!);
      String dateKey = DateFormat('yyyy-MM-dd').format(messageDate);

      if (!groupedMessages.containsKey(dateKey)) {
        groupedMessages[dateKey] = [];
      }
      groupedMessages[dateKey]!.add(message);
    }

    // Sort messages within each group by createdAt in ascending order
    groupedMessages.forEach((key, value) {
      value.sort((a, b) => DateTime.parse(a.createdAt!)
          .compareTo(DateTime.parse(b.createdAt!))); // Ascending
    });

    return groupedMessages;
  }

  List<dynamic> flattenGroupedMessages(Map<String, List<Conversations>> groupedMessages) {
    List<dynamic> flatList = [];

    // Sort group keys (dates) in ascending order
    var sortedKeys = groupedMessages.keys.toList()
      ..sort((a, b) => DateTime.parse(a).compareTo(DateTime.parse(b)));

    // Process each group in sorted order
    for (var date in sortedKeys) {
      flatList.add(date); // Add the date header
      flatList.addAll(groupedMessages[date]!); // Add all messages for this date
    }

    return flatList;
  }
  void addIncomingMessage(Map<String, dynamic> messageData) {
    try {
      print("Try to add new chat on real time");
      // Convert the incoming data to a Conversations object
      Conversations newMessage = Conversations.fromJson(messageData);
      // Add the new message to the correct group
      String dateKey = DateFormat('yyyy-MM-dd').format(
          DateTime.parse(newMessage.createdAt!));
      int existingIndex = ChatModelObj.value.data!.conversations!.indexWhere(
            (conversation) => conversation.id == newMessage.id,
      ) ??
          -1;
      if(existingIndex == -1)
      {
        Map<String, List<Conversations>> groupedMessages =
        groupMessagesByDate(ChatModelObj.value.data!.conversations!);

        if (!groupedMessages.containsKey(dateKey)) {
          groupedMessages[dateKey] = [];
        }

        groupedMessages[dateKey]!.add(newMessage);

        // Sort messages in the group in ascending order
        groupedMessages[dateKey]!.sort((a, b) =>
            DateTime.parse(a.createdAt!).compareTo(DateTime.parse(b.createdAt!)));

        // Re-flatten messages after updating
        flattenedMessages.value = flattenGroupedMessages(groupedMessages);

        // Update the original conversations list
        ChatModelObj.value.data!.conversations =
            groupedMessages.values.expand((e) => e).toList();

        try{
          final ChatController chatControllerService = Get.put(ChatController());
          chatControllerService.update();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            chatControllerService.scrollToBottom();
          });
        }
        catch(e)
    {
      print("controller not build yet");
    }
        // Notify listeners of the update
        update();
      }

    } catch (e) {
      print("❌ Error adding incoming message: $e");
    }
  }

}