import 'package:get/get.dart';

import '../controller/daily_assignment_controller.dart';

class TeacherDailyAssignmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeacherDailyAssignmentController());
  }
}
