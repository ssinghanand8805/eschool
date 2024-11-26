import 'package:get/get.dart';
import 'media_manager_controller.dart';


/// A binding class for the FormScreen.
///
/// This class ensures that the FormController is created when the
/// FormScreen is first loaded.
///
class MediaManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MediaManagerController());
  }
}
