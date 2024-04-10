import '../../../core/app_export.dart';
import '../controller/teacher_login_controller.dart';

/// A binding class for the TeacherLoginScreen.
///
/// This class ensures that the TeacherLoginController is created when the
/// TeacherLoginScreen is first loaded.
class TeacherLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeacherLoginController());
  }
}
