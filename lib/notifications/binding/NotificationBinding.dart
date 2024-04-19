import '../../../core/app_export.dart';
import '../controller/NotificationController.dart';




/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>NotificationController());
  }
}
