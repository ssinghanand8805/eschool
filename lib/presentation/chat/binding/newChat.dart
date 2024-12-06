import 'package:get/get.dart';

import '../controller/UserListController.dart';




class NewChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => UserListController());
  }

}