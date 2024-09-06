import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Student%20Information/Student%20House/student_house_controller.dart';

class StudentHouseBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(StudentHouseController());
  }

}