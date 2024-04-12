import 'package:get/get.dart';
import 'package:learnladder/presentation/examinations/exam%20result/controller/exam_result_controller.dart';

class ExamResultBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ExamResultController());
  }

}