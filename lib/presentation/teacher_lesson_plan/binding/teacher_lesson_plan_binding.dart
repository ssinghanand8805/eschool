import 'package:get/get.dart';

import '../controller/teacher_lesson_plan_controller.dart';

class TeacherLessonPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeacherLessonPlanController());
  }
}