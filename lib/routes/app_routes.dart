import 'package:learnladder/presentation/calender_todo/bindings/calendar_todo.dart';
import 'package:learnladder/presentation/calender_todo/calendar_todo_view.dart';
import 'package:learnladder/presentation/cbse_examniations/cbse_examinations_view.dart';
import 'package:learnladder/presentation/class_time_table/ClassTimeTableScreen.dart';
import 'package:learnladder/presentation/class_time_table/binding/class_time_table_binding.dart';
import 'package:learnladder/presentation/download_center/DownloadCenterScreen.dart';
import 'package:learnladder/presentation/download_center/binding/syllabus_status_binding.dart';
import 'package:learnladder/presentation/exam_schedule/exam_schedule_view.dart';
import 'package:learnladder/presentation/examinations/exam%20result/bindings/exam_result_bindings.dart';
import 'package:learnladder/presentation/examinations/exam%20result/exam_result_view.dart';
import 'package:learnladder/presentation/fees/fees_view.dart';
import 'package:learnladder/presentation/homework/HomeworkScreen.dart';
import 'package:learnladder/presentation/hostel_rooms/bindings/hostelrooms.dart';
import 'package:learnladder/presentation/hostel_rooms/hostel_room_view.dart';
import 'package:learnladder/presentation/library/bindings/library.dart';
import 'package:learnladder/presentation/library/library_view.dart';
import 'package:learnladder/presentation/notifications/binding/NotificationBinding.dart';
import 'package:learnladder/presentation/school_url/bindings/school_url_binding.dart';
import 'package:learnladder/presentation/student_timeline/bindings/student_timeline.dart';
import 'package:learnladder/presentation/student_timeline/student_timeline_view.dart';
import 'package:learnladder/presentation/submit_homework/binding/profile.dart';
import 'package:learnladder/presentation/syllabus_lesson/SyllabusLessonScreen.dart';
import 'package:learnladder/presentation/syllabus_lesson/binding/syllabus_lesson_binding.dart';
import 'package:learnladder/presentation/teacher_rating/bindings/teacher_rating.dart';
import 'package:learnladder/presentation/teacher_rating/teacher_rating_view.dart';
import 'package:learnladder/presentation/transport_routes/bindings/transportrouts.dart';
import 'package:learnladder/presentation/transport_routes/transport_route_view.dart';

import '../core/app_export.dart';
import '../presentation/about_school/about_school.dart';
import '../presentation/about_school/binding/about_school.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/app_navigation_screen/binding/app_navigation_binding.dart';
import '../presentation/apply_leave/ApplyLeaveScreen.dart';
import '../presentation/apply_leave/bindings/applyleave.dart';
import '../presentation/attendance/AttendanceScreen.dart';
import '../presentation/attendance/binding/attendance.dart';
import '../presentation/cbse_examniations/binding/cbse_examinations_binding.dart';
import '../presentation/choose_your_option_screen/binding/choose_your_option_binding.dart';
import '../presentation/choose_your_option_screen/choose_your_option_screen.dart';

import '../presentation/daily_assignment/DailyAssignmentScreen.dart';
import '../presentation/daily_assignment/binding/daily_assignment_binding.dart';
import '../presentation/dashboard/binding/dashboard_binding.dart';
import '../presentation/dashboard/dashboard_screen.dart';
import '../presentation/exam_schedule/binding/exam_schedule_binding.dart';
import '../presentation/examinations/ExaminationScreen.dart';
import '../presentation/examinations/bindings/Examination.dart';
import '../presentation/fees/bindings/fees.dart';
import '../presentation/homework/binding/homework_binding.dart';
import '../presentation/lesson_plan/binding/lesson_plan_binding.dart';
import '../presentation/lesson_plan/lesson_plan.dart';
import '../presentation/login_screen/binding/login_binding.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/mydocuments/MyDocumentsScreen.dart';
import '../presentation/mydocuments/binding/mydocuments_binding.dart';
import '../presentation/notice_board/NoticeBoardScreen.dart';
import '../presentation/notice_board/binding/notice_board_binding.dart';
import '../presentation/notifications/NotificationScreen.dart';
import '../presentation/profile/ProfileScreen.dart';
import '../presentation/profile/binding/profile.dart';
import '../presentation/s_screen/binding/s_binding.dart';
import '../presentation/s_screen/s_screen.dart';
import '../presentation/school_url/schoolUrlScreen.dart';
import '../presentation/submit_homework/submit_homework.dart';
import '../presentation/syllabus_status/SyllabuStatusScreen.dart';
import '../presentation/syllabus_status/binding/syllabus_status_binding.dart';
import '../presentation/teacher_login_screen/binding/teacher_login_binding.dart';
import '../presentation/teacher_login_screen/teacher_login_screen.dart';
import '../presentation/visitor/bindings/visitorbook.dart';
import '../presentation/visitor/visitor_bookScreen.dart'; // ignore_for_file: must_be_immutable

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
  static const String exam_result_view = '/exam_result_view';

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
  static const String visitorbookRoute = '/visitor_book';
  static const String applyleaveRoute = '/apply_leave';
  static const String transportroutesRoute = '/transport_routes';
  static const String hostelroomsRoute = '/hostel_rooms';
  static const String calendartodolistRoute = '/calendar_to_do_list';
  static const String libraryRoute = '/library';
  static const String teachersratingRoute = '/teachers_rating';
  static const String studenttimelineRoute = '/student_timeline';
  static const String transportRoute = '/student_timeline';
  static const String feesRoute = '/fees';
  static const String notificationListRoute = '/notificationsList';

  static const String enterSchoolUrlRoute = '/enterSchoolUrl';
  static const String examScheduleRoute = '/examSchedule';

  static List<GetPage> pages = [
    GetPage(
      name: enterSchoolUrlRoute,
      page: () => SchoolUrl(),
      bindings: [SchoolUrlBinding()],
    ),
    GetPage(
      name: cbseexamRoute,
      page: () => CbseExaminationsScreen(),
      bindings: [CbseExaminationsBinding()],
    ),
    GetPage(
      name: examScheduleRoute,
      page: () => ExamScheduleScreen(),
      bindings: [ExamScheduleBinding()],
    ),
    GetPage(
      name: sScreen,
      page: () => SScreen(),
      bindings: [SBinding()],
    ),
    GetPage(
      name: applyleaveRoute,
      page: () => ApplyLeavePage(),
      bindings: [ApplyLeaveBinding()],
    ),
    GetPage(
      name: notificationListRoute,
      page: () => NotificationScreen(),
      bindings: [NotificationBinding()],
    ),
    GetPage(
      name: visitorbookRoute,
      page: () => VisitorBookPage(),
      bindings: [VisitorBookBinding()],
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
      page: () => DownloadCenterScreen(),
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
    ),
    GetPage(
      name: transportroutesRoute,
      page: () => TransportRoutesPage(),
      bindings: [TransportRoutesBinding()],
    ),
    GetPage(
      name: hostelroomsRoute,
      page: () => HostelRoomsPage(),
      bindings: [HostelRoomsBinding()],
    ),
    GetPage(
      name: calendartodolistRoute,
      page: () => CalendarTodoPage(),
      bindings: [CalendarTodoBinding()],
    ),
    GetPage(
      name: libraryRoute,
      page: () => LibraryPage(),
      bindings: [LibraryBinding()],
    ),
    GetPage(
      name: teachersratingRoute,
      page: () => TeacherRatingPage(),
      bindings: [TeacherRatingBinding()],
    ),
    GetPage(
      name: studenttimelineRoute,
      page: () => StudentTimeLinePage(),
      bindings: [StudentTimeLineBinding()],
    ),
    GetPage(
      name: examinationsRoute,
      page: () => ExaminationPage(),
      bindings: [ExaminationBinding()],
    ),
    GetPage(
      name: exam_result_view,
      page: () => ExamResultView(),
      bindings: [ExamResultBindings()],
    ),
    GetPage(
      name: feesRoute,
      page: () => FeesPage(),
      bindings: [FeesBinding()],
    ),
  ];
}
