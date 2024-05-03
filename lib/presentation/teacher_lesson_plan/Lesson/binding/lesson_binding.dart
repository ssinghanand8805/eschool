import 'package:get/get.dart';

import '../controller/lesson_controller.dart';



class LessonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LessonController());
  }
}