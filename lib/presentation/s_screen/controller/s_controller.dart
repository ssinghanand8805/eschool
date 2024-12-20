import 'package:shared_preferences/shared_preferences.dart';

import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/userData.dart';
import '../../../core/app_export.dart';
import '../../login_screen/models/Faculity.dart';
import '../models/s_model.dart';

/// A controller class for the SScreen.
///
/// This class manages the state of the SScreen, including the
/// current sModelObj
class SController extends GetxController {
  // Rx<SModel> sModelObj = SModel().obs;
  UserData userData = Get.put(UserData());

  @override
  void onReady() async {
    final prefs = await SharedPreferences.getInstance();
    await GlobalData().loadPreferences();
    bool isBaseUrlFound = prefs.containsKey("schoolBaseUrl");

    // if(!isBaseUrlFound)
    // {
    //   Get.offNamed(
    //     AppRoutes.enterSchoolUrlRoute,
    //   );
    // }


    print("#############ONINIT ${prefs.getBool("isLoggegIn")}");
    Future.delayed(const Duration(seconds: 2), () async {
      if(!isBaseUrlFound)
        {
          Get.offNamed(
            AppRoutes.enterSchoolUrlRoute,
          );
        }
      else
        {
          if(prefs.getBool("isLoggegIn") == true)
          {
            Faculity? f = await userData.getFaculity();
            if(f == null)
              {
                await prefs.clear();
                Get.offNamed(
                  AppRoutes.loginScreen,
                );
              }
            else
              {
                userData.loadDataFromSharedPreferences();
                Get.offNamed(
                  AppRoutes.formScreen,
                );
              }

          }
          else
          {
            Get.offNamed(
              AppRoutes.loginScreen,
            );
          }
        }


    });
  }


}
