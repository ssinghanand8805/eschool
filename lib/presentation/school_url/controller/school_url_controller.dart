import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learnladderfaculity/apiHelper/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/api.dart';
import '../../../apiHelper/chatApi.dart';
import '../../../apiHelper/chat_api_repo.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import '../../../core/app_export.dart';

import 'package:http/http.dart' as http;

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

  getSchoolUrl(code) async
  {
    String newUrl = "";
    String newChatBaseUrl = "";
  var t= jsonEncode(<String, String>{
    'schoolCode': code,
  });
  print(t);
    final response = await http.post(
      Uri.parse("http://aatreya.avadhconnect.com/api/base/getBaseUrlByCode"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: t,
    );

    if (response.statusCode == 200) {
      print(response.body);
  var data = jsonDecode(response.body) as Map<String, dynamic>;
  print(data);
  newUrl = data['baseurl'];
      newChatBaseUrl = data['chatbaseurl'];

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      newUrl = "";
      newChatBaseUrl = "";
    }
    var d = {"newUrl":newUrl,"newChatBaseUrl":newChatBaseUrl};
return d;
  }
  Future<void> getData(context) async
  {
    var httpClient = HttpClient();
    try {
      var resB = await getSchoolUrl(urlController.value.text.toString()); //urlController.value.text.toString()!.endsWith("/") ? urlController.value.text.toString().toString() : urlController.value.text.toString().toString() + "/";
      String baseUrl  = resB['newUrl'];
      String chatBaseUrl  = resB['newChatBaseUrl'];
      // Define the Uri. Replace 'https://example.com/api' with your API endpoint.
          if(baseUrl != "")
            {
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
                await  prefs.setString("schoolBaseUrl",  baseUrl.toString());
                await  prefs.setString("schoolChatBaseUrl",  chatBaseUrl.toString());
                await  prefs.setString("schoolName",data["name"] ?? "");
                await  prefs.setString("schoolAddress",data["address"] ?? "");
                await  prefs.setString("schoolPhone",data["phone"] ?? "");
                await  prefs.setString("schoolEmail",data["email"] ?? "");
                await prefs.setString("schoolSchoolCode",data["dise_code"] ?? "");
                await  prefs.setString("schoolCurrentSession",data["session"] ?? "");
                await prefs.setString("schoolStartMonth",data["start_month_name"] ?? "");
                await  prefs.setString("schoolStartMonthNumber",data["start_month"] ?? "");
                await  prefs.setString("schoolImage",data["image"] ?? "");

                Get.lazyPut(()=>ApiClient(appBaseUrl: "${baseUrl}api/"),tag: 'generalApi', fenix: true);
                Get.lazyPut(()=>ApiRespository(apiClient: Get.find(tag: 'generalApi')));
                Get.lazyPut(()=>chatApiClient(appBaseUrl: "${chatBaseUrl}api/"),tag: 'chatApi',fenix: true);
                Get.lazyPut(()=>ChatApiRespository(apiClient: Get.find(tag: 'chatApi')));

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
            }
          else
            {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green.shade100,
                  content: Text("Not Found",style: theme.textTheme.titleMedium),
                ),
              );
            }

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green.shade100,
            content: Text("Not Found",style: theme.textTheme.titleMedium),
          ),
        );

        //print('Error from school: ${response.statusCode}');



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
