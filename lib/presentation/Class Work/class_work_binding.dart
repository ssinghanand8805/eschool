import 'package:get/get.dart';

import 'class_work_controller.dart';

class ClassWorkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClassWorkController());
  }
}
