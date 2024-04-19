

import 'package:learnladderfaculity/presentation/school_url/bindings/school_url_binding.dart';
import '../core/app_export.dart';
import '../presentation/about_school/about_school.dart';
import '../presentation/about_school/binding/about_school.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import '../presentation/dashboard/binding/dashboard_binding.dart';
import '../presentation/dashboard/dashboard_screen.dart';
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/profile/ProfileScreen.dart';
import '../presentation/profile/binding/profile.dart';
import '../presentation/s_screen/binding/s_binding.dart';
import '../presentation/s_screen/s_screen.dart';
import '../presentation/school_url/schoolUrlScreen.dart';

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String enterSchoolUrlRoute = '/enterSchoolUrl';
  static const String sScreen = '/s_screen';
  static const String loginScreen = '/login_screen';
  static const String formScreen = '/form_screen';
  static const String initialRoute = '/initialRoute';
  static const String profileRoute = '/profile';
  static const String aboutSchoolRoute = '/aboutSchool';
  static const String appNavigationScreen = '/app_navigation_screen';




  static List<GetPage> pages = [
    GetPage(
      name: enterSchoolUrlRoute,
      page: () => SchoolUrl(),
      bindings: [SchoolUrlBinding()],
    ),
    GetPage(
      name: sScreen,
      page: () => SScreen(),
      bindings: [SBinding()],
    ),

    GetPage(
      name: profileRoute,
      page: () => UserProfilePage(),
      bindings: [ProfileBinding()],
    ),

    GetPage(
      name: aboutSchoolRoute,
      page: () => AboutSchoolScreen(),
      bindings: [AboutSchoolBinding()],
    ),

    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
    ),

    GetPage(
      name: formScreen,
      page: () => DashboardScreen(),
      bindings: [dashBordBinding()],
    ),
    GetPage(
      name: appNavigationScreen,
      page: () => AppNavigationScreen(),
      bindings: [AppNavigationBinding()],
    ),
    GetPage(
      name: initialRoute,
      page: () => SScreen(),
      bindings: [SBinding()],
    ),

  ];
}
