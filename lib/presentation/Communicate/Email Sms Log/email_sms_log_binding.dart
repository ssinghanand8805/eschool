import 'package:get/get.dart';

import 'email_sms_log_controller.dart';


class EmailSmsLogBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(EmailSmsLogController());
  }
}
