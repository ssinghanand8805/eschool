
import '../../../core/app_export.dart';
import '../controller/ExaminationController.dart';



/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class ExaminationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>ExaminationController());
  }
}
