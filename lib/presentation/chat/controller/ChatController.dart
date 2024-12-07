import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/apiHelper/chat_api_repo.dart';
import 'package:learnladderfaculity/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../core/app_export.dart';
import '../../login_screen/models/ChatUser.dart' as schoolUser;
import '../../login_screen/models/Faculity.dart';
import '../model/Chat.dart';

import 'ChatGlobalController.dart';
import 'RecentChatController.dart';



class ChatController extends GetxController {
  UserData userData = Get.put(UserData());
  ChatApiRespository apiRespository = ChatApiRespository(apiClient:Get.find(tag: 'chatApi'));
  final ChatGlobalController chatGlobalControllerService = Get.put(ChatGlobalController());
  // late Rx<Chat> ChatModelObj;
  late String chatId ;
  // late rec.Conversations chat ;
  late int isGroup ;
  late String chatUserId ;
  RxString photoUrl = "".obs ;
  RxString chatName = "".obs ;
  RxString  chatLastSeen = "".obs ;
  RxString groupCreatedBy= "".obs ;
  RxString groupDescription = "".obs ;
  RxString chatUserAbout = "".obs ;
  RxString chatUserPhone = "".obs ;
  RxString chatUserEmail = "".obs ;
  RxBool isAllowToSend = false.obs ;
  User? userDetails;
  Rx<Group?> groupDetails = Rx<Group?>(null);
  Future<void> fetchDataFuture = Future.value(); // Initialize fetchDataFuture
  Rx<String> replyMessageId = "".obs;
  Rx<String> replyMessage = "".obs;
  // RxList<dynamic> flattenedMessages = RxList<dynamic>();
  ScrollController scrollController = ScrollController(); // Scroll controller
  RxList<String> unreadMessagesId = <String>[].obs;
  String topMessageId = "";
  @override
  void onClose() {
    super.onClose();
    final RecentChatController recentChatController = Get.put(RecentChatController());
    recentChatController.getData();

  }
  @override
  void onInit() {
    super.onInit();
    // ChatModelObj = chatGlobalControllerService.ChatModelObj.value.obs;
    UserData usersData = UserData();
    Faculity? f =  usersData.getFaculity();
    chatUserId = f!.chatUserId.toString() ?? "";
    // chat = Get.arguments['chat'];
    isGroup = Get.arguments['isGroup'];
    chatId = Get.arguments['chatId'];
    photoUrl.value = Get.arguments['photoUrl'];
    chatName.value = Get.arguments['chatName'];
    chatLastSeen.value = Get.arguments['lastSeen'];
    isAllowToSend.value = Get.arguments['isAllowToSend'];


    groupCreatedBy.value = Get.arguments['groupCreatedBy'];
    groupDescription.value = Get.arguments['groupDescription'];

    chatUserAbout.value = Get.arguments['chatUserAbout'];
    chatUserPhone.value = Get.arguments['chatUserPhone'];
    chatUserEmail.value = Get.arguments['chatUserEmail'];




    fetchDataFuture = getData();
    fetchDataFuture.then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToBottom();
      });
    }); // Initialize the future when the controller is created
    scrollController.addListener(_onScroll);
  }
  void _onScroll() {
    if (scrollController.position.pixels <= 0) {
      print("reached on first postion");
      getData();
      // Call your function when reaching the first position
     // _loadMoreItems();
    }
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
  Future<void> addNewMemberCallback(Map<String,bool> members)
  async {
print("Got Members Map${members}");
List<String> selectedMemberId = members.entries
    .where((entry) => entry.value == true)  // Filter entries with true value
    .map((entry) => entry.key)              // Map to keys
    .toList();
    print("Got Members List${selectedMemberId}");
FormData mainBody = FormData({'members[]':selectedMemberId});
var data  = await apiRespository.postApiCallByFormData(Constants.groupsCreateForChat+'/'+chatId+'/'+'add-members',mainBody);

Chat newChatDetails = Chat.fromJson(data.body);
print("Previous User Details${newChatDetails.data!.group!.users!.length}");
groupDetails.value!.users!.add(newChatDetails.data!.group!.users!.first);
groupDetails.update((val) {});
update();


  }

  Future<void> deleteMemberFromGroup(String memberId)
  async {

    FormData mainBody = FormData({});
    var data  = await apiRespository.postApiCallByFormData(Constants.groupsCreateForChat+'/'+chatId+'/'+'members' + '/'+memberId,mainBody);
    print(data.body);
    groupDetails.value!.users!.removeWhere((item) => item.id.toString() == memberId);
    groupDetails.update((val) {});
    update();


  }
  Future<void> makeMemberAdmin(String memberId)
  async {

    FormData mainBody = FormData({});
    var data  = await apiRespository.postApiCallByFormData(Constants.groupsCreateForChat+'/'+chatId+'/'+'members' + '/'+memberId + '/' + 'make-admin',mainBody);
    print(data.body);
    groupDetails.value!.users!.forEach((user) {
      if (user.id.toString() == memberId) {
        // Update the desired field
        user.roleName = 'Admin';  // Example of updating a field
      }
    });
    // groupDetails.value!.users!.removeWhere((item) => item.id.toString() == memberId);
    groupDetails.update((val) {});
    update();


  }
  Future<void> removeMemberAsAdmin(String memberId)
  async {

    FormData mainBody = FormData({});
    var data  = await apiRespository.postApiCallByFormData(Constants.groupsCreateForChat+'/'+chatId+'/'+'members' + '/'+memberId + '/' + 'dismiss-as-admin',mainBody);
    print(data.body);
    groupDetails.value!.users!.forEach((user) {
      if (user.id.toString() == memberId) {
        // Update the desired field
        user.roleName = 'Member';  // Example of updating a field
      }
    });
    groupDetails.update((val) {});
    update();


  }

  bool isHtml(String input) {
    // Regular expression to check for common HTML tags
    final htmlTagRegex = RegExp(r'<\/?[a-z][\s\S]*>', caseSensitive: false);
    return htmlTagRegex.hasMatch(input);
  }
  void _updateFlattenedMessages() {
    // Group and flatten the new messages
    final groupedMessages = groupMessagesByDate(chatGlobalControllerService.ChatModelObj.value.data!.conversations!);
    var newMessages = flattenGroupedMessages(groupedMessages);

    // Insert new messages in chronological order
    final existingMessages = chatGlobalControllerService.flattenedMessages.value;

    // Merge the new and existing messages
    List<dynamic> mergedMessages = [];
    int i = 0, j = 0;

    while (i < newMessages.length && j < existingMessages.length) {
      var newMessageDate = newMessages[i] is String
          ? DateTime.parse(newMessages[i])
          : DateTime.parse((newMessages[i] as Conversations).createdAt!);
      var existingMessageDate = existingMessages[j] is String
          ? DateTime.parse(existingMessages[j])
          : DateTime.parse((existingMessages[j] as Conversations).createdAt!);

      if (newMessageDate.isBefore(existingMessageDate)) {
        mergedMessages.add(newMessages[i]);
        i++;
      } else {
        mergedMessages.add(existingMessages[j]);
        j++;
      }
    }

    // Add remaining messages
    while (i < newMessages.length) {
      mergedMessages.add(newMessages[i]);
      i++;
    }
    while (j < existingMessages.length) {
      mergedMessages.add(existingMessages[j]);
      j++;
    }

    // Update the flattenedMessages list
    chatGlobalControllerService.flattenedMessages.value = mergedMessages;

    // Notify listeners
    update();
  }

  Future<void> getData() async
  {

    String userId = "";
    print(Constants.getChatUrl+chatId+'/conversation?is_group=${isGroup.toString()}');
    String url = '';
    if(topMessageId == '')
      {
        url = Constants.getChatUrl+chatId+'/conversation?is_group=${isGroup.toString()}';
      }
    else
      {
        url = Constants.getChatUrl+chatId+'/conversation?before=${topMessageId}is_group=${isGroup.toString()}';
      }

    var data  = await apiRespository.getApiCallByJson(url,);
    log("DATA @@@@ ${data.body}");
    // var tt = getBoolVariables(data.body['data']['user']);
    // print(tt);
    chatGlobalControllerService.ChatModelObj.value = Chat.fromJson(data.body);
    userDetails = chatGlobalControllerService.ChatModelObj.value.data!.user;
    groupDetails.value =  chatGlobalControllerService.ChatModelObj.value.data!.group;
    int conLength = chatGlobalControllerService.ChatModelObj.value.data!.conversations!.length;
    if(conLength != 0)
      {
        Conversations topMsg = chatGlobalControllerService.ChatModelObj.value.data!.conversations![conLength - 1];

        topMessageId = topMsg.id.toString();
        print("LLLLAAAASSSTTT${topMessageId}");
      }

    getUnreadMessagesId();
    _updateFlattenedMessages();
    update();
  }


  updateReadByMeInApi(msgIds)
  async {
    if(msgIds.length > 0)
      {
        FormData mainBody = FormData({'ids[]':msgIds,'is_group':isGroup,'group_id':chatId});
        var data  = await apiRespository.postApiCallByFormData(Constants.sendReadMessageUrl,mainBody);
        print("PPPPPPPPP${data.body}");
      }


  }

  getUnreadMessagesId()
  {
    String localUserId = "2";
    if(isGroup.toString() == '1')
      {
        chatGlobalControllerService.ChatModelObj.value.data!.conversations!.forEach((element) {
          if(element.fromId != null)
            {
              print("PPPPPP${element.toJson()}");
              List<ReadBy> list = element.readBy!;
              bool isInclude = list!.any((item) => item.userId!.toString() == localUserId && item.readAt != null);
              if(element.fromId! != localUserId && !isInclude) {
                unreadMessagesId.value.add(element.id!.toString());

              }
            }



        });
      }
    else
      {

        chatGlobalControllerService.ChatModelObj.value.data!.conversations!.forEach((element) {

          if(element.toId! == localUserId && element.status == 0 && element.messageType! != 9)
          {
            print("***111!${element.toId!}");
            print("***222222!!!${localUserId!}");
            print("***33333!!!${element.status!}");
            unreadMessagesId.value.add(element.id!.toString());

          }
        });

        update();
      }
    updateReadByMeInApi(unreadMessagesId.value);
    print("UUUUUUNNNNRRRREEEEAAAADDD${unreadMessagesId.value}");

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
    schoolUser.ChatUser? chatUser = usersData.getChatUser();
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
        groupMessagesByDate(chatGlobalControllerService.ChatModelObj.value.data!.conversations!);

        if (!groupedMessages.containsKey(dateKey)) {
          groupedMessages[dateKey] = [];
        }

        groupedMessages[dateKey]!.add(newMessage);

        // Sort messages in the group in ascending order
        groupedMessages[dateKey]!.sort((a, b) =>
            DateTime.parse(a.createdAt!).compareTo(DateTime.parse(b.createdAt!)));

        // Re-flatten messages after updating
        chatGlobalControllerService.flattenedMessages.value = flattenGroupedMessages(groupedMessages);

        // Update the original conversations list
        chatGlobalControllerService.ChatModelObj.value.data!.conversations = groupedMessages.values.expand((e) => e).toList();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToBottom();
        });
        update();
      }
  }

}
