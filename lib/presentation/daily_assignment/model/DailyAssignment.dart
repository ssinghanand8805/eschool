class AssignmentModal {
  List<Dailyassignment>? dailyassignment;

  AssignmentModal({this.dailyassignment});

  AssignmentModal.fromJson(Map<String, dynamic> json) {
    if (json['dailyassignment'] != null) {
      dailyassignment = <Dailyassignment>[];
      json['dailyassignment'].forEach((v) {
        dailyassignment!.add(new Dailyassignment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dailyassignment != null) {
      data['dailyassignment'] =
          this.dailyassignment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dailyassignment {
  String? id;
  String? studentSessionId;
  String? subjectGroupSubjectId;
  String? title;
  String? description;
  String? attachment;
  Null? evaluatedBy;
  String? date;
  String? evaluationDate;
  String? remark;
  String? createdAt;
  String? subjectName;
  String? subjectCode;

  Dailyassignment(
      {this.id,
        this.studentSessionId,
        this.subjectGroupSubjectId,
        this.title,
        this.description,
        this.attachment,
        this.evaluatedBy,
        this.date,
        this.evaluationDate,
        this.remark,
        this.createdAt,
        this.subjectName,
        this.subjectCode});

  Dailyassignment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentSessionId = json['student_session_id'];
    subjectGroupSubjectId = json['subject_group_subject_id'];
    title = json['title'];
    description = json['description'];
    attachment = json['attachment'];
    evaluatedBy = json['evaluated_by'];
    date = json['date'];
    evaluationDate = json['evaluation_date'];
    remark = json['remark'];
    createdAt = json['created_at'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_session_id'] = this.studentSessionId;
    data['subject_group_subject_id'] = this.subjectGroupSubjectId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['attachment'] = this.attachment;
    data['evaluated_by'] = this.evaluatedBy;
    data['date'] = this.date;
    data['evaluation_date'] = this.evaluationDate;
    data['remark'] = this.remark;
    data['created_at'] = this.createdAt;
    data['subject_name'] = this.subjectName;
    data['subject_code'] = this.subjectCode;
    return data;
  }
}
