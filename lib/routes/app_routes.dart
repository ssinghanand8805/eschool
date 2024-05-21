

import 'package:learnladderfaculity/presentation/CBSE%20Examination/Assign%20Observation/Assign%20Marks/assign_marks_binding.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Assign%20Observation/Assign%20Marks/assign_marks_view.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Assign%20Observation/assign_observation_view.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Exam/Exam%20Marks/exam_mark_binding.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Observation%20Parameter/observation_parameter_binding.dart';
import 'package:learnladderfaculity/presentation/Examinitaion/Exam%20Group/Add%20Exam/Exam%20Marks/Enter%20Marks/enter_marks_view.dart';
import 'package:learnladderfaculity/presentation/academics/Assign%20class%20teacher/assign_class_teacher_view.dart';
import 'package:learnladderfaculity/presentation/academics/Class%20Timetable/class_timetable_binding.dart';
import 'package:learnladderfaculity/presentation/academics/Class%20Timetable/class_timetable_view.dart';
import 'package:learnladderfaculity/presentation/academics/Class/Binding/class_binding.dart';
import 'package:learnladderfaculity/presentation/academics/Promote%20Student/Binding/promote_student_bindding.dart';
import 'package:learnladderfaculity/presentation/academics/Subject/subject_view.dart';
import 'package:learnladderfaculity/presentation/download_center/Upload%20Content/Binding/upload_share_content_binding.dart';
import 'package:learnladderfaculity/presentation/school_url/bindings/school_url_binding.dart';
import 'package:learnladderfaculity/presentation/teacher_lesson_plan/Manage%20Syllabus%20Status/manage_syllabus_status_binding.dart';
import 'package:learnladderfaculity/presentation/teacher_lesson_plan/Manage%20Syllabus%20Status/manage_syllabus_status_view_details.dart';
import 'package:learnladderfaculity/presentation/teacher_lesson_plan/Manage_Lesson_Plan/teacher_lesson_plan.dart';
import '../core/app_export.dart';
import '../presentation/CBSE Examination/Assessment/Binding/assessment_ binding.dart';
import '../presentation/CBSE Examination/Assessment/assessment_view.dart';
import '../presentation/CBSE Examination/Assign Observation/assign_observation_binding.dart';
import '../presentation/CBSE Examination/Exam Grade/Binding/exam_grade_binding.dart';
import '../presentation/CBSE Examination/Exam Grade/exam_grade_view.dart';
import '../presentation/CBSE Examination/Exam Schedule/exam_schedule_binding.dart';
import '../presentation/CBSE Examination/Exam Schedule/exam_schedule_view.dart';
import '../presentation/CBSE Examination/Exam/AssignViewStudent/assign_view_student_binding.dart';
import '../presentation/CBSE Examination/Exam/AssignViewStudent/assign_view_student_view.dart';
import '../presentation/CBSE Examination/Exam/Binding/exam_binding.dart';
import '../presentation/CBSE Examination/Exam/Exam Attendance/exam_attendance_binding.dart';
import '../presentation/CBSE Examination/Exam/Exam Attendance/exam_attendance_view.dart';
import '../presentation/CBSE Examination/Exam/Exam Marks/Enter Marks/enter_marks_binding.dart';
import '../presentation/CBSE Examination/Exam/Exam Marks/Enter Marks/enter_marks_view.dart';
import '../presentation/CBSE Examination/Exam/Exam Marks/exam_mark_view.dart';
import '../presentation/CBSE Examination/Exam/Exam Subject/exam_subject_binding.dart';
import '../presentation/CBSE Examination/Exam/Exam Subject/exam_subject_view.dart';
import '../presentation/CBSE Examination/Exam/Teacher Remark/teacher_remark_binding.dart';
import '../presentation/CBSE Examination/Exam/Teacher Remark/teacher_remark_view.dart';
import '../presentation/CBSE Examination/Exam/exam_view.dart';
import '../presentation/CBSE Examination/Observation Parameter/observation_parameter_view.dart';
import '../presentation/CBSE Examination/Observation/observation_binding.dart';
import '../presentation/CBSE Examination/Observation/observation_view.dart';
import '../presentation/CBSE Examination/Print Marksheet/print_marksheet_binding.dart';
import '../presentation/CBSE Examination/Print Marksheet/print_marksheet_view.dart';
import '../presentation/CBSE Examination/Term/Binding/trem_binding.dart';
import '../presentation/CBSE Examination/Term/trem_view.dart';
import '../presentation/Examinitaion/Exam Group/Add Exam/AssignViewStudent/assign_view_student_binding.dart';
import '../presentation/Examinitaion/Exam Group/Add Exam/AssignViewStudent/assign_view_student_view.dart';
import '../presentation/Examinitaion/Exam Group/Add Exam/Exam Marks/Enter Marks/enter_marks_binding.dart';
import '../presentation/Examinitaion/Exam Group/Add Exam/Exam Marks/exam_mark_binding.dart';
import '../presentation/Examinitaion/Exam Group/Add Exam/Exam Marks/exam_mark_view.dart';
import '../presentation/Examinitaion/Exam Group/Add Exam/Exam Subject/exam_subject_binding.dart';
import '../presentation/Examinitaion/Exam Group/Add Exam/Exam Subject/exam_subject_view.dart';
import '../presentation/Examinitaion/Exam Group/Add Exam/Teacher Remark/teacher_remark_binding.dart';
import '../presentation/Examinitaion/Exam Group/Add Exam/Teacher Remark/teacher_remark_view.dart';
import '../presentation/Examinitaion/Exam Group/Add Exam/exam_binding.dart';
import '../presentation/Examinitaion/Exam Group/Add Exam/exam_view.dart';
import '../presentation/Examinitaion/Exam Group/exam_group_binding.dart';
import '../presentation/Examinitaion/Exam Group/exam_group_view.dart';
import '../presentation/Examinitaion/Marks Grade/marks_grade_binding.dart';
import '../presentation/Examinitaion/Marks Grade/marks_grade_view.dart';
import '../presentation/about_school/about_school.dart';
import '../presentation/about_school/binding/about_school.dart';
import '../presentation/academics/Assign class teacher/Binding/assign_class_teacher_binding.dart';
import '../presentation/academics/Class/class_view.dart';
import '../presentation/academics/Promote Student/promote_student_view.dart';
import '../presentation/academics/Section/Binding/section_binding.dart';
import '../presentation/academics/Section/section_view.dart';
import '../presentation/academics/Subject Group/Binding/subject_group_binding.dart';
import '../presentation/academics/Subject Group/subject_group_view.dart';
import '../presentation/academics/Subject/Binding/subject_binding.dart';
import '../presentation/academics/Teacher Time Table/Binding/teacher_time_table_binding.dart';
import '../presentation/academics/Teacher Time Table/teacher_time_table_view.dart';
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
  static const String promote_studentRoute = '/promote_student';
  static const String subject_groupRoute = '/subject_group';
  static const String subjectRoute = '/subject';
  static const String classRoute = '/class';
  static const String sectionRoute = '/section';
  static const String teachers_time_tableRoute = '/teachers_time_table';



  static const String termRoute = '/term';
  static const String exam_gradeRoute = '/exam_grade';
  static const String assessmentRoute = '/assessment';
  static const String examRoute = '/exam';
  static const String assign_view_studentRoute = '/assign_view_student';
  static const String exam_subjectRoute = '/exam_subject';
  static const String assign_observationRoute = '/assign_observation';
  static const String assign_marksRoute = '/assign_marks';
  static const String observation_ParameterRoute = '/observation_Parameter';
  static const String exam_markRoute = '/exam_mark';
  static const String enter_marksRoute = '/enter_marks';
  static const String exam_attendanceRoute = '/exam_attendance';
  static const String teacher_remarkRoute = '/teacher_remark';
  static const String print_marksheetRoute = '/print_marksheet';
  static const String observationRoute = '/observation';
  static const String exam_scheduleRoute = '/exam_schedule';

      /// EXAMINATION
  static const String marks_gradeRoute = '/marks_grade';
  static const String exam_groupRoute = '/exam_group';
  static const String add_exam_groupRoute = '/add_exam_group';
  static const String add_exam_assign_view_studentRoute = '/add_exam_assign_view_student';
  static const String add_exam_exam_subjectRoute = '/add_exam_exam_subject';
  static const String add_exam_markRoute = '/add_exam_mark';
  static const String add_exam_enter_marksRoute = '/add_exam_enter_marks';
  static const String add_exam_teacher_remarksRoute = '/add_exam_teacher_remarks';



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

    GetPage(
      name: promote_studentRoute,
      page: () => PromoteStudentView(),
      bindings: [PromoteStudentBinding()],
    ),

    GetPage(
      name: subject_groupRoute,
      page: () => SubjectGroupView(),
      bindings: [SubjectGroupBinding()],
    ),

    GetPage(
      name: subjectRoute,
      page: () => SubjectView(),
      bindings: [SubjectBinding()],
    ),

    GetPage(
      name: classRoute,
      page: () => ClassView(),
      bindings: [ClassBinding()],
    ),

    GetPage(
      name: sectionRoute,
      page: () => SectionView(),
      bindings: [SectionBinding()],
    ),

    GetPage(
      name: teachers_time_tableRoute,
      page: () => TeacherTimeTableView(),
      bindings: [TeacherTimeTableBinding()],
    ),

    GetPage(
      name: termRoute,
      page: () => TermView(),
      bindings: [TermBinding()],
    ),

    GetPage(
      name: exam_gradeRoute,
      page: () => ExamGradeView(),
      bindings: [ExamGradeBinding()],
    ),

    GetPage(
      name: assessmentRoute,
      page: () => AssessmentView(),
      bindings: [AssessmentBinding()],
    ),

    GetPage(
      name: examRoute,
      page: () => ExamView(),
      bindings: [ExamBinding()],
    ),

    GetPage(
      name: assign_view_studentRoute,
      page: () => AssignViewStudentView(),
      bindings: [AssignViewStudentBinding()],
    ),

    GetPage(
      name: exam_subjectRoute,
      page: () => ExamSubjectView(),
      bindings: [ExamSubjectBinding()],
    ),

    GetPage(
      name: assign_observationRoute,
      page: () => AssignObservationView(),
      bindings: [AssignObservationBinding()],
    ),
    GetPage(
      name: assign_marksRoute,
      page: () => AssignMarksView(),
      bindings: [AssignMarksBinding()],
    ),
    GetPage(
      name: observation_ParameterRoute,
      page: () => ObservationParameterView(),
      bindings: [ObservationParameterBinding()],
    ),
    GetPage(
      name: exam_markRoute,
      page: () => ExamMarkView(),
      bindings: [ExamMarkBinding()],
    ),
    GetPage(
      name: enter_marksRoute,
      page: () => EnterMarksView(),
      bindings: [EnterMarksBinding()],
    ),
    GetPage(
      name: exam_attendanceRoute,
      page: () => ExamAttendanceView(),
      bindings: [ExamAttendanceBinding()],
    ),
    GetPage(
      name: teacher_remarkRoute,
      page: () => TeacherRemarkView(),
      bindings: [TeacherRemarkBinding()],
    ),
    GetPage(
      name: print_marksheetRoute,
      page: () => PrintMarksheetView(),
      bindings: [PrintMarksheetBinding()],
    ),
    GetPage(
      name: observationRoute,
      page: () => ObservationView(),
      bindings: [ObservationBinding()],
    ),
    GetPage(
      name: exam_scheduleRoute,
      page: () => ExamScheduleView(),
      bindings: [ExamScheduleBinding()],
    ),

      ///EXAMINATION
    GetPage(
      name: marks_gradeRoute,
      page: () => MarksGradeView(),
      bindings: [MarksGradeBinding()],
    ),
    GetPage(
      name: exam_groupRoute,
      page: () => ExamGroupView(),
      bindings: [ExamGroupBinding()],
    ),
    GetPage(
      name: add_exam_groupRoute,
      page: () => AddExamView(),
      bindings: [AddExamBinding()],
    ),
    GetPage(
      name: add_exam_assign_view_studentRoute,
      page: () => AddExamAssignViewStudentView(),
      bindings: [AddExamAssignViewStudentBinding()],
    ),
    GetPage(
      name: add_exam_exam_subjectRoute,
      page: () => AddExamExamSubjectView(),
      bindings: [AddExamExamSubjectBinding()],
    ),
    GetPage(
      name: add_exam_markRoute,
      page: () => AddExamMarkView(),
      bindings: [AddExamMarkBinding()],
    ),
    GetPage(
      name: add_exam_enter_marksRoute,
      page: () => AddExamEnterMarksView(),
      bindings: [AddExamEnterMarksBinding()],
    ),
    GetPage(
      name: add_exam_teacher_remarksRoute,
      page: () => AddExamTeacherRemarkView(),
      bindings: [AddExamTeacherRemarkBinding()],
    ),

  ];
}
