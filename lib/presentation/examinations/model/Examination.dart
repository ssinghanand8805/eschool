class ExamListModel {
  List<ExamSchedule>? examSchedule;

  ExamListModel({this.examSchedule});

  ExamListModel.fromJson(Map<String, dynamic> json) {
    if (json['examSchedule'] != null) {
      examSchedule = <ExamSchedule>[];
      json['examSchedule'].forEach((v) {
        examSchedule!.add(new ExamSchedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.examSchedule != null) {
      data['examSchedule'] = this.examSchedule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExamSchedule {
  String? id;
  String? examGroupClassBatchExamId;
  String? studentId;
  String? studentSessionId;
  Null? rollNo;
  Null? teacherRemark;
  String? rank;
  String? isActive;
  String? createdAt;
  Null? updatedAt;
  String? exam;
  String? description;
  String? examActive;
  String? resultPublish;

  ExamSchedule(
      {this.id,
        this.examGroupClassBatchExamId,
        this.studentId,
        this.studentSessionId,
        this.rollNo,
        this.teacherRemark,
        this.rank,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.exam,
        this.description,
        this.examActive,
        this.resultPublish});

  ExamSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    examGroupClassBatchExamId = json['exam_group_class_batch_exam_id'];
    studentId = json['student_id'];
    studentSessionId = json['student_session_id'];
    rollNo = json['roll_no'];
    teacherRemark = json['teacher_remark'];
    rank = json['rank'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    exam = json['exam'];
    description = json['description'];
    examActive = json['exam_active'];
    resultPublish = json['result_publish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exam_group_class_batch_exam_id'] = this.examGroupClassBatchExamId;
    data['student_id'] = this.studentId;
    data['student_session_id'] = this.studentSessionId;
    data['roll_no'] = this.rollNo;
    data['teacher_remark'] = this.teacherRemark;
    data['rank'] = this.rank;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['exam'] = this.exam;
    data['description'] = this.description;
    data['exam_active'] = this.examActive;
    data['result_publish'] = this.resultPublish;
    return data;
  }
}