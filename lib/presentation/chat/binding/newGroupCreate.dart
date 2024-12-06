import 'package:get/get.dart';

import '../controller/GroupController.dart';




class NewGroupCreateBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => GroupController());
  }

}