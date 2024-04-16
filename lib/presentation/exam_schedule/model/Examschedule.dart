class ExamSchedule {
  List<Result>? result;

  ExamSchedule({this.result});

  ExamSchedule.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? id;
  String? cbseExamId;
  String? studentSessionId;
  String? staffId;
  String? rollNo;
  String? remark;
  String? totalPresentDays;
  String? deleteStudentId;
  String? createdAt;
  String? name;
  String? examCode;
  List<TimeTable>? timeTable;

  Result(
      {this.id,
        this.cbseExamId,
        this.studentSessionId,
        this.staffId,
        this.rollNo,
        this.remark,
        this.totalPresentDays,
        this.deleteStudentId,
        this.createdAt,
        this.name,
        this.examCode,
        this.timeTable});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cbseExamId = json['cbse_exam_id'];
    studentSessionId = json['student_session_id'];
    staffId = json['staff_id'];
    rollNo = json['roll_no'];
    remark = json['remark'];
    totalPresentDays = json['total_present_days'];
    deleteStudentId = json['delete_student_id'];
    createdAt = json['created_at'];
    name = json['name'];
    examCode = json['exam_code'];
    if (json['time_table'] != null) {
      timeTable = <TimeTable>[];
      json['time_table'].forEach((v) {
        timeTable!.add(new TimeTable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cbse_exam_id'] = this.cbseExamId;
    data['student_session_id'] = this.studentSessionId;
    data['staff_id'] = this.staffId;
    data['roll_no'] = this.rollNo;
    data['remark'] = this.remark;
    data['total_present_days'] = this.totalPresentDays;
    data['delete_student_id'] = this.deleteStudentId;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    data['exam_code'] = this.examCode;
    if (this.timeTable != null) {
      data['time_table'] = this.timeTable!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeTable {
  String? id;
  String? cbseExamId;
  String? subjectId;
  String? date;
  String? timeFrom;
  String? timeTo;
  String? duration;
  String? roomNo;
  String? isWritten;
  String? writtenMaximumMarks;
  String? isPractical;
  Null? practicalMaximumMark;
  Null? createdBy;
  String? createdAt;
  String? subjectName;
  String? subjectCode;

  TimeTable(
      {this.id,
        this.cbseExamId,
        this.subjectId,
        this.date,
        this.timeFrom,
        this.timeTo,
        this.duration,
        this.roomNo,
        this.isWritten,
        this.writtenMaximumMarks,
        this.isPractical,
        this.practicalMaximumMark,
        this.createdBy,
        this.createdAt,
        this.subjectName,
        this.subjectCode});

  TimeTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cbseExamId = json['cbse_exam_id'];
    subjectId = json['subject_id'];
    date = json['date'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    duration = json['duration'];
    roomNo = json['room_no'];
    isWritten = json['is_written'];
    writtenMaximumMarks = json['written_maximum_marks'];
    isPractical = json['is_practical'];
    practicalMaximumMark = json['practical_maximum_mark'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cbse_exam_id'] = this.cbseExamId;
    data['subject_id'] = this.subjectId;
    data['date'] = this.date;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['duration'] = this.duration;
    data['room_no'] = this.roomNo;
    data['is_written'] = this.isWritten;
    data['written_maximum_marks'] = this.writtenMaximumMarks;
    data['is_practical'] = this.isPractical;
    data['practical_maximum_mark'] = this.practicalMaximumMark;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['subject_name'] = this.subjectName;
    data['subject_code'] = this.subjectCode;
    return data;
  }
}
