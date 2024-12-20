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
  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    // Immediately load and display cached data
    String? cachedData = prefs.getString("cachedChartData");
    if (cachedData != null) {
      try {
        var jsonData = jsonDecode(cachedData);
        chartData.value = DashboardChartData.fromJson(jsonData);
        update(); // Update the UI immediately with cached data
      } catch (e) {
        print("Failed to load cached data: $e");
      }
    }

    // Then, fetch new data from the API
     fetchDataFromAPI(prefs);
  }

  Future<void> fetchDataFromAPI(SharedPreferences prefs) async {
    FormData mainBody = determineMainBody(prefs);
    try {
      var data = await apiRespository.postApiCallByFormData(Constants.dashboard_chartUrl, mainBody);
      chartData.value = DashboardChartData.fromJson(data.body);
      update(); // Update the UI with new data

      // Cache the new data in SharedPreferences
      await prefs.setString("cachedChartData", jsonEncode(data.body));

      print("=======================");
      print(chartData.value.toJson());
      print("=======================");
    } catch (e) {
      print("Exception when calling API: $e");
    }
  }

  FormData determineMainBody(SharedPreferences prefs) {
    String? sessionId = prefs.getString("sessionId");
    if (sessionId != null && sessionId.isNotEmpty) {
      return FormData({"session_id": sessionId});
    } else {
      String? schoolSettingData = prefs.getString("schoolSettingData");
      if (schoolSettingData != null && schoolSettingData.isNotEmpty) {
        var d = jsonDecode(schoolSettingData);
        SchoolSetting sch = SchoolSetting.fromJson(d);
        return FormData({"session_id": sch.currentSession!.sessionId!});
      } else {
        print("Session ID is not available.");
        // Ensure you handle this case appropriately, perhaps with a fallback or error handling
      }
    }
    return FormData({});
  }





  Rx<TextEditingController> nameC = TextEditingController().obs;
  Rx<TextEditingController> descriptionC = TextEditingController().obs;
}