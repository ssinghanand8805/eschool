import 'package:get/get.dart';
import 'assign_observation_controller.dart';



class AssignObservationBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(AssignObservationController());
  }
}
