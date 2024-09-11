class StudentSubjects {
  List<Subjectlist>? subjectlist;
  String? classId;
  String? sectionId;

  StudentSubjects({this.subjectlist, this.classId, this.sectionId});

  StudentSubjects.fromJson(Map<String, dynamic> json) {
    if (json['subjectlist'] != null) {
      subjectlist = <Subjectlist>[];
      json['subjectlist'].forEach((v) {
        subjectlist!.add(new Subjectlist.fromJson(v));
      });
    }
    classId = json['class_id'];
    sectionId = json['section_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subjectlist != null) {
      data['subjectlist'] = this.subjectlist!.map((v) => v.toJson()).toList();
    }
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    return data;
  }
}

class Subjectlist {
  String? subjectGroupSubjectsId;
  String? subjectGroupClassSectionsId;
  String? name;
  String? code;
  String? subjectId;

  Subjectlist(
      {this.subjectGroupSubjectsId,
        this.subjectGroupClassSectionsId,
        this.name,
        this.code,
        this.subjectId});

  Subjectlist.fromJson(Map<String, dynamic> json) {
    subjectGroupSubjectsId = json['subject_group_subjects_id'];
    subjectGroupClassSectionsId = json['subject_group_class_sections_id'];
    name = json['name'];
    code = json['code'];
    subjectId = json['subject_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_group_subjects_id'] = this.subjectGroupSubjectsId;
    data['subject_group_class_sections_id'] = this.subjectGroupClassSectionsId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['subject_id'] = this.subjectId;
    return data;
  }
}