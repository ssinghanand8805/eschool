import '../../../core/app_export.dart';
import 'teacher_login_item_model.dart';

/// This class defines the variables used in the [teacher_login_screen],
/// and is typically used to hold data that is passed between different parts of the application.
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class TeacherLoginModel {
  Rx<List<TeacherLoginItemModel>> teacherLoginItemList = Rx([
    TeacherLoginItemModel(
        attendanceone: ImageConstant.imgAttendance.obs,
        attendancetwo: "Attendance".obs),
    TeacherLoginItemModel(
        attendanceone: ImageConstant.imgHomework.obs,
        attendancetwo: "Homework".obs),
    TeacherLoginItemModel(
        attendanceone: ImageConstant.imgExam.obs, attendancetwo: "Result".obs),
    TeacherLoginItemModel(
        attendanceone: ImageConstant.imgTodoList.obs,
        attendancetwo: "Exam Routine".obs),
    TeacherLoginItemModel(
        attendanceone: ImageConstant.imgIdeaSharing.obs,
        attendancetwo: "Solution".obs),
    TeacherLoginItemModel(
        attendanceone: ImageConstant.imgQuestions.obs,
        attendancetwo: "Notice & Events".obs),
    TeacherLoginItemModel(
        attendanceone: ImageConstant.imgAddUserMale.obs,
        attendancetwo: "Add Account".obs)
  ]);
}
