import 'package:get/get.dart';
import 'balance_fee_controller.dart';


/// A binding class for the FormScreen.
///
/// This class ensures that the FormController is created when the
/// FormScreen is first loaded.
///
class BalanceFeesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BalanceFeeController());
  }
}
