import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lerno/apiHelper/userData.dart';
import 'package:lerno/presentation/common_widgets/custom_loader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/api.dart';
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
    //check internet here
    String newUrl = "";
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

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      newUrl = "";
    }
    return newUrl;
  }
  Future<File> downloadAndSaveImage(String url, String fileName) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;


    File file = File('$tempPath/$fileName');
    if (await file.exists()) {
      await file.delete();
    }

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Write the bytes of the downloaded image.
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to download image');
    }
  }
  Future<void> getData(context) async
  {
    print("PPPPP");
    var httpClient = HttpClient();
    try {

      showDialog(
        context: context,
        barrierDismissible: false, // Prevent closing the dialog
        builder: (BuildContext context) {
          return Center(
            child:  CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green), // Changed to blueAccent for a more vibrant color
            ),
          );
        },
      );

      String baseUrl = await getSchoolUrl(urlController.value.text.toString());
     // String baseUrl = urlController.value.text.toString()!.endsWith("/") ? urlController.value.text.toString().toString() : urlController.value.text.toString().toString() + "/";
      // Define the Uri. Replace 'https://example.com/api' with your API endpoint.
      if(baseUrl != "")
        {
          //check internet here
          Uri uri = Uri.parse('${baseUrl}api/webservice/getSchoolDetails');
          print("############${uri}");
          // Prepare the request
          HttpClientRequest request = await httpClient.postUrl(uri);
          request.headers.set(HttpHeaders.contentTypeHeader, "application/json"); // Content-Type header
          request.headers.add('Client-Service' , "smartschool");
          request.headers.add('Auth-Key' , "schoolAdmin@");
          HttpClientResponse response = await request.close();

          // Handle the response
          if (response.statusCode == HttpStatus.ok) {
            String reply = await response.transform(utf8.decoder).join();
            Map<String, dynamic> data = json.decode(reply);
            print('Response: $data');
            final prefs = await SharedPreferences.getInstance();
            await  prefs.setString("schoolBaseUrl",  baseUrl.toString());
            await  prefs.setString("schoolName",data["name"] ?? "");
            await  prefs.setString("schoolAddress",data["address"] ?? "");
            await  prefs.setString("schoolPhone",data["phone"] ?? "");
            await  prefs.setString("schoolEmail",data["email"] ?? "");
            await prefs.setString("schoolSchoolCode",data["dise_code"] ?? "");
            await  prefs.setString("schoolCurrentSession",data["session"] ?? "");
            await prefs.setString("schoolStartMonth",data["start_month_name"] ?? "");
            await  prefs.setString("schoolStartMonthNumber",data["start_month"] ?? "");
            await  prefs.setString("schoolImage",data["image"] ?? "");
            String spImage = "assets/projectImages/friendship.png";
            if(data.containsKey("app_splash_screen_file"))
              {


               var spUrl = data["app_splash_screen_file"];
               String fileName = DateTime.now().millisecondsSinceEpoch.toString() + "splashScreen.png" ;
                File spfile =  await downloadAndSaveImage(spUrl,fileName);
                spImage = spfile.path;
              }

            await  prefs.setString("app_icon",data["app_icon"] ?? "assets/projectImages/student.png");
            await  prefs.setString("app_name",data["app_name"] ?? "Lerno");
            await  prefs.setString("app_login_page_image",data["app_login_page_image"] ?? "assets/projectImages/friendship.png");
            await  prefs.setString("app_splash_screen_file",spImage);
            await  prefs.setString("app_maintain_mode",data["app_maintain_mode"] ?? "0");

            //change appname and app logo here


            Get.lazyPut(()=>ApiClient(appBaseUrl: "${baseUrl}api/"),fenix: true);
            //repose
            Get.lazyPut(()=>ApiRespository(apiClient: Get.find()));



            Navigator.of(context, rootNavigator: true).pop();

            Get.offNamed(
              AppRoutes.sScreen,
            );
          } else {
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red.shade300,
                content: Text("Not Found",style: theme.textTheme.titleMedium),
              ),
            );

            print('Error from school: ${response.statusCode}');



          }
        }
      else
        {
          Navigator.of(context, rootNavigator: true).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red.shade300,
              content: Text("School code not valid",style: theme.textTheme.titleMedium),
            ),
          );
        }

    } catch (e) {

      Navigator.of(context, rootNavigator: true).pop();
      print("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade300,
          content: Text("Error occurred: $e",style: theme.textTheme.titleMedium),
        ),
      );

    } finally {
      httpClient.close();
    }
  }
}
