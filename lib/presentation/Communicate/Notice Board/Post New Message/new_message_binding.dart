import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Communicate/Notice%20Board/Post%20New%20Message/new_message_controller.dart';


class NewMessageBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => TermController());
    Get.put(NewMessageController());
  }
}
