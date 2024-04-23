import 'package:get/get.dart';

import '../controller/attendance_bydate_controller.dart';





/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class AttendanceByDateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceByDateController());
  }
}
