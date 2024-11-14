import 'package:get/get.dart';
import 'approve_leave_controller.dart';


/// A binding class for the FormScreen.
///
/// This class ensures that the FormController is created when the
/// FormScreen is first loaded.
///
class ApproveLeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApproveLeaveController());
  }
}
