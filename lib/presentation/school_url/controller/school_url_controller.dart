import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learnladderfaculity/apiHelper/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/api.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import '../../../core/app_export.dart';



class SchoolUrlController extends GetxController {
  // UserData userData = Get.put(UserData());

  // Rx<NotiiceBoard> noticeBoardModelObj = NotiiceBoard().obs;
  Rx<TextEditingController> urlController = TextEditingController().obs;
  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
    // fetchDataFuture = getData(); // Initialize the future when the controller is created
  }
  Future<void> getData(context) async
  {
    var httpClient = HttpClient();
    try {
      String baseUrl = urlController.value.text.toString()!.endsWith("/") ? urlController.value.text.toString().toString() : urlController.value.text.toString().toString() + "/";
      // Define the Uri. Replace 'https://example.com/api' with your API endpoint.

      Uri uri = Uri.parse('${baseUrl}api/webservice/getSchoolDetails');
      print("############${uri}");
      // Prepare the request
      HttpClientRequest request = await httpClient.postUrl(uri);
      request.headers.set(HttpHeaders.contentTypeHeader, "application/json"); // Content-Type header
      request.headers.add('Client-Service' , "smartschool");
      request.headers.add('Auth-Key' , "schoolAdmin@");
      // request.add(utf8.encode(json.encode({
      //   "key": "value"  // Your JSON data payload
      // })));

      // Send the request and wait for the response
      HttpClientResponse response = await request.close();

      // Handle the response
      if (response.statusCode == HttpStatus.ok) {
        String reply = await response.transform(utf8.decoder).join();
        Map<String, dynamic> data = json.decode(reply);
        print('Response: $data');
        final prefs = await SharedPreferences.getInstance();
        await  prefs.setString("schoolBaseUrl",  urlController.value.text.toString());
        await  prefs.setString("schoolName",data["name"] ?? "");
        await  prefs.setString("schoolAddress",data["address"] ?? "");
        await  prefs.setString("schoolPhone",data["phone"] ?? "");
        await  prefs.setString("schoolEmail",data["email"] ?? "");
        await prefs.setString("schoolSchoolCode",data["dise_code"] ?? "");
        await  prefs.setString("schoolCurrentSession",data["session"] ?? "");
        await prefs.setString("schoolStartMonth",data["start_month_name"] ?? "");
        await  prefs.setString("schoolStartMonthNumber",data["start_month"] ?? "");
        await  prefs.setString("schoolImage",data["image"] ?? "");

        Get.lazyPut(()=>ApiClient(appBaseUrl: "${baseUrl}api/"),fenix: true);
        //repose
        Get.lazyPut(()=>ApiRespository(apiClient: Get.find()));

        // data.forEach((key, value) async {
        //   if (value is String) {
        //     await prefs.setString(key, value);
        //   } else if (value is int) {
        //     await prefs.setInt(key, value);
        //   } else if (value is bool) {
        //     await prefs.setBool(key, value);
        //   } else if (value is double) {
        //     await prefs.setDouble(key, value);
        //   }
        // });
        // SharedPreferences pref = await
          Get.offNamed(
            AppRoutes.sScreen,
          );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green.shade100,
            content: Text("Not Found",style: theme.textTheme.titleMedium),
          ),
        );

        print('Error from school: ${response.statusCode}');



      }
    } catch (e) {
      print("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade100,
          content: Text("Not Found",style: theme.textTheme.titleMedium),
        ),
      );

    } finally {
      httpClient.close();
    }
  }
}
