import 'package:get/get.dart';
import 'notice_board_controller.dart';


class NoticeBoardBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(NoticeBoardController());
  }
}