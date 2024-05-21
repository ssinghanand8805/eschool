import 'package:get/get.dart';
import 'exam_group_controller.dart';


class ExamGroupBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(ExamGroupController());
  }
}
