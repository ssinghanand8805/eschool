import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/fees/daily_collection/daily_collection_controller.dart';



/// A binding class for the FormScreen.
///
/// This class ensures that the FormController is created when the
/// FormScreen is first loaded.
///
class DailyCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DailyCollectionController());
  }
}
