import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Exam%20Grade/exam_grade_controller.dart';

import '../exam_controller.dart';



class ExamBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(ExamController());
  }
}
