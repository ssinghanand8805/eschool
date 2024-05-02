import 'package:get/get.dart';

import '../controller/select_old_session _details_controller.dart';


class SelectOldSessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectOldSessionController());
  }
}