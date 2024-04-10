import '../../../core/app_export.dart';
import '../models/teacher_login_model.dart';

/// A controller class for the TeacherLoginScreen.
///
/// This class manages the state of the TeacherLoginScreen, including the
/// current teacherLoginModelObj
class TeacherLoginController extends GetxController {
  Rx<TeacherLoginModel> teacherLoginModelObj = TeacherLoginModel().obs;
}
