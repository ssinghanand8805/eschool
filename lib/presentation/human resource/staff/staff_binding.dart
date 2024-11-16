import 'package:get/get.dart';
import 'staff_controller.dart';


/// A binding class for the FormScreen.
///
/// This class ensures that the FormController is created when the
/// FormScreen is first loaded.
///
class StaffBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StaffController());
  }
}
