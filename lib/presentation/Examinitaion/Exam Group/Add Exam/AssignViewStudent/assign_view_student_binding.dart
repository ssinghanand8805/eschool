import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Exam%20Grade/exam_grade_controller.dart';

import '../exam_controller.dart';
import 'assign_view_student_controller.dart';



class AddExamAssignViewStudentBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(AddExamAssignViewStudentController());
  }
}
