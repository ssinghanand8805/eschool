class Classes {
  String? id;
  String? className;
  String? isActive;
  String? createdAt;
  Null? updatedAt;

  Classes(
      {this.id, this.className, this.isActive, this.createdAt, this.updatedAt});

  Classes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['className'] = this.className;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


class Sections {
  String? id;
  String? sectionId;
  String? section;

  Sections({this.id, this.sectionId, this.section});

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['section_id'] = this.sectionId;
    data['section'] = this.section;
    return data;
  }
}