class DailyAssignment {
  int? status;
  List<Assignment>? data;

  DailyAssignment({this.status, this.data});

  DailyAssignment.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Assignment>[];
      json['data'].forEach((v) { data!.add(new Assignment.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Assignment {
  String? id;
  String? classId;
  String? sectionId;
  String? sessionId;
  String? staffId;
  String? subjectGroupSubjectId;
  String? subjectId;
  String? homeworkDate;
  String? submitDate;
  String? marks;
  String? description;
  String? isAssignment;
  String? createDate;
  String? evaluationDate;
  String? document;
  String? createdBy;
  String? evaluatedBy;
  String? createdAt;
  String? className;
  String? section;
  String? subjectName;
  String? subjectCode;
  String? subjectGroupsId;
  String? name;
  String? assignments;
  String? staffName;
  String? staffSurname;
  String? staffEmployeeId;
  String? roleId;

  Assignment({this.id, this.classId, this.sectionId, this.sessionId, this.staffId, this.subjectGroupSubjectId, this.subjectId, this.homeworkDate, this.submitDate, this.marks, this.description, this.isAssignment, this.createDate, this.evaluationDate, this.document, this.createdBy, this.evaluatedBy, this.createdAt, this.className, this.section, this.subjectName, this.subjectCode, this.subjectGroupsId, this.name, this.assignments, this.staffName, this.staffSurname, this.staffEmployeeId, this.roleId});

  Assignment.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  classId = json['class_id'];
  sectionId = json['section_id'];
  sessionId = json['session_id'];
  staffId = json['staff_id'];
  subjectGroupSubjectId = json['subject_group_subject_id'];
  subjectId = json['subject_id'];
  homeworkDate = json['homework_date'];
  submitDate = json['submit_date'];
  marks = json['marks'];
  description = json['description'];
  isAssignment = json['isAssignment'];
  createDate = json['create_date'];
  evaluationDate = json['evaluation_date'];
  document = json['document'];
  createdBy = json['created_by'];
  evaluatedBy = json['evaluated_by'];
  createdAt = json['created_at'];
  className = json['class'];
  section = json['section'];
  subjectName = json['subject_name'];
  subjectCode = json['subject_code'];
  subjectGroupsId = json['subject_groups_id'];
  name = json['name'];
  assignments = json['assignments'];
  staffName = json['staff_name'];
  staffSurname = json['staff_surname'];
  staffEmployeeId = json['staff_employee_id'];
  roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['class_id'] = this.classId;
  data['section_id'] = this.sectionId;
  data['session_id'] = this.sessionId;
  data['staff_id'] = this.staffId;
  data['subject_group_subject_id'] = this.subjectGroupSubjectId;
  data['subject_id'] = this.subjectId;
  data['homework_date'] = this.homeworkDate;
  data['submit_date'] = this.submitDate;
  data['marks'] = this.marks;
  data['description'] = this.description;
  data['isAssignment'] = this.isAssignment;
  data['create_date'] = this.createDate;
  data['evaluation_date'] = this.evaluationDate;
  data['document'] = this.document;
  data['created_by'] = this.createdBy;
  data['evaluated_by'] = this.evaluatedBy;
  data['created_at'] = this.createdAt;
  data['class'] = this.className;
  data['section'] = this.section;
  data['subject_name'] = this.subjectName;
  data['subject_code'] = this.subjectCode;
  data['subject_groups_id'] = this.subjectGroupsId;
  data['name'] = this.name;
  data['assignments'] = this.assignments;
  data['staff_name'] = this.staffName;
  data['staff_surname'] = this.staffSurname;
  data['staff_employee_id'] = this.staffEmployeeId;
  data['role_id'] = this.roleId;
  return data;
  }
}
