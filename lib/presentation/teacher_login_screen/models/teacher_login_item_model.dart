import '../../../core/app_export.dart';

/// This class is used in the [teacher_login_item_widget] screen.
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class TeacherLoginItemModel {
  TeacherLoginItemModel({this.attendanceone, this.attendancetwo, this.id}) {
    attendanceone = attendanceone ?? Rx(ImageConstant.imgAttendance);
    attendancetwo = attendancetwo ?? Rx("Attendance");
    id = id ?? Rx("");
  }

  Rx<String>? attendanceone;

  Rx<String>? attendancetwo;

  Rx<String>? id;
}
