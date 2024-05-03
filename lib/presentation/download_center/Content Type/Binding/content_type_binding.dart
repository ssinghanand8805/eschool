import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/download_center/Content%20Type/content_type_controller.dart';


/// A binding class for the FormScreen.
///
/// This class ensures that the FormController is created when the
/// FormScreen is first loaded.
///
class ContentTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContentTypeController());
  }
}
