import 'package:get/get.dart';
import 'email_tamplet_controller.dart';


class EmailTemplateBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(EmailTemplateController());
  }
}
