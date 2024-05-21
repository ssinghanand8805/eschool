import 'package:get/get.dart';

import 'exam_subject_controller.dart';



class AddExamExamSubjectBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(AddExamExamSubjectController());
  }
}
