import 'package:get/get.dart';
import '../class_controller.dart';





class ClassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClassController());
  }
}