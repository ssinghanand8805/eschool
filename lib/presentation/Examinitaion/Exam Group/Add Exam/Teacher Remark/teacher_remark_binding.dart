import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Examinitaion/Exam%20Group/Add%20Exam/Teacher%20Remark/teacher_remark_controller.dart';


class AddExamTeacherRemarkBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(AddExamTeacherRemarkController());
  }
}
