import 'package:get/get.dart';
import 'assign_view_student_controller.dart';



class AddExamAssignViewStudentBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(AddExamAssignViewStudentController());
  }
}
