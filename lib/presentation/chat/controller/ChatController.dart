import 'dart:developer';

import 'package:learnladderfaculity/apiHelper/chat_api_repo.dart';
import 'package:learnladderfaculity/apiHelper/userData.dart';
import 'package:learnladderfaculity/presentation/profile/model/Profile.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
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
  late Future<void> fetchDataFuture;
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
    fetchDataFuture = getData(); // Initialize the future when the controller is created
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
}
