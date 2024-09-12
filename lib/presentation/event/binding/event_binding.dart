import 'package:lerno/presentation/attendance/model/Attendance.dart';

import '../../../core/app_export.dart';
import '../../dashboard/controller/event_controller.dart';

/// A binding class for the FormScreen.
///
/// This class ensures that the FormController is created when the
/// FormScreen is first loaded.
class EventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EventController());
  }
}
