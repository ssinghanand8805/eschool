
import '../../../core/app_export.dart';
import '../controller/calendar_todo_controller.dart';



/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class CalendarTodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalendarTodoController());
  }
}
