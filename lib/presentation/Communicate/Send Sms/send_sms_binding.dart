import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Communicate/Send%20Sms/send_sms_controller.dart';


class SendSmsBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(SendSmsController());
  }
}
