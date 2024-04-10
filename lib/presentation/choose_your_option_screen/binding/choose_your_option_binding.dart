import '../../../core/app_export.dart';
import '../controller/choose_your_option_controller.dart';

/// A binding class for the ChooseYourOptionScreen.
///
/// This class ensures that the ChooseYourOptionController is created when the
/// ChooseYourOptionScreen is first loaded.
class ChooseYourOptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChooseYourOptionController());
  }
}
