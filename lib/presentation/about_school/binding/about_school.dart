import 'package:learnladder/presentation/about_school/controller/about_schoolController.dart';


import '../../../core/app_export.dart';



/// A binding class for the LoginScreen.
///
/// This class ensures that the LoginController is created when the
/// LoginScreen is first loaded.
class AboutSchoolBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutSchoolController());
  }
}
