import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/chat_api_repo.dart';
import '../../../apiHelper/userData.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import '../../login_screen/models/Faculity.dart';
import '../model/StaffList.dart';
import 'ChatGlobalController.dart';

class GroupController extends GetxController  {
  UserData userData = Get.put(UserData());
  ChatApiRespository apiRespository = ChatApiRespository(
      apiClient: Get.find(tag: 'chatApi'));

  Rx<TextEditingController> txtGrpName = TextEditingController().obs;
  Rx<File?> imageFile = Rx<File?>(null);
  Rx<String> groupType = 'Open'.obs;
  Rx<String> privacy = 'Public'.obs;
  @override
  void onInit() async {
    super.onInit();
  }

createGroup()
async {
  UserData usersData = UserData();
  Faculity? f =  usersData.getFaculity();
  String currentUserId = f!.chatUserId.toString() ?? "";
  Map<String,String> body = {
    "name":txtGrpName.value.text.toString(),
    "group_type":groupType.value.toString() == "Open" ? "1" : "2",
    "privacy":privacy.value.toString() == "Public" ? "1" : "2",
    "users[]":currentUserId
  };
  FormData bodyForm = FormData({
    'photo': MultipartFile(imageFile.value, filename: imageFile.value?.path.split('/').last ?? ""),
  });
  bodyForm.fields.addAll(body.entries);
  String url = Constants.groupsCreateForChat;
  var data  = await apiRespository.postApiCallByFormData(url,bodyForm);
  print(data);
}



}