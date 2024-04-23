import 'package:get/get.dart';

import '../controller/student_attendance_controller.dart';





/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class StudentAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StudentAttendanceController());
  }
}
