
import '../../../core/app_export.dart';
import '../controller/hostel_room_controller.dart';



/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class HostelRoomsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() =>HostelRoomsController());
  }
}
