

import 'package:learnladderfaculity/presentation/school_url/bindings/school_url_binding.dart';
import 'package:learnladderfaculity/presentation/teacher_lesson_plan/binding/teacher_lesson_plan_binding.dart';
import 'package:learnladderfaculity/presentation/teacher_lesson_plan/teacher_lesson_plan.dart';
import '../core/app_export.dart';
import '../presentation/about_school/about_school.dart';
import '../presentation/about_school/binding/about_school.dart';
import '../presentation/add_homework/add_homework_view.dart';
import '../presentation/add_homework/binding/add_homework.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import '../presentation/approve_leave/approve_leave_view.dart';
import '../presentation/approve_leave/binding/approve_leave.dart';
import '../presentation/attendance_bydate/attendance_bydate_view.dart';
import '../presentation/attendance_bydate/binding/attendance_bydate.dart';
import '../presentation/dashboard/binding/dashboard_binding.dart';
import '../presentation/dashboard/dashboard_screen.dart';
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/profile/ProfileScreen.dart';
import '../presentation/profile/binding/profile.dart';
import '../presentation/s_screen/binding/s_binding.dart';
import '../presentation/s_screen/s_screen.dart';
import '../presentation/school_url/schoolUrlScreen.dart';
import '../presentation/student_attendence/binding/student_attendance.dart';
import '../presentation/student_attendence/student_attendance_view.dart';
import '../presentation/teacher_daily_assignment/binding/daily_assignment.dart';
import '../presentation/teacher_daily_assignment/daily_assignment_view.dart';

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
  static const String approveLeaveRoute = '/approve_leave';
  static const String attendanceByDateRoute = '/attendance_by_date';
  static const String studentAttendanceRoute = '/student_attendance';
  static const String addHomeworkRoute = '/homework_evaluation';
  static const String teacherDailyAssignmentRoute = '/daily_assignment';
  static const String copyoldlessonRoute = '/copy_old_lesson';



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
    GetPage(
      name: addHomeworkRoute,
      page: () => AddHomeWorkScreen(),
      bindings: [AddHomeWorkBinding()],
    ),
    GetPage(
      name: teacherDailyAssignmentRoute,
      page: () => TeacherDailyAssignmentScreen(),
      bindings: [TeacherDailyAssignmentBinding()],
    ),

    GetPage(
      name: approveLeaveRoute,
      page: () => ApproveLeaveScreen(),
      bindings: [ApproveLeaveBinding()],
    ),
    GetPage(
      name: attendanceByDateRoute,
      page: () => AttendanceByDateScreen(),
      bindings: [AttendanceByDateBinding()],
    ),
    GetPage(
      name: studentAttendanceRoute,
      page: () => StudentAttendanceScreen(),
      bindings: [StudentAttendanceBinding()],
    ),GetPage(
      name: copyoldlessonRoute,
      page: () => TeacherLessonPlanScreen(),
      bindings: [TeacherLessonPlanBinding()],
    ),

  ];
}
