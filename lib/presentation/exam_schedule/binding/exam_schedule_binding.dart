import '../../../core/app_export.dart';
import '../controller/exam_schedule_controller.dart';


/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class ExamScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExamScheduleController());
  }
}
