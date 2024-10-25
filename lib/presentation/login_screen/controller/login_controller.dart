import 'dart:convert';

import 'package:learnladderfaculity/apiHelper/userData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import '../../../core/app_export.dart';
import '../models/Faculity.dart';


class LoginController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  TextEditingController passwordController = TextEditingController();
  TextEditingController idController = TextEditingController();
  // GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  Rx<bool> isShowPassword = true.obs;
  RxString schoolImageUrl = "".obs;
  RxBool isLoading = false.obs;
  @override
  void onClose() {
    super.onClose();
    passwordController.dispose();
  }

  changeSchool() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.toNamed('/s_screen');
  }

  loginApi(context) async {
    isLoading.value = true;
    Map<String, dynamic> body = {
      "username": idController.text,
      "password": passwordController.text,
      "deviceToken": userData.getUserFCMDeviceToken
    };

    var data = await apiRespository.postApiCallByJsonForLogin(Constants.authUrl, body);

    print("DATA @@@@ ${data.body}");
    if(data.statusCode == 200)
      {
        if(data.body is bool)
        {
          isLoading.value = false;
          update();
          final prefs = await SharedPreferences.getInstance();
          prefs.clear();
          Get.showSnackbar(Ui.ErrorSnackBar(message: "Enter correct username and password!"));
          Get.toNamed('/s_screen');


          print('login failed:::::::::');
          return;
        }
        else if(data.body != null)
        {
          isLoading.value = false;
          update();
          Faculity fac = Faculity.fromJson(data.body);

          UserData usersData = UserData();
          userData.addLastUserId(idController.text);
          userData.addLastUserPwd(passwordController.text);
          usersData.saveFaculity(fac);
          if(fac.roles!.roleId.toString() == '7')
          {
            Get.showSnackbar(Ui.SuccessSnackBar(message: "Welcome ${fac.name}"));
            //superadmin found no restriction
            //navigate to dashboard
            Get.toNamed(AppRoutes.formScreen);
          }
          else
          {
            Get.showSnackbar(Ui.SuccessSnackBar(message: "Welcome ${fac.name}"));
            Get.toNamed(AppRoutes.formScreen);
            //check permission wise and navigate to dashboard
          }
        }
        else
        {
          Get.showSnackbar(Ui.ErrorSnackBar(message: "Server Error Occured"));
          isLoading.value = false;
          update();
        }
      }
    else
      {
        Get.showSnackbar(Ui.ErrorSnackBar(message: "Server Error Occured"));
        isLoading.value = false;
        update();
      }






  }
  Future<bool> saveArray(String name,List<dynamic> array) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(array); // Encode your array to a JSON string
    return prefs.setString(name, encodedData); // Save encoded string
  }

  onSelectChildStudent(student_id, classNameSection, name) {
    UserData usersData = UserData();
    usersData.addUserIsLoggedIn(true);
    usersData.addUserHasMultipleChild(true);
    usersData.addUserStudentId(student_id);
    usersData.addUserClassSection(classNameSection);
    usersData.addUserStudentName(name);

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
                              childClassList[index], childNameList[index]);
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
