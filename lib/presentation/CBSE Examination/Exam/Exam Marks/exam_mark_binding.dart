import 'package:get/get.dart';
import 'exam_mark_controller.dart';



class ExamMarkBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(ExamMarkController());
  }
}
