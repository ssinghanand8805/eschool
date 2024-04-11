import 'package:learnladder/presentation/syllabus_lesson/controller/syllabus_lesson_controller.dart';

import '../../../core/app_export.dart';



/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class SyllabusLessonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SyllabusLessonController());
  }
}
