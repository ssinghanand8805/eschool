class Classwork {
  String? id;
  String? classId;
  String? sectionId;
  String? sessionId;
  String? staffId;
  String? subjectGroupSubjectId;
  String? subjectId;
  String? classworkDate;
  String? description;
  String? createDate;
  String? document;
  String? createdBy;
  String? createdAt;
  String? className;
  String? section;
  String? subjectName;
  String? subjectCode;
  String? subjectGroupsId;
  String? name;
  String? staffName;
  String? staffSurname;
  String? staffEmployeeId;
  String? roleId;

  Classwork({this.id, this.classId, this.sectionId, this.sessionId, this.staffId, this.subjectGroupSubjectId, this.subjectId, this.classworkDate, this.description, this.createDate, this.document, this.createdBy, this.createdAt, this.className, this.section, this.subjectName, this.subjectCode, this.subjectGroupsId, this.name, this.staffName, this.staffSurname, this.staffEmployeeId, this.roleId});

  Classwork.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  classId = json['class_id'];
  sectionId = json['section_id'];
  sessionId = json['session_id'];
  staffId = json['staff_id'];
  subjectGroupSubjectId = json['subject_group_subject_id'];
  subjectId = json['subject_id'];
  classworkDate = json['classwork_date'];
  description = json['description'];
  createDate = json['create_date'];
  document = json['document'];
  createdBy = json['created_by'];
  createdAt = json['created_at'];
  className = json['class'];
  section = json['section'];
  subjectName = json['subject_name'];
  subjectCode = json['subject_code'];
  subjectGroupsId = json['subject_groups_id'];
  name = json['name'];
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
  data['classwork_date'] = this.classworkDate;
  data['description'] = this.description;
  data['create_date'] = this.createDate;
  data['document'] = this.document;
  data['created_by'] = this.createdBy;
  data['created_at'] = this.createdAt;
  data['class'] = this.className;
  data['section'] = this.section;
  data['subject_name'] = this.subjectName;
  data['subject_code'] = this.subjectCode;
  data['subject_groups_id'] = this.subjectGroupsId;
  data['name'] = this.name;
  data['staff_name'] = this.staffName;
  data['staff_surname'] = this.staffSurname;
  data['staff_employee_id'] = this.staffEmployeeId;
  data['role_id'] = this.roleId;
  return data;
  }
}
