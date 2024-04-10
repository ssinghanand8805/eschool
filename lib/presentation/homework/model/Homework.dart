import 'dart:core';

class Homework {
  List<Homeworklist>? homeworklist;
  String? classId;
  String? sectionId;

  Homework({this.homeworklist, this.classId, this.sectionId});

  Homework.fromJson(Map<String, dynamic> json) {
    if (json['homeworklist'] != null) {
      homeworklist = <Homeworklist>[];
      json['homeworklist'].forEach((v) { homeworklist!.add(new Homeworklist.fromJson(v)); });
    }
    classId = json['class_id'];
    sectionId = json['section_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.homeworklist != null) {
      data['homeworklist'] = this.homeworklist!.map((v) => v.toJson()).toList();
    }
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    return data;
  }
}

class Homeworklist {
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
  String? createDate;
  String? evaluationDate;
  String? document;
  String? createdBy;
  String? evaluatedBy;
  String? createdAt;
  String? homeworkEvaluationId;
  String? homeworkSubmittedId;
  String? note;
  String? evaluationMarks;
  String? className;
  String? section;
  String? subjectName;
  String? subjectCode;
  String? subjectGroupsId;
  String? name;
  String? createdByName;
  String? createdBySurname;
  String? createdByEmployeeId;
  String? status;

  Homeworklist({this.id, this.classId, this.sectionId, this.sessionId, this.staffId, this.subjectGroupSubjectId, this.subjectId, this.homeworkDate, this.submitDate, this.marks, this.description, this.createDate, this.evaluationDate, this.document, this.createdBy, this.evaluatedBy, this.createdAt, this.homeworkEvaluationId, this.homeworkSubmittedId, this.note, this.evaluationMarks, this.className, this.section, this.subjectName, this.subjectCode, this.subjectGroupsId, this.name, this.createdByName, this.createdBySurname, this.createdByEmployeeId, this.status});

  Homeworklist.fromJson(Map<String, dynamic> json) {
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
  createDate = json['create_date'];
  evaluationDate = json['evaluation_date'];
  document = json['document'];
  createdBy = json['created_by'];
  evaluatedBy = json['evaluated_by'];
  createdAt = json['created_at'];
  homeworkEvaluationId = json['homework_evaluation_id'];
  homeworkSubmittedId = json['homework_submitted_id'];
  note = json['note'];
  evaluationMarks = json['evaluation_marks'];
  className = json['class'];
  section = json['section'];
  subjectName = json['subject_name'];
  subjectCode = json['subject_code'];
  subjectGroupsId = json['subject_groups_id'];
  name = json['name'];
  createdByName = json['created_by_name'];
  createdBySurname = json['created_by_surname'];
  createdByEmployeeId = json['created_by_employee_id'];
  status = json['status'];
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
  data['create_date'] = this.createDate;
  data['evaluation_date'] = this.evaluationDate;
  data['document'] = this.document;
  data['created_by'] = this.createdBy;
  data['evaluated_by'] = this.evaluatedBy;
  data['created_at'] = this.createdAt;
  data['homework_evaluation_id'] = this.homeworkEvaluationId;
  data['homework_submitted_id'] = this.homeworkSubmittedId;
  data['note'] = this.note;
  data['evaluation_marks'] = this.evaluationMarks;
  data['class'] = this.className;
  data['section'] = this.section;
  data['subject_name'] = this.subjectName;
  data['subject_code'] = this.subjectCode;
  data['subject_groups_id'] = this.subjectGroupsId;
  data['name'] = this.name;
  data['created_by_name'] = this.createdByName;
  data['created_by_surname'] = this.createdBySurname;
  data['created_by_employee_id'] = this.createdByEmployeeId;
  data['status'] = this.status;
  return data;
  }
}