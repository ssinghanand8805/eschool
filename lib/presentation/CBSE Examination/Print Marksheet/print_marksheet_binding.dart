import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Print%20Marksheet/print_marksheet_controller.dart';



class PrintMarksheetBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(PrintMarksheetController());
  }
}
