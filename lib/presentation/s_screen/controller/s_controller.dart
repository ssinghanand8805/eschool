import 'package:shared_preferences/shared_preferences.dart';

import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/userData.dart';
import '../../../core/app_export.dart';
import '../models/s_model.dart';

/// A controller class for the SScreen.
///
/// This class manages the state of the SScreen, including the
/// current sModelObj
class SController extends GetxController {
  // Rx<SModel> sModelObj = SModel().obs;
  UserData userData = Get.put(UserData());
  RxString splashScreenImage = "assets/images/LearnoLogo.png".obs;
  RxBool isSplashAsset = true.obs;
  RxString appName = "Lerno".obs;
  @override
  void onReady() async {
    final prefs = await SharedPreferences.getInstance();
    await GlobalData().loadPreferences();
    bool isBaseUrlFound = prefs.containsKey("schoolBaseUrl");
    bool isSplashScreenFound = prefs.containsKey("app_splash_screen_file");
    bool isAppNameFound = prefs.containsKey("app_name");
    if(isSplashScreenFound && prefs.getString("app_splash_screen_file") != null && prefs.getString("app_splash_screen_file")!.isNotEmpty)
      {
        isSplashAsset.value = false;
        splashScreenImage.value = (await prefs.getString("app_splash_screen_file"))!;
        update();
      }
    if(isAppNameFound && prefs.getString("app_name") != null && prefs.getString("app_name")!.isNotEmpty)
    {
      appName.value = (await prefs.getString("app_name"))!;
      update();
    }

    // if(!isBaseUrlFound)
    // {
    //   Get.offNamed(
    //     AppRoutes.enterSchoolUrlRoute,
    //   );
    // }


    print("#############ONINIT ${prefs.getBool("isLoggegIn")}");
    Future.delayed(const Duration(seconds: 2), () {
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
            userData.loadDataFromSharedPreferences();
            Get.offNamed(
              AppRoutes.formScreen,
            );
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
