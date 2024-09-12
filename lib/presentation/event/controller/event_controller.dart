import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../NotificationServices/PushNotificationService.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/userData.dart';
import '../../../core/app_export.dart';
import '../models/dashboard_model.dart';
import '../models/eventModal.dart';

/// A controller class for the FormScreen.
///
/// This class manages the state of the FormScreen, including the
/// current formModelObj
class EventController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  RxList<EventModal> EventModalvModelObj = <EventModal>[].obs;

  @override
  void onInit() {
    super.onInit();
    getData();

  }

  Future<void> getData() async {

    Map<String, dynamic> body = {
    };

    var data = await apiRespository.postApiCallByJson(Constants.getEventList, body);
    print("DATA @@@@ ${data.body}");

    List<EventModal> d = [];
    for(var i =0;i <data.body['listResult'].length; i++)
    {
      print("nmjvkjjgkjnnj");
      d.add(EventModal.fromJson(data.body['listResult'][i]));
      print("nhbhbhhhbbhhb");
    }
    EventModalvModelObj.value = d;
    print("fvffhghnhnhnhnhnhn$d");
    update();
  }
}