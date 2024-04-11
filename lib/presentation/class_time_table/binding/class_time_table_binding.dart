import '../../../core/app_export.dart';
import '../controller/class_time_table_controller.dart';


/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class ClassTimeTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClassTimeTableController());
  }
}
