import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/settings/settingController.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
  }
}