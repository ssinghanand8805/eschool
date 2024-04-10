import '../../../core/app_export.dart';
import '../models/choose_your_option_model.dart';

/// A controller class for the ChooseYourOptionScreen.
///
/// This class manages the state of the ChooseYourOptionScreen, including the
/// current chooseYourOptionModelObj
class ChooseYourOptionController extends GetxController {
  Rx<ChooseYourOptionModel> chooseYourOptionModelObj =
      ChooseYourOptionModel().obs;
}
