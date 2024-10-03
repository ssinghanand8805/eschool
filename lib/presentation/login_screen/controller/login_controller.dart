import 'dart:convert';

import 'package:lerno/apiHelper/userData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../NotificationServices/PushNotificationService.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import '../../../core/app_export.dart';


class LoginController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  TextEditingController passwordController = TextEditingController();
  TextEditingController idController = TextEditingController();

  Rx<bool> isShowPassword = true.obs;
  RxString schoolImageUrl = "".obs;

  @override
  void onInit() {

    super.onInit();


  }
  @override
  void onClose() {
    // Dispose all controllers here
    passwordController.dispose();
    idController.dispose();

    // If you have other disposables, dispose them here as well
    super.onClose(); // Always call super.onClose() at the end
  }

  changeSchool() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    idController.clear();
    passwordController.clear();
    Get.toNamed('/s_screen');

  }

  loginApi(context) async {

    Map<String, dynamic> body = {
      "username": idController.text,
      "password": passwordController.text,
      "deviceToken": userData.getUserFCMDeviceToken
    };

    var data = await apiRespository.postApiCallByJson(Constants.authUrl, body);

    print("DATA @@@@ ${body}");
    print("DATA @@@@ ${data.body}");
    //UsersData usersData = UsersData.fromJson(data.body);
    String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
    Map<dynamic, dynamic> jsonData = data.body; //json.decode(data.body);
    if (jsonData["status"].toString() == "1") {
      UserData usersData = UserData();
      usersData.addLastUserId(idController.text.toString());
      usersData.addLastUserPwd(passwordController.text.toString());
      usersData.addRole(jsonData["role"].toString());
      usersData.addUserId(jsonData["id"].toString());
      usersData.addAccessToken(jsonData["token"].toString());
      usersData.addSchoolName(jsonData["sch_name"].toString());
      usersData.addCurrency_symbol(jsonData["currency_symbol"].toString());
      print("+++++++++${jsonData["student_session_id"].toString()}");
      usersData
          .addCurrency_short_name(jsonData["currency_short_name"].toString());
      usersData.addStart_week(jsonData["startWeek"].toString());

      String imgUrl = baseUrlFromPref + jsonData["image"].toString();
      bool isUserImage = jsonData["image"].toString() == "null" ? false : true;
      usersData.addIsUserImage(isUserImage);
      usersData.addUserImage(imgUrl);
      usersData.addUsername(jsonData["username"].toString());

      Map<String, dynamic> recordData =
          jsonData["record"]; //json.decode(jsonData["record"]);
      usersData.addDateFormat(recordData["date_format"].toString());
      if (jsonData["role"].toString() == "parent") {
        List<dynamic> childArray = recordData['parent_childs'];
        if (childArray.length == 1) {
          usersData.addUserIsLoggedIn(true);
          usersData.addUserHasMultipleChild(false);
          var firstChild = childArray[0]; //json.decode(childArray[0]);
          usersData.addUserStudentId(firstChild["student_id"]);
          usersData.addUserClassSection(
              firstChild["class"] + " - " + firstChild["section"]);
          usersData.addUserStudentName(firstChild["name"]);
          usersData
              .addStudent_session_id(firstChild["student_session_id"].toString());
          ///navigate here to dashboard
          print('one child found:::::::::');
          usersData.saveAllDataToSharedPreferences();
          Get.toNamed(AppRoutes.formScreen);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => DashboardScreen()),
          // );
        }
        else {
          List<String> childNameList = [];
          List<String> childIdList = [];
          List<String> childImageList = [];
          List<String> childClassList = [];
          List<bool> childImagefoundList = [];
          List<String> childSessionIDList = [];
          for (int i = 0; i < childArray.length; i++) {
            print("*****************${childArray[i]}");
            String name = childArray[i]["name"];
            childNameList.add(name);
            String id = childArray[i]["student_id"];
            childIdList.add(id);
            String seid = childArray[i]["student_session_id"] ?? "";
            childSessionIDList.add(seid);
            bool isUserImage =
                childArray[i]["image"].toString() == "null" ? false : true;
            usersData.addIsUserImage(isUserImage);
            String imgUrl = isUserImage
                ? baseUrlFromPref + childArray[i]["image"].toString()
                : "";
            String image = imgUrl;
            childImagefoundList.add(isUserImage);
            childImageList.add(image);
            String clss =
                childArray[i]["class"] + " - " + childArray[i]["section"];
            childClassList.add(clss);
          }
          print('child name List:::::::::');
          print(childIdList);
          print(childNameList);
          print(childImageList);
          print(childClassList);
          print(childImagefoundList);
          saveArray("childIdList",childIdList);
          saveArray("childNameList",childNameList);
          saveArray("childImageList",childImageList);
          saveArray("childClassList",childClassList);
          saveArray("childImagefoundList",childImagefoundList);
          print('child name List:::::::::');

          /// show Child List here
          ///
          showChildList(context, childNameList, childIdList, childImageList,
              childClassList,childImagefoundList,childSessionIDList);
        }
      } else if (jsonData["role"] == "student") {
        usersData.addUserIsLoggedIn(true);
        usersData.addUserStudentId(recordData["student_id"]);
        usersData.addUserClassSection(
            recordData["className"] + " - " + recordData["section"]);
        usersData.addUserAdmissionNo(recordData["admission_no"]);
        usersData
            .addStudent_session_id(recordData["student_session_id"].toString());
        ///checking for profile lock
        Map<String, dynamic> body2 = {"student_id": usersData.getUserStudentId};
        var data = await apiRespository.postApiCallByJson(
            "webservice/lock_student_panel", body2);
        print('start profile lock data:::::::::');
        print(data);
        print('end profile lock data:::::::::');
        usersData.saveAllDataToSharedPreferences();
        Get.toNamed(AppRoutes.formScreen);
      }
    } else {
      print('login failed:::::::::');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade100,
          content: Text(data.body["message"],style: theme.textTheme.titleMedium),
        ),
      );

    }

    //print("DATA USING DATA MODEL ${usersData.role}");
    // userData.saveData("userData", usersData);
    //  print("GET USER DATA ${userData.getData("userData",)}");

    // Get.to( AppRoutes.teacherLoginScreen);
  }
  Future<bool> saveArray(String name,List<dynamic> array) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(array); // Encode your array to a JSON string
    return prefs.setString(name, encodedData); // Save encoded string
  }

  onSelectChildStudent(student_id, classNameSection, name,sessionId) {
    UserData usersData = UserData();
    usersData.addUserIsLoggedIn(true);
    usersData.addUserHasMultipleChild(true);
    usersData.addUserStudentId(student_id);
    usersData.addUserClassSection(classNameSection);
    usersData.addUserStudentName(name);
    usersData
        .addStudent_session_id(sessionId.toString());
    ///navigate here to dashboard
    print('one child found:::::::::');
    usersData.saveAllDataToSharedPreferences();
    Get.toNamed(AppRoutes.formScreen);
  }

  void showChildList(
      BuildContext context,
      List<String> childNameList,
      List<String> childIdList,
      List<String> childImageList,
      List<String> childClassList,
      List<bool> childImagefoundList,
      List<String> childSessionIDList,

      ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double itemHeight = 100.0; // Set a fixed height for each item
            final double bottomSheetHeight = (childNameList.length *
                    itemHeight) +
                kBottomNavigationBarHeight; // Calculate the total height of the bottom sheet
            return SizedBox(
              height: bottomSheetHeight,
              child: ListView.builder(
                itemCount: childNameList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          onSelectChildStudent(childIdList[index],
                              childClassList[index], childNameList[index],childSessionIDList[index]);
                        },
                        child: ListTile(
                          leading: childImagefoundList[index] != false
                              ? CircleAvatar(
                                  radius: itemHeight / 4,
                                  backgroundImage:
                                      NetworkImage(childImageList[index])

                                  )
                              : CircleAvatar(
                                  radius: itemHeight / 4,
                                  backgroundImage: AssetImage(
                                      'assets/projectImages/placeholder_user.png',),
                                ),
                          title: Text(childNameList[index]),
                          subtitle: Text(childClassList[index]),
                        ),
                      )
                      // Add more ListTiles for more children
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
