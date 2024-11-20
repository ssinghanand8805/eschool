import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/apiHelper/chat_api_repo.dart';
import 'package:learnladderfaculity/apiHelper/userData.dart';
import 'package:learnladderfaculity/presentation/profile/model/Profile.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../../login_screen/models/ChatUser.dart';
import '../../login_screen/models/Faculity.dart';
import '../model/Chat.dart';
import '../model/RecentChat.dart' as rec;



class ChatController extends GetxController {
  UserData userData = Get.put(UserData());
  ChatApiRespository apiRespository = ChatApiRespository(apiClient:Get.find(tag: 'chatApi'));
  Rx<Chat> ChatModelObj = Chat().obs;
  late String chatId ;
  late rec.Conversations chat ;
  late int isGroup ;
  late String chatUserId ;
  Future<void> fetchDataFuture = Future.value(); // Initialize fetchDataFuture
  Rx<String> replyMessageId = "".obs;
  Rx<String> replyMessage = "".obs;
  RxList<dynamic> flattenedMessages = RxList<dynamic>();
  ScrollController scrollController = ScrollController(); // Scroll controller

  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
    UserData usersData = UserData();
    Faculity? f =  usersData.getFaculity();
    chatUserId = f!.chatUserId.toString() ?? "";
    chat = Get.arguments['chat'];
    isGroup = Get.arguments['isGroup'];
    chatId = Get.arguments['chatId'];
    fetchDataFuture = getData();
    fetchDataFuture.then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToBottom();
      });
    }); // Initialize the future when the controller is created
  }
  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  bool isHtml(String input) {
    // Regular expression to check for common HTML tags
    final htmlTagRegex = RegExp(r'<\/?[a-z][\s\S]*>', caseSensitive: false);
    return htmlTagRegex.hasMatch(input);
  }
  void _updateFlattenedMessages() {
    final groupedMessages = groupMessagesByDate(ChatModelObj.value.data!.conversations!);
    flattenedMessages.value = flattenGroupedMessages(groupedMessages);
  }
  Future<void> getData() async
  {

    String userId = "";
    print(Constants.getChatUrl+chatId+'/conversation?is_group=${isGroup.toString()}');
    var data  = await apiRespository.getApiCallByJson(Constants.getChatUrl+chatId+'/conversation?is_group=${isGroup.toString()}',);
    log("DATA @@@@ ${data.body}");
    // var tt = getBoolVariables(data.body['data']['user']);
    // print(tt);
    ChatModelObj.value = Chat.fromJson(data.body);
    _updateFlattenedMessages();

  //   try{
  //
  //   }
  //   catch(e)
  // {
  //   print("fffffffff");
  //   print(e);
  // }

    log("111111111111111111111 ${ChatModelObj.value.toJson()}");
    update();
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

  Map<String, bool> getBoolVariables(Map<String, dynamic> json) {
    Map<String, bool> boolFields = {};

    // Iterate over each key-value pair in the JSON map
    json.forEach((key, value) {
      // Check if the value is of type bool
      if (value is bool) {
        boolFields[key] = value;
      }
    });

    return boolFields;  // Return a map containing only bool fields
  }


  sendMessage(String message)
  async {
    UserData usersData = UserData();
    ChatUser? chatUser = usersData.getChatUser();
    if(chatUser == null)
      {
        print("SSSSSSSS${chatUser}");
        return;
      }
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('hh:mma').format(now).toLowerCase();
    var body = {
      'to_id': chatId,
      '_token':"I1kbknPecVkpzGtE1RhkXb9HT0nLVCDSDTGQJ8xr",
      'is_archive_chat': '0',
      'is_group': isGroup.toString(),
      'message': message,
      'is_my_contact': '1',
      'time': formattedTime,
      'senderName': chatUser.data!.user!.name,
      'senderRole': chatUser.data!.user!.roleName,
      'senderImg': chatUser.data!.user!.photoUrl,
      'randomMsgId': now.millisecondsSinceEpoch,
      'replyMessage': '',
      'receiverName': '',
      // 'reply_to': '11'
    };
    if(replyMessageId.value.isNotEmpty)
      {
        body['reply_to'] = replyMessageId.value;
        body['replyMessage'] = replyMessage.value;
      }
    print(body);
    FormData mainBody = FormData(body);
    var data  = await apiRespository.postApiCallByFormData(Constants.sendTextMessageUrl,mainBody);
    log("DATA @@@@ ${data.body}");
    if(data.body['success'] == true)
      {
        Conversations newMessage = Conversations.fromJson(data.body['data']['message']);
        // Add the new message to the correct group
        String dateKey = DateFormat('yyyy-MM-dd').format(DateTime.parse(newMessage.createdAt!));

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
        ChatModelObj.value.data!.conversations = groupedMessages.values.expand((e) => e).toList();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToBottom();
        });
        update();
      }
  }
}
