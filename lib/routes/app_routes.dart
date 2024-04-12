import 'package:learnladder/presentation/class_time_table/ClassTimeTableScreen.dart';
import 'package:learnladder/presentation/class_time_table/binding/class_time_table_binding.dart';
import 'package:learnladder/presentation/download_center/DownloadCenterScreen.dart';
import 'package:learnladder/presentation/download_center/binding/syllabus_status_binding.dart';
import 'package:learnladder/presentation/homework/HomeworkScreen.dart';
import 'package:learnladder/presentation/submit_homework/binding/profile.dart';
import 'package:learnladder/presentation/syllabus_lesson/SyllabusLessonScreen.dart';
import 'package:learnladder/presentation/syllabus_lesson/binding/syllabus_lesson_binding.dart';

import '../core/app_export.dart';
import '../presentation/about_school/about_school.dart';
import '../presentation/about_school/binding/about_school.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import '../presentation/attendance/AttendanceScreen.dart';
import '../presentation/attendance/binding/attendance.dart';
import '../presentation/choose_your_option_screen/binding/choose_your_option_binding.dart';
import '../presentation/choose_your_option_screen/choose_your_option_screen.dart';

import '../presentation/daily_assignment/DailyAssignmentScreen.dart';
import '../presentation/daily_assignment/binding/daily_assignment_binding.dart';
import '../presentation/dashboard/binding/dashboard_binding.dart';
import '../presentation/dashboard/dashboard_screen.dart';
import '../presentation/homework/binding/homework_binding.dart';
import '../presentation/lesson_plan/binding/lesson_plan_binding.dart';
import '../presentation/lesson_plan/lesson_plan.dart';
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/mydocuments/MyDocumentsScreen.dart';
import '../presentation/mydocuments/binding/mydocuments_binding.dart';
import '../presentation/notice_board/NoticeBoardScreen.dart';
import '../presentation/notice_board/binding/notice_board_binding.dart';
import '../presentation/profile/ProfileScreen.dart';
import '../presentation/profile/binding/profile.dart';
import '../presentation/s_screen/binding/s_binding.dart';
import '../presentation/s_screen/s_screen.dart';
import '../presentation/submit_homework/submit_homework.dart';
import '../presentation/syllabus_status/SyllabuStatusScreen.dart';
import '../presentation/syllabus_status/binding/syllabus_status_binding.dart';
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
  static const String dailyAssignmentRoute = '/daily_assignment';
  static const String class_timetableRoute = '/class_timetable';
  static const String notice_boardRoute = '/notice_board';
  static const String syllabus_statusRoute = '/syllabus_status';
  static const String syllabus_lessonRoute = '/syllabus_lesson';
  static const String download_centerRoute = '/download_center';


  //todo
  static const String online_examinationRoute = '/online_examination';
  static const String attendanceRoute = '/attendance';
  static const String profileRoute = '/profile';
  static const String aboutSchoolRoute = '/aboutSchool';
  static const String examinationsRoute = '/examinations';
  static const String student_timelineRoute = '/student_timeline';
  static const String mydocumentsRoute = '/mydocuments';
  static const String cbseexamRoute = '/cbseexam';
  static const String sumithomeworkRoute = '/sumithomework';

  static List<GetPage> pages = [
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
      name: mydocumentsRoute,
      page: () => MyDocumentsScreen(),
      bindings: [MyDocumentsBinding()],
    ),
    GetPage(
      name: sumithomeworkRoute,
      page: () => UploadHomework(),
      bindings: [SubmitHomeworkBinding()],
    ),
    GetPage(
      name: aboutSchoolRoute,
      page: () => AboutSchoolScreen(),
      bindings: [AboutSchoolBinding()],
    ),
    GetPage(
      name: attendanceRoute,
      page: () => AttendanceScreen(),
      bindings: [AttendanceBinding()],
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
      name: dailyAssignmentRoute,
      page: () => DailyAssignmentScreen(),
      bindings: [DailyAssignmentBinding()],
    ),
    GetPage(
      name: class_timetableRoute,
      page: () => ClassTimeTableScreen(),
      bindings: [ClassTimeTableBinding()],
    ),
    GetPage(
      name: notice_boardRoute,
      page: () => NoticeBoardScreen(),
      bindings: [NoticeBoardBinding()],
    ),
    GetPage(
      name: lessonPlanScreen,
      page: () => LessonPlanScreen(),
      bindings: [LessonPlanBinding()],
    ),
    GetPage(
      name: download_centerRoute,
      page: () =>DownloadCenterScreen(),
      bindings: [DownloadCenterBinding()],
    ),
    GetPage(
      name: syllabus_statusRoute,
      page: () => SyllabuStatusScreen(),
      bindings: [SyllabuStatusBinding()],
    ),
    GetPage(
      name: syllabus_lessonRoute,
      page: () => SyllabusLessonScreen(),
      bindings: [SyllabusLessonBinding()],
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
