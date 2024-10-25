class SchoolAttendance {
  String? date;
  List<Resultlist>? resultlist;
  int? allStudent;
  int? allPresent;
  int? allAbsent;
  int? allLeave;
  String? allPresentPercent;
  String? allAbsentPercent;
  String? allLeavePercent;

  SchoolAttendance(
      {this.date,
        this.resultlist,
        this.allStudent,
        this.allPresent,
        this.allAbsent,
        this.allLeave,
        this.allPresentPercent,
        this.allAbsentPercent,
        this.allLeavePercent});

  SchoolAttendance.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['resultlist'] != null) {
      resultlist = <Resultlist>[];
      json['resultlist'].forEach((v) {
        resultlist!.add(new Resultlist.fromJson(v));
      });
    }
    allStudent = json['all_student'];
    allPresent = json['all_present'];
    allAbsent = json['all_absent'];
    allLeave = json['all_leave'];
    allPresentPercent = json['all_present_percent'];
    allAbsentPercent = json['all_absent_percent'];
    allLeavePercent = json['all_leave_percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.resultlist != null) {
      data['resultlist'] = this.resultlist!.map((v) => v.toJson()).toList();
    }
    data['all_student'] = this.allStudent;
    data['all_present'] = this.allPresent;
    data['all_absent'] = this.allAbsent;
    data['all_leave'] = this.allLeave;
    data['all_present_percent'] = this.allPresentPercent;
    data['all_absent_percent'] = this.allAbsentPercent;
    data['all_leave_percent'] = this.allLeavePercent;
    return data;
  }
}

class Resultlist {
  String? classSection;
  String? classId;
  String? sectionId;
  String? totalPresent;
  String? totalAbsent;
  String? totalLeave;
  String? presentPercent;
  String? absentPercent;
  String? leavePercent;
  int? attendanceStatus;
  int? totalStudents;

  Resultlist(
      {this.classSection,
        this.classId,
        this.sectionId,
        this.totalPresent,
        this.totalAbsent,
        this.totalLeave,
        this.presentPercent,
        this.absentPercent,
        this.leavePercent,
        this.attendanceStatus,
        this.totalStudents});

  Resultlist.fromJson(Map<String, dynamic> json) {
    classSection = json['class_section'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    totalPresent = json['total_present'].toString();
    totalAbsent = json['total_absent'].toString();
    totalLeave = json['total_leave'].toString();
    presentPercent = json['present_percent'];
    absentPercent = json['absent_percent'];
    leavePercent = json['leave_percent'];
    attendanceStatus = json['attendance_status'];
    totalStudents = json['total_students'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_section'] = this.classSection;
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    data['total_present'] = this.totalPresent;
    data['total_absent'] = this.totalAbsent;
    data['total_leave'] = this.totalLeave;
    data['present_percent'] = this.presentPercent;
    data['absent_percent'] = this.absentPercent;
    data['leave_percent'] = this.leavePercent;
    data['attendance_status'] = this.attendanceStatus;
    data['total_students'] = this.totalStudents;
    return data;
  }
}