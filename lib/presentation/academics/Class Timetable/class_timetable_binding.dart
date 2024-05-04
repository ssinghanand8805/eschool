import 'package:get/get.dart';

import 'class_timetable_controller.dart';





class ClassTimetableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClassTimetableController());
  }
}