import '../../../core/app_export.dart';
import '../controller/daily_assignment_controller.dart';


/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class DailyAssignmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DailyAssignmentController());
  }
}
