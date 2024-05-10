import 'package:get/get.dart';

import '../teacher_time_table_controller.dart';





class TeacherTimeTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeacherTimeTableController());
  }
}