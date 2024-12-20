class SubjectGroupByClassAndSection {
  String? name;
  String? id;
  String? subjectGroupId;
  String? classSectionId;
  String? sessionId;
  String? description;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  SubjectGroupByClassAndSection(
      {this.name,
        this.id,
        this.subjectGroupId,
        this.classSectionId,
        this.sessionId,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  SubjectGroupByClassAndSection.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    subjectGroupId = json['subject_group_id'];
    classSectionId = json['class_section_id'];
    sessionId = json['session_id'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['subject_group_id'] = this.subjectGroupId;
    data['class_section_id'] = this.classSectionId;
    data['session_id'] = this.sessionId;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
