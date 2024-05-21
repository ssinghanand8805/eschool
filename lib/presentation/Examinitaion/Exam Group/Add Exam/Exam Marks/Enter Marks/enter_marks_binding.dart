import 'package:get/get.dart';
import 'enter_marks_controller.dart';




class AddExamEnterMarksBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(AddExamEnterMarksController());
  }
}
