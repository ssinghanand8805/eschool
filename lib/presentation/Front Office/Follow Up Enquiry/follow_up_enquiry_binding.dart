import 'package:get/get.dart';
import 'follow_up_enquiry_controller.dart';

class FollowUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FollowUpEnquiryController());
  }

}