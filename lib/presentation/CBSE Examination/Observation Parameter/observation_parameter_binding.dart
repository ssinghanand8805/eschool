import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Observation%20Parameter/observation_parameter_controller.dart';



class ObservationParameterBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(ObservationParameterController());
  }
}
