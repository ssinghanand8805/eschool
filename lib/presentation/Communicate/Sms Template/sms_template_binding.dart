import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Communicate/Sms%20Template/sms_template_controller.dart';


class SmsTemplateBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(SmsTemplateController());
  }
}
