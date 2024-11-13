import 'package:get/get.dart';
import 'book_list_controller.dart';


/// A binding class for the FormScreen.
///
/// This class ensures that the FormController is created when the
/// FormScreen is first loaded.
///
class BookListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>  BookListController());
  }
}
