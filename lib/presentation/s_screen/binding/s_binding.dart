import '../../../core/app_export.dart';
import '../controller/s_controller.dart';

/// A binding class for the SScreen.
///
/// This class ensures that the SController is created when the
/// SScreen is first loaded.
class SBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SController());
  }
}
