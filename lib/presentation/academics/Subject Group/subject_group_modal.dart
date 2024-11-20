class SubjectGroupModal {
  int? status;
  String? error;
  Data? data;

  SubjectGroupModal({this.status, this.error, this.data});

  SubjectGroupModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<SubjectgroupList>? subjectgroupList;

  Data({this.subjectgroupList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['subjectgroupList'] != null) {
      subjectgroupList = <SubjectgroupList>[];
      json['subjectgroupList'].forEach((v) {
        subjectgroupList!.add(new SubjectgroupList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subjectgroupList != null) {
      data['subjectgroupList'] =
          this.subjectgroupList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubjectgroupList {
  String? id;
  String? name;
  String? description;
  String? sessionId;
  String? createdAt;
  List<GroupSubject>? groupSubject;
  List<Sections>? sections;

  SubjectgroupList(
      {this.id,
        this.name,
        this.description,
        this.sessionId,
        this.createdAt,
        this.groupSubject,
        this.sections});

  SubjectgroupList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    sessionId = json['session_id'];
    createdAt = json['created_at'];
    if (json['group_subject'] != null) {
      groupSubject = <GroupSubject>[];
      json['group_subject'].forEach((v) {
        groupSubject!.add(new GroupSubject.fromJson(v));
      });
    }
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(new Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['session_id'] = this.sessionId;
    data['created_at'] = this.createdAt;
    if (this.groupSubject != null) {
      data['group_subject'] =
          this.groupSubject!.map((v) => v.toJson()).toList();
    }
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupSubject {
  String? id;
  String? subjectGroupId;
  String? sessionId;
  String? subjectId;
  String? orderno;
  String? createdAt;
  String? name;
  String? code;
  String? type;

  GroupSubject(
      {this.id,
        this.subjectGroupId,
        this.sessionId,
        this.subjectId,
        this.orderno,
        this.createdAt,
        this.name,
        this.code,
        this.type});

  GroupSubject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectGroupId = json['subject_group_id'];
    sessionId = json['session_id'];
    subjectId = json['subject_id'];
    orderno = json['orderno'];
    createdAt = json['created_at'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject_group_id'] = this.subjectGroupId;
    data['session_id'] = this.sessionId;
    data['subject_id'] = this.subjectId;
    data['orderno'] = this.orderno;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    data['code'] = this.code;
    data['type'] = this.type;
    return data;
  }
}

class Sections {
  String? id;
  String? subjectGroupId;
  String? classSectionId;
  String? sessionId;
  Null? description;
  String? isActive;
  String? createdAt;
  Null? updatedAt;
  String? classId;
  String? classN;
  String? sectionId;
  String? section;

  Sections(
      {this.id,
        this.subjectGroupId,
        this.classSectionId,
        this.sessionId,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.classId,
        this.classN,
        this.sectionId,
        this.section});

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectGroupId = json['subject_group_id'];
    classSectionId = json['class_section_id'];
    sessionId = json['session_id'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    classId = json['class_id'];
    classN = json['class'];
    sectionId = json['section_id'];
    section = json['section'];
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
    data['class_id'] = this.classId;
    data['class'] = this.classN;
    data['section_id'] = this.sectionId;
    data['section'] = this.section;
    return data;
  }
}
