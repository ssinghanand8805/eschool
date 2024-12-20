class SubjectListBySubjectGroup {
  String? id;
  String? subjectGroupId;
  String? sessionId;
  String? subjectId;
  String? createdAt;
  String? name;
  String? code;
  String? type;

  SubjectListBySubjectGroup(
      {this.id,
        this.subjectGroupId,
        this.sessionId,
        this.subjectId,
        this.createdAt,
        this.name,
        this.code,
        this.type});

  SubjectListBySubjectGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectGroupId = json['subject_group_id'];
    sessionId = json['session_id'];
    subjectId = json['subject_id'];
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
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    data['code'] = this.code;
    data['type'] = this.type;
    return data;
  }
}
