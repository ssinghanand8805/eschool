import 'package:get/get.dart';
import 'admission_Enquiry_controller.dart';

class AdmissionEnquiryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdmissionEnquiryController());
  }
}
