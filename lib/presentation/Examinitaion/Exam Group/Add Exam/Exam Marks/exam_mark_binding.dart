import 'package:get/get.dart';
import 'exam_mark_controller.dart';



class AddExamMarkBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(AddExamMarkController());
  }
}
