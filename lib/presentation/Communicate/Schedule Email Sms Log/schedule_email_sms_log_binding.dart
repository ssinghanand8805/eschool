import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Communicate/Schedule%20Email%20Sms%20Log/schedule_email_sms_log_controller.dart';



class ScheduleEmailSmsLogBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(ScheduleEmailSmsLogController());
  }
}
