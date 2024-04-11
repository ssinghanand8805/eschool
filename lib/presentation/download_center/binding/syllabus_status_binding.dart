import '../../../core/app_export.dart';
import '../controller/download_center_controller.dart';



/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class DownloadCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>DownloadCenterController());
  }
}
