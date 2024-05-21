import 'package:get/get.dart';

import 'login_credentials_send_controller.dart';


class LoginCredentialsSendBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(LoginCredentialsSendController());
  }
}
