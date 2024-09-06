import 'package:get/get.dart';
import 'import_student_controller.dart';



class ImportStudentBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(ImportStudentController());
  }
}
