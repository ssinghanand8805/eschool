import 'package:get/get.dart';

import 'manage_syllabus_status_controller.dart';



class ManageSyllabusStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageSyllabusStatusController());
  }
}