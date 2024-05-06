import 'package:get/get.dart';
import '../assign_class_teacher_controller.dart';





class AssignClassTeacherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AssignClassTeacherController());
  }
}