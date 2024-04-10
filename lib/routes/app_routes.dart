import 'package:anand_s_application1/presentation/homework/HomeworkScreen.dart';

import '../core/app_export.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import '../presentation/choose_your_option_screen/binding/choose_your_option_binding.dart';
import '../presentation/choose_your_option_screen/choose_your_option_screen.dart';

import '../presentation/dashboard/binding/dashboard_binding.dart';
import '../presentation/dashboard/dashboard_screen.dart';
import '../presentation/homework/binding/homework_binding.dart';
import '../presentation/lesson_plan/binding/lesson_plan_binding.dart';
import '../presentation/lesson_plan/lesson_plan.dart';
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/s_screen/binding/s_binding.dart';
import '../presentation/s_screen/s_screen.dart';
import '../presentation/teacher_login_screen/binding/teacher_login_binding.dart';
import '../presentation/teacher_login_screen/teacher_login_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String sScreen = '/s_screen';

  static const String chooseYourOptionScreen = '/choose_your_option_screen';

  static const String loginScreen = '/login_screen';
  static const String lessonPlanScreen = '/lesson_plan';

  static const String teacherLoginScreen = '/teacher_login_screen';

  static const String formScreen = '/form_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';
  static const String homeworkRoute = '/homework';

  static List<GetPage> pages = [
    GetPage(
      name: sScreen,
      page: () => SScreen(),
      bindings: [SBinding()],
    ),
    GetPage(
      name: chooseYourOptionScreen,
      page: () => ChooseYourOptionScreen(),
      bindings: [ChooseYourOptionBinding()],
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      bindings: [LoginBinding()],
    ),
    GetPage(
      name: lessonPlanScreen,
      page: () => LessonPlanScreen(),
      bindings: [LessonPlanBinding()],
    ),
    GetPage(
      name: homeworkRoute,
      page: () => HomeworkScreen(),
      bindings: [HomeWorkBinding()],
    ),
    GetPage(
      name: teacherLoginScreen,
      page: () => TeacherLoginScreen(),
      bindings: [TeacherLoginBinding()],
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
    )
  ];
}
