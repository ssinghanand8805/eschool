import '../../../apiHelper/userData.dart';
import '../../../core/app_export.dart';
import '../models/s_model.dart';

/// A controller class for the SScreen.
///
/// This class manages the state of the SScreen, including the
/// current sModelObj
class SController extends GetxController {
  Rx<SModel> sModelObj = SModel().obs;
  UserData userData = Get.put(UserData());

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 2), () {
      if(userData.getUserIsLoggedIn)
        {
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

    });
  }

}
