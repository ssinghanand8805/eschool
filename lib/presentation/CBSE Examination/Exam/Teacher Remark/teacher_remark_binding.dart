import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Exam/Teacher%20Remark/teacher_remark_controller.dart';


class TeacherRemarkBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(TeacherRemarkController());
  }
}
