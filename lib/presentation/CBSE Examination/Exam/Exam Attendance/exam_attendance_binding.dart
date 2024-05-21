import 'package:get/get.dart';
import 'exam_attendance_controller.dart';



class ExamAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(ExamAttendanceController());
  }
}
