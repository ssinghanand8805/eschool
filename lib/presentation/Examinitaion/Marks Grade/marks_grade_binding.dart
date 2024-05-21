import 'package:get/get.dart';
import 'marks_grade_controller.dart';


class MarksGradeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(MarksGradeController());
  }
}
