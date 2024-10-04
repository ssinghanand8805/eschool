class SyllabusLesson {
  String? id;
  String? sessionId;
  String? subjectGroupSubjectId;
  String? subjectGroupClassSectionsId;
  String? name;
  String? createdAt;
  String? total;
  String? totalComplete;
  List<Topics>? topics;

  SyllabusLesson(
      {this.id,
        this.sessionId,
        this.subjectGroupSubjectId,
        this.subjectGroupClassSectionsId,
        this.name,
        this.createdAt,
        this.total,
        this.totalComplete,
        this.topics});

  SyllabusLesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'];
    subjectGroupSubjectId = json['subject_group_subject_id'];
    subjectGroupClassSectionsId = json['subject_group_class_sections_id'];
    name = json['name'];
    createdAt = json['created_at'];
    total = json['total'];
    totalComplete = json['total_complete'];
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(new Topics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session_id'] = this.sessionId;
    data['subject_group_subject_id'] = this.subjectGroupSubjectId;
    data['subject_group_class_sections_id'] = this.subjectGroupClassSectionsId;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['total'] = this.total;
    data['total_complete'] = this.totalComplete;
    if (this.topics != null) {
      data['topics'] = this.topics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topics {
  String? id;
  String? sessionId;
  String? lessonId;
  String? name;
  String? status;
  String? completeDate;
  String? createdAt;

  Topics(
      {this.id,
        this.sessionId,
        this.lessonId,
        this.name,
        this.status,
        this.completeDate,
        this.createdAt});

  Topics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'];
    lessonId = json['lesson_id'];
    name = json['name'];
    status = json['status'];
    completeDate = json['complete_date'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session_id'] = this.sessionId;
    data['lesson_id'] = this.lessonId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['complete_date'] = this.completeDate;
    data['created_at'] = this.createdAt;
    return data;
  }
}