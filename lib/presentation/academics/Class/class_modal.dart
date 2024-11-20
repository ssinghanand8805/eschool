class ClassModal {
  int? status;
  String? error;
  Data? data;

  ClassModal({this.status, this.error, this.data});

  ClassModal.fromJson(Map<String, dynamic> json) {
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
  List<ClassList>? classlist;

  Data({this.classlist});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['classlist'] != null) {
      classlist = <ClassList>[];
      json['classlist'].forEach((v) {
        classlist!.add(new ClassList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.classlist != null) {
      data['classlist'] = this.classlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassList {
  String? id;
  String? classN;
  List<Sections>? sections;

  ClassList({this.id, this.classN, this.sections});

  ClassList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classN = json['class'];
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
    data['class'] = this.classN;
    if (this.sections != null) {
      data['sections'] = this.sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  String? classSectionId;
  String? classId;
  String? sectionId;
  String? id;
  String? section;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  Sections(
      {this.classSectionId,
        this.classId,
        this.sectionId,
        this.id,
        this.section,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Sections.fromJson(Map<String, dynamic> json) {
    classSectionId = json['class_section_id'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    id = json['id'];
    section = json['section'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_section_id'] = this.classSectionId;
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    data['id'] = this.id;
    data['section'] = this.section;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
