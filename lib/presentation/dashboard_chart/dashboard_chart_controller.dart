import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../apiHelper/Constants.dart';
import '../../apiHelper/popular_product_repo.dart';
import '../login_screen/models/SchoolSetting.dart';
import 'models/dashboard_chart_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DashboardChartController extends GetxController{
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<TextEditingController> searchC = TextEditingController().obs;
  Rx<DashboardChartData> chartData =  DashboardChartData().obs;
 var days_collection = [
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "50.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "20.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00"
  ];
  var days_expense = [
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "10.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00",
  "0.00"
  ];
  late Future<void> fetchDataFuture;
  @override
  void onInit() async {
    super.onInit();

    fetchDataFuture = getData();
  }
  getData()
  async {
    final prefs = await SharedPreferences.getInstance();

    FormData mainBody = FormData({});
    String? sessionId = prefs.getString("sessionId");

    if (sessionId != null && sessionId.isNotEmpty) {
       mainBody = FormData({
        "session_id": sessionId,
      });
      // Proceed with the mainBody logic
    } else {
     String? schoolSettingData =  prefs.getString("schoolSettingData");
     if(schoolSettingData != null && schoolSettingData.isNotEmpty)
       {
         var d = jsonDecode(schoolSettingData);
         SchoolSetting sch = SchoolSetting.fromJson(d);
         mainBody = FormData({
           "session_id": sch.currentSession!.sessionId!,
         });
       }
     else
       {
         print("Session ID is not available.");
       }
      // Handle the case when sessionId is null or empty

    }
    var data = await apiRespository.postApiCallByFormData(Constants.dashboard_chartUrl, mainBody);
    try
    {
      chartData.value = DashboardChartData.fromJson(data.body);
      update();
      print("=======================");
      print(chartData.value.toJson());
      print("=======================");
    }
    catch(e)
    {
      print("Exception:::${e}");
    }


//dashboard_chartUrl
  }

  Rx<TextEditingController> nameC = TextEditingController().obs;
  Rx<TextEditingController> descriptionC = TextEditingController().obs;
}