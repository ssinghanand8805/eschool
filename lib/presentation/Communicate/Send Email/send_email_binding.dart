import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Communicate/Send%20Email/send_email_controller.dart';


class SendEmailBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(SendEmailController());
  }
}
