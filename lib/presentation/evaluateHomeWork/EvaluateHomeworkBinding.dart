import 'package:get/get.dart';

import 'EvaluateHomeworkController.dart';


class EvaluateHomeworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EvaluateHomeworkController());
  }
}