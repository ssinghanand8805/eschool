import 'package:get/get.dart';

import '../controller/add_homework_controller.dart';






/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class AddHomeWorkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddHomeWorkController());
  }
}
