import 'package:get/get.dart';

import '../subject_group_controller.dart';





class SubjectGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubjectGroupController());
  }
}