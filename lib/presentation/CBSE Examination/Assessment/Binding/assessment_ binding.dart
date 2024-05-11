import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Exam%20Grade/exam_grade_controller.dart';

import '../assessment_ controller.dart';



class AssessmentBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(AssessmentController());
  }
}
