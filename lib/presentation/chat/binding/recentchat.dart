import 'package:get/get.dart';


import '../controller/RecentChatController.dart';

class RecentChatBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RecentChatController());
  }

}