import 'package:get/get.dart';
import 'enter_marks_controller.dart';




class EnterMarksBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(EnterMarksController());
  }
}
