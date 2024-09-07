import 'package:get/get.dart';
import '../video_tutorial_controller.dart';


/// A binding class for the FormScreen.
///
/// This class ensures that the FormController is created when the
/// FormScreen is first loaded.
///
class VideoTutorialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoTutorialController());
  }
}
