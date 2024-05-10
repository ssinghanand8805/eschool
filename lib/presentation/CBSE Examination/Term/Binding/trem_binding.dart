import 'package:get/get.dart';

import '../trem_controller.dart';


class TermBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(TermController());
  }
}
