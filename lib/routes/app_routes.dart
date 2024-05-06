

import 'package:learnladderfaculity/presentation/academics/Assign%20class%20teacher/assign_class_teacher_view.dart';
import 'package:learnladderfaculity/presentation/academics/Class%20Timetable/class_timetable_binding.dart';
import 'package:learnladderfaculity/presentation/academics/Class%20Timetable/class_timetable_view.dart';
import 'package:learnladderfaculity/presentation/download_center/Content%20Share%20List/content_share_list_controller.dart';
import 'package:learnladderfaculity/presentation/download_center/Upload%20Content/Binding/upload_share_content_binding.dart';
import 'package:learnladderfaculity/presentation/school_url/bindings/school_url_binding.dart';
import 'package:learnladderfaculity/presentation/teacher_lesson_plan/Manage%20Syllabus%20Status/manage_syllabus_status_binding.dart';
import 'package:learnladderfaculity/presentation/teacher_lesson_plan/Manage%20Syllabus%20Status/manage_syllabus_status_view_details.dart';
import 'package:learnladderfaculity/presentation/teacher_lesson_plan/Manage_Lesson_Plan/teacher_lesson_plan.dart';
import '../core/app_export.dart';
import '../presentation/about_school/about_school.dart';
import '../presentation/about_school/binding/about_school.dart';
import '../presentation/academics/Assign class teacher/Binding/assign_class_teacher_binding.dart';
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
import '../presentation/download_center/Content Share List/Binding/content_share_list_binding.dart';
import '../presentation/download_center/Content Share List/content_share_list_view.dart';
import '../presentation/download_center/Content Type/Binding/content_type_binding.dart';
import '../presentation/download_center/Content Type/content_type_view.dart';
import '../presentation/download_center/Upload Content/upload_share_content_view.dart';
import '../presentation/download_center/Video Tutorial/Binding/video_tutorial_binding.dart';
import '../presentation/download_center/Video Tutorial/video_tutorial_view.dart';
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
import '../presentation/teacher_lesson_plan/Lesson/binding/lesson_binding.dart';
import '../presentation/teacher_lesson_plan/Lesson/lesson_details.dart';
import '../presentation/teacher_lesson_plan/Manage_Lesson_Plan/binding/teacher_lesson_plan_binding.dart';
import '../presentation/teacher_lesson_plan/Select_Old_Session_Details/binding/select_old_session _details_binding.dart';
import '../presentation/teacher_lesson_plan/Select_Old_Session_Details/select_old_session _details.dart';
import '../presentation/teacher_lesson_plan/Topic/topic_binding.dart';
import '../presentation/teacher_lesson_plan/Topic/topic_view.dart';

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
  static const String managelessonplanRoute = '/manage_lesson_plan';
  static const String lessonRoute = '/lesson';
  static const String uploadcontentRoute = '/upload_content';
  static const String content_typeRoute = '/content_type';
  static const String content_share_listRoute = '/content_share_list';
  static const String upload_share_contentRoute = '/upload_content';
  static const String video_tutorialRoute = '/video_tutorial';
  static const String managesyllabusstatusRoute = '/manage_syllabus_status';
  static const String topicRoute = '/topic';

  static const String classtimetableRoute = '/class_timetable';
  static const String assign_class_teacherRoute = '/assign_class_teacher';


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
    ),

    GetPage(
      name: managelessonplanRoute,
      page: () => TeacherLessonPlanScreen(),
      bindings: [TeacherLessonPlanBinding()],
    ),

    GetPage(
      name: copyoldlessonRoute,
      page: () => SelectOldSessionScreen(),
      bindings: [SelectOldSessionBinding()],
    ),
    GetPage(
      name: lessonRoute,
      page: () => LessonScreen(),
      bindings: [LessonBinding()],
    ),

    GetPage(
      name: managesyllabusstatusRoute,
      page: () => ManageSyllabusStatusScreen(),
      bindings: [ManageSyllabusStatusBinding()],
    ),

    GetPage(
      name: topicRoute,
      page: () => TopicScreen(),
      bindings: [TopicBinding()],
    ),

    GetPage(
      name: content_typeRoute,
      page: () => ContentTypeView(),
      bindings: [ContentTypeBinding()],
    ),

    GetPage(
      name: content_share_listRoute,
      page: () => ContentShareView(),
      bindings: [ContentShareListBinding()],
    ),

    GetPage(
      name: upload_share_contentRoute,
      page: () => UploadShareContentView(),
      bindings: [UploadShareContentBinding()],
    ),

    GetPage(
      name: classtimetableRoute,
      page: () => ClassTimetableScreen(),
      bindings: [ClassTimetableBinding()],
    ),

    GetPage(
      name: video_tutorialRoute,
      page: () => VideoTutorialView(),
      bindings: [VideoTutorialBinding()],
    ),

    GetPage(
      name: assign_class_teacherRoute,
      page: () => AssignClassTeacherView(),
      bindings: [AssignClassTeacherBinding()],
    ),

  ];
}
