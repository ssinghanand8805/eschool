import 'package:get/get.dart';
import '../promote_student_controller.dart';





class PromoteStudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PromoteStudentController());
  }
}