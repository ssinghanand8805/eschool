import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Student%20Information/Student%20Details/student_details_controller.dart';
import 'package:learnladderfaculity/presentation/library/add%20student/add_student_controller.dart';



class AddStudentBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put( AddStudentController());
  }
}
