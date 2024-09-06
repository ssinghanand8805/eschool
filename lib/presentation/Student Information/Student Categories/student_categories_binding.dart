import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Student%20Information/Student%20Categories/student_categories_controller.dart';



class StudentCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(StudentCategoriesController());
  }
}
