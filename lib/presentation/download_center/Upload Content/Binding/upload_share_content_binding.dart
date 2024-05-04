import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/download_center/Upload%20Content/upload_share_content_controller.dart';


/// A binding class for the FormScreen.
///
/// This class ensures that the FormController is created when the
/// FormScreen is first loaded.
///
class UploadShareContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UploadShareContentController());
  }
}
