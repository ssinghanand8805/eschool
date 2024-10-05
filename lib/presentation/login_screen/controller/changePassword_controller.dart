import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lerno/apiHelper/GlobalData.dart';
import 'package:lerno/apiHelper/userData.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../NotificationServices/PushNotificationService.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/api.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import '../../../core/app_export.dart';
import 'package:http/http.dart' as http;
class ChangePasswordController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  final formKey = GlobalKey<FormState>();
  final userIdController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool oldPasswordVisible = false;
  bool newPasswordVisible = false;
  bool confirmPasswordVisible = false;

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    clearTextFields();
  }
  void clearTextFields() {
    userIdController.clear();
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  void submitForm(context) {
    if (formKey.currentState!.validate()) {
      changePassword(context);
    }
  }

  @override
  void dispose() {
    userIdController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  Future<File> downloadAndSaveImage(String url, String fileName) async {
    // Get the temporary directory for the app.
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    // Create an instance of File to save the image.
    File file = File('$tempPath/$fileName');

    // Check if file already exists to avoid re-downloading.
    if (await file.exists()) {
      return file;
    }

    // Download the image using HTTP GET request.
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Write the bytes of the downloaded image.
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to download image');
    }
  }
  logout(context) async {
   String  baseur = GlobalData().baseUrlValueFromPref;
   await logoutAPI();
    final prefs = await SharedPreferences.getInstance();

    prefs.clear();

   String baseUrl = baseur;
   var httpClient = HttpClient();
   // String baseUrl = urlController.value.text.toString()!.endsWith("/") ? urlController.value.text.toString().toString() : urlController.value.text.toString().toString() + "/";
   // Define the Uri. Replace 'https://example.com/api' with your API endpoint.
   if(baseUrl != "") {
     Uri uri = Uri.parse('${baseUrl}api/webservice/getSchoolDetails');
     print("############${uri}");
     // Prepare the request
     HttpClientRequest request = await httpClient.postUrl(uri);
     request.headers.set(HttpHeaders.contentTypeHeader,
         "application/json"); // Content-Type header
     request.headers.add('Client-Service', "smartschool");
     request.headers.add('Auth-Key', "schoolAdmin@");
     HttpClientResponse response = await request.close();

     // Handle the response
     if (response.statusCode == HttpStatus.ok) {
       String reply = await response.transform(utf8.decoder).join();
       Map<String, dynamic> data = json.decode(reply);
       print('Response: $data');
       final prefs = await SharedPreferences.getInstance();
       await prefs.setString("schoolBaseUrl", baseUrl.toString());
       await prefs.setString("schoolName", data["name"] ?? "");
       await prefs.setString("schoolAddress", data["address"] ?? "");
       await prefs.setString("schoolPhone", data["phone"] ?? "");
       await prefs.setString("schoolEmail", data["email"] ?? "");
       await prefs.setString("schoolSchoolCode", data["dise_code"] ?? "");
       await prefs.setString("schoolCurrentSession", data["session"] ?? "");
       await prefs.setString(
           "schoolStartMonth", data["start_month_name"] ?? "");
       await prefs.setString(
           "schoolStartMonthNumber", data["start_month"] ?? "");
       await prefs.setString("schoolImage", data["image"] ?? "");
       String spImage = "assets/projectImages/friendship.png";
       if (data.containsKey("app_splash_screen_file")) {
         var spUrl = data["app_splash_screen_file"];
         String fileName = DateTime.now().millisecondsSinceEpoch.toString() + "splashScreen.png" ;
         File spfile = await downloadAndSaveImage(spUrl, fileName);
         spImage = spfile.path;
       }

       await prefs.setString(
           "app_icon", data["app_icon"] ?? "assets/projectImages/student.png");
       await prefs.setString("app_name", data["app_name"] ?? "Lerno");
       await prefs.setString("app_login_page_image",
           data["app_login_page_image"] ??
               "assets/projectImages/friendship.png");
       await prefs.setString("app_splash_screen_file", spImage);
       await prefs.setString(
           "app_maintain_mode", data["app_maintain_mode"] ?? "0");

       //change appname and app logo here


       Get.lazyPut(() => ApiClient(appBaseUrl: "${baseUrl}api/"), fenix: true);
       //repose
       Get.lazyPut(() => ApiRespository(apiClient: Get.find()));


       Navigator.of(context, rootNavigator: true).pop();

       Get.offNamed(
         AppRoutes.sScreen,
       );
     }
   }
  }

  Future<bool> logoutAPI() async {
    final PushNotificationService _notificationService =
    PushNotificationService();
    String? deToken = await _notificationService.getToken();
    String deviceToken = deToken!;
    Map<String, dynamic> body = {"deviceToken": deviceToken};

    print("Logout Request Body: $body");

    var response =
    await apiRespository.postApiCallByJson(Constants.logout, body);

    print("Logout Response: ${response.body}");

    if (response.statusCode == 200) {
      return  true;
    } else {
      print("Logout failed: ${response.body}");
      return  false;
    }
  }

  Future<void> changePassword(context) async {
    if (newPasswordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
      Get.showSnackbar(
          Ui.ErrorSnackBar(message: "Please fill in all fields."));
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.showSnackbar(
          Ui.ErrorSnackBar(message: "New password and confirm password do not match."));
      return;
    }

    Map<String, dynamic> body = {
      "userName": userData.getLastUserId,
      "old_password": userData.getLastUserPwd,
      "new_password": newPasswordController.text,
      "new_password1": confirmPasswordController.text,
    };

    print("Body @@@@ ${body}");
    var data = await apiRespository.postApiCallByJson(Constants.changePassword, body);
    print("DATA @@@@ ${data.body}");

    if (data.statusCode == 200) {
      clearTextFields();

      Get.showSnackbar(Ui.SuccessSnackBar(message: "Password Changed Successfully"));
      logout(context);
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Failed to change password. Please try again."));
    }
    update();
  }


  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPasswordField = false,
    bool? isPasswordVisible,
    VoidCallback? onVisibilityToggle,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: TextFormField(
        controller: controller,
        obscureText: isPasswordField ? !(isPasswordVisible ?? false) : false,
        style: TextStyle(color: Colors.black87), // Text color
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey.shade600), // Label color
          prefixIcon: Icon(icon, color: Colors.grey.shade700),
          suffixIcon: isPasswordField
              ? IconButton(
                  icon: Icon(
                    isPasswordVisible ?? false
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey.shade700,
                  ),
                  onPressed: onVisibilityToggle,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green.shade400, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.symmetric(
              vertical: 16.0, horizontal: 12.0), // Increased padding
          hintText: 'Enter your $label',
          hintStyle: TextStyle(color: Colors.grey.shade400),
        ),
      ),
    );
  }
}
