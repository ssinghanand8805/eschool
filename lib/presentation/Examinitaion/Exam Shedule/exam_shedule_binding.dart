import 'package:get/get.dart';

import '../../CBSE Examination/Exam Schedule/exam_schedule_controller.dart';


class ExamScheduleBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(ExamScheduleController());
  }
}
