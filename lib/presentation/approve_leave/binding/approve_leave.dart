import 'package:get/get.dart';

import '../controller/approve_leave_controller.dart';




/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class ApproveLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApproveLeaveController());
  }
}
