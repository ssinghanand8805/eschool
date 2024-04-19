import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';

class PageHeaderController extends GetxController {
  RxString schoolImageUrl = "".obs;

  @override
  void onInit() {
    super.onInit();
    // fetchDataFuture = getData(); // Initialize the future when the controller is created
    getImageDetails();
  }
  getImageDetails() async
  {
    String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
    final prefs = await SharedPreferences.getInstance();
    schoolImageUrl.value = (prefs.getString("schoolImage") == null || prefs.getString("schoolImage") == null) ? "" : baseUrlFromPref + "uploads/school_content/logo/app_logo/" + prefs.getString("schoolImage")!;
    update();
  }

}