
import '../../../core/app_export.dart';
import '../controller/classWork_controller.dart';



/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class ClassWorkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>ClassWorkController());
  }
}
