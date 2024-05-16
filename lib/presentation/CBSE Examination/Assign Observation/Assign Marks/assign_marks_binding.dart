import 'package:get/get.dart';
import 'assign_marks_controller.dart';



class AssignMarksBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(AssignMarksController());
  }
}
