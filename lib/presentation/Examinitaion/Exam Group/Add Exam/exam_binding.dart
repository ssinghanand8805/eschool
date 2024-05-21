import 'package:get/get.dart';
import 'exam_controller.dart';


class AddExamBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(AddExamController());
  }
}
