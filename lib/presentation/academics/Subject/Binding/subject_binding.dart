import 'package:get/get.dart';
import '../subject_controller.dart';





class SubjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubjectController());
  }
}