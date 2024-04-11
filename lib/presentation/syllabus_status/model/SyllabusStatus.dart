class SyllabusStatus {
  List<Subjects>? subjects;

  SyllabusStatus({this.subjects});

  SyllabusStatus.fromJson(Map<String, dynamic> json) {
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  String? id;
  String? subjectGroupId;
  String? classSectionId;
  String? sessionId;
  Null? description;
  String? isActive;
  String? createdAt;
  Null? updatedAt;
  String? name;
  String? subjectId;
  String? subjectGroupSubjectId;
  String? subjectName;
  String? subjectCode;
  String? total;
  String? totalComplete;

  Subjects(
      {this.id,
        this.subjectGroupId,
        this.classSectionId,
        this.sessionId,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.subjectId,
        this.subjectGroupSubjectId,
        this.subjectName,
        this.subjectCode,
        this.total,
        this.totalComplete});

  Subjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectGroupId = json['subject_group_id'];
    classSectionId = json['class_section_id'];
    sessionId = json['session_id'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    subjectId = json['subject_id'];
    subjectGroupSubjectId = json['subject_group_subject_id'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    total = json['total'];
    totalComplete = json['total_complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject_group_id'] = this.subjectGroupId;
    data['class_section_id'] = this.classSectionId;
    data['session_id'] = this.sessionId;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['subject_id'] = this.subjectId;
    data['subject_group_subject_id'] = this.subjectGroupSubjectId;
    data['subject_name'] = this.subjectName;
    data['subject_code'] = this.subjectCode;
    data['total'] = this.total;
    data['total_complete'] = this.totalComplete;
    return data;
  }
}