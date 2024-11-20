class SubjectListModal {
  int? status;
  String? error;
  Data? data;

  SubjectListModal({this.status, this.error, this.data});

  SubjectListModal.fromJson(Map<String, dynamic> json) {
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
  List<Subjectlist>? subjectlist;
  SubjectTypes? subjectTypes;

  Data({this.subjectlist, this.subjectTypes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['subjectlist'] != null) {
      subjectlist = <Subjectlist>[];
      json['subjectlist'].forEach((v) {
        subjectlist!.add(new Subjectlist.fromJson(v));
      });
    }
    subjectTypes = json['subject_types'] != null
        ? new SubjectTypes.fromJson(json['subject_types'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subjectlist != null) {
      data['subjectlist'] = this.subjectlist!.map((v) => v.toJson()).toList();
    }
    if (this.subjectTypes != null) {
      data['subject_types'] = this.subjectTypes!.toJson();
    }
    return data;
  }
}

class Subjectlist {
  String? id;
  String? name;
  String? code;
  String? type;
  String? isActive;
  String? createdAt;
  Null? updatedAt;

  Subjectlist(
      {this.id,
        this.name,
        this.code,
        this.type,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Subjectlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['type'] = this.type;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SubjectTypes {
  bool? theory;
  bool? practical;

  SubjectTypes({this.theory, this.practical});

  SubjectTypes.fromJson(Map<String, dynamic> json) {
    theory = json['theory'];
    practical = json['practical'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['theory'] = this.theory;
    data['practical'] = this.practical;
    return data;
  }
}
