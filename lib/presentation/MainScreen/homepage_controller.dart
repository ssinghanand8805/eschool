import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apiHelper/ChatNotificationService.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/SocketService.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/userData.dart';
import '../../../core/app_export.dart';

/// A controller class for the FormScreen.
///
/// This class manages the state of the FormScreen, including the
/// current formModelObj
class HomePageController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  RxString schoolImageUrl = "".obs;





  ScrollController? scrollController;
  Color textColor = Colors.white;
  late Future<void> fetchDataFuture;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


    fetchDataFuture =  getSchoolDetails();
  }




  logout() async {
    final prefs = await SharedPreferences.getInstance();
    String vUrl = prefs.getString('schoolBaseUrl')!;
    prefs.clear();
    prefs.setString('schoolBaseUrl', vUrl);
    Get.toNamed('/s_screen');
  }

  getSchoolDetails() async {
    Map<String, dynamic> body = {};
    String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
    var data = await apiRespository.postApiCallByJsonForLogin(
        "webservice/getSchoolDetails", body);

    final prefs = await SharedPreferences.getInstance();
    print("###################${data.body}");
    await prefs.setString("schoolName", data.body["name"] ?? "");
    await prefs.setString("schoolAddress", data.body["address"] ?? "");
    await prefs.setString("schoolPhone", data.body["phone"] ?? "");
    await prefs.setString("schoolEmail", data.body["email"] ?? "");
    await prefs.setString("schoolSchoolCode", data.body["dise_code"] ?? "");
    await prefs.setString("schoolCurrentSession", data.body["session"] ?? "");
    await prefs.setString("date_format", data.body["date_format"] ?? "");
    await prefs.setString("timezone", data.body["timezone"] ?? "");
    await prefs.setString(
        "schoolStartMonth", data.body["start_month_name"] ?? "");
    await prefs.setString(
        "schoolStartMonthNumber", data.body["start_month"] ?? "");
    await prefs.setString("schoolImage", data.body["image"] ?? "");
    schoolImageUrl.value =
        (data.body["image"] == null || data.body["image"] == null)
            ? ""
            : baseUrlFromPref +
                "uploads/school_content/logo/app_logo/" +
                data.body["image"];
    update();
    print("+++++++++++++++++++++${schoolImageUrl.value}");

  }



  Future<void> logOutDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(
            'Logout',
            style: theme.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 19),
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: theme.textTheme.bodyMedium,
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.green.shade300,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              child: Text(
                'Cancel',
                style: theme.textTheme.bodyMedium,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.red.shade200,
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                child: Text(
                  'Logout',
                  style: theme.textTheme.bodyMedium,
                ),
                onPressed: () async {
                  logout();
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ),
          ],
        );
      },
    );
  }



  RxList FAB = [
    {
      'name':"Term"
    },
    {
      'name':"Assessment"
    },
    {
      'name':"Grade"
    },
    {
      'name':"Exam"
    },
    {
      'name':"Exam Schedule"
    },
  ].obs;




}
