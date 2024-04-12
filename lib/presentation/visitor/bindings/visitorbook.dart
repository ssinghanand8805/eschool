
import '../../../core/app_export.dart';
import '../controller/visitor_book_Controller.dart';



/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class VisitorBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>VisitorBookController());
  }
}
