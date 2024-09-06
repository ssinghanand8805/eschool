import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Student%20Information/Disabled%20Student/disabled_student_controller.dart';

class DisabledStudentBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => DisabledStudentController());
  }

}