import '../../../core/app_export.dart';
import '../../dashboard_chart/dashboard_chart_controller.dart';
import '../controller/dashbord_controller.dart';

/// A binding class for the FormScreen.
///
/// This class ensures that the FormController is created when the
/// FormScreen is first loaded.
class dashBordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardChartController());
    Get.lazyPut(() => DashboardController());
  }
}
