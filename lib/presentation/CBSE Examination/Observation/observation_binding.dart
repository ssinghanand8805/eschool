import 'package:get/get.dart';
import 'observation_controller.dart';



class ObservationBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(ObservationController());
  }
}
