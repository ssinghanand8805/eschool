import 'package:anand_s_application1/core/app_export.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../controller/lesson_plan_controller.dart';

class LessonPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LessonPlanController());
  }
}