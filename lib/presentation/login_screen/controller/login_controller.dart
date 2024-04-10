import 'package:anand_s_application1/apiHelper/userData.dart';
import 'package:anand_s_application1/presentation/login_screen/models/userDataModal.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../../dashboard/dashboard_screen.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class LoginController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  TextEditingController passwordController = TextEditingController();
  TextEditingController idController = TextEditingController();



  Rx<bool> isShowPassword = true.obs;

  @override
  void onClose() {
    super.onClose();
    passwordController.dispose();
  }

  loginApi(context)async{
    Map<String,dynamic> body = {
      "username" : idController.text,
      "password" : passwordController.text,
      "deviceToken" : ""
    };

    var data  = await apiRespository.postApiCallByJson("auth/login", body);


    print("DATA @@@@ ${data.body}");
    UsersData usersData = UsersData.fromJson(data.body);
    print("DATA USING DATA MODEL ${usersData.role}");
    userData.saveData("userData", usersData);
    print("GET USER DATA ${userData.getData("userData",)}");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );

   // Get.to( AppRoutes.teacherLoginScreen);


  }

}
