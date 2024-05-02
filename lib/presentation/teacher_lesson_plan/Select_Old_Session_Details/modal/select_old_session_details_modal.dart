class SelectOldSessionModal {
  Timetable? timetable;
  String? status;

  SelectOldSessionModal({this.timetable, this.status});

  SelectOldSessionModal.fromJson(Map<String, dynamic> json) {
    timetable = json['timetable'] != null
        ? new Timetable.fromJson(json['timetable'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timetable != null) {
      data['timetable'] = this.timetable!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Timetable {
  List<Day>? monday;
  List<Day>? tuesday;
  List<Day>? wednesday;
  List<Day>? thursday;
  List<Day>? friday;
  List<Day>? saturday;
  List<Day>? sunday;

  Timetable(
      {this.monday,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.friday,
        this.saturday,
        this.sunday});

  Timetable.fromJson(Map<String, dynamic> json) {
    if (json['Monday'] != null) {
      monday = <Day>[];
      json['Monday'].forEach((v) {
        monday!.add(new Day.fromJson(v));
      });
    }
    if (json['Tuesday'] != null) {
      tuesday = <Day>[];
      json['Tuesday'].forEach((v) {
        tuesday!.add(new Day.fromJson(v));
      });
    }
    if (json['Wednesday'] != null) {
      wednesday = <Day>[];
      json['Wednesday'].forEach((v) {
        wednesday!.add(new Day.fromJson(v));
      });
    }
    if (json['Thursday'] != null) {
      thursday = <Day>[];
      json['Thursday'].forEach((v) {
        thursday!.add(new Day.fromJson(v));
      });
    }
    if (json['Friday'] != null) {
      friday = <Day>[];
      json['Friday'].forEach((v) {
        friday!.add(new Day.fromJson(v));
      });
    }
    if (json['Saturday'] != null) {
      saturday = <Day>[];
      json['Saturday'].forEach((v) {
        saturday!.add(new Day.fromJson(v));
      });
    }
    if (json['Sunday'] != null) {
      sunday = <Day>[];
      json['Sunday'].forEach((v) {
        sunday!.add(new Day.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monday != null) {
      data['Monday'] = this.monday!.map((v) => v.toJson()).toList();
    }
    if (this.tuesday != null) {
      data['Tuesday'] = this.tuesday!.map((v) => v.toJson()).toList();
    }
    if (this.wednesday != null) {
      data['Wednesday'] = this.wednesday!.map((v) => v.toJson()).toList();
    }
    if (this.thursday != null) {
      data['Thursday'] = this.thursday!.map((v) => v.toJson()).toList();
    }
    if (this.friday != null) {
      data['Friday'] = this.friday!.map((v) => v.toJson()).toList();
    }
    if (this.saturday != null) {
      data['Saturday'] = this.saturday!.map((v) => v.toJson()).toList();
    }
    if (this.sunday != null) {
      data['Sunday'] = this.sunday!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Day {
  String? subjectSyllabusId;
  String? timeFrom;
  String? timeTo;
  String? id;
  String? subjectGroupId;
  String? classSectionId;
  String? sessionId;
  Null? description;
  String? isActive;
  String? createdAt;
  Null? updatedAt;
  String? className;
  String? section;
  String? lessonId;
  String? topicName;
  String? lessonName;
  String? date;
  String? name;
  String? code;

  Day(
      {this.subjectSyllabusId, this.timeFrom, this.timeTo, this.id, this.subjectGroupId, this.classSectionId, this.sessionId, this.description, this.isActive, this.createdAt, this.updatedAt, this.className, this.section, this.lessonId, this.topicName, this.lessonName, this.date, this.name, this.code});

  Day.fromJson(Map<String, dynamic> json) {
    subjectSyllabusId = json['subject_syllabus_id'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    id = json['id'];
    subjectGroupId = json['subject_group_id'];
    classSectionId = json['class_section_id'];
    sessionId = json['session_id'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    className = json['class'];
    section = json['section'];
    lessonId = json['lesson_id'];
    topicName = json['topic_name'];
    lessonName = json['lesson_name'];
    date = json['date'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_syllabus_id'] = this.subjectSyllabusId;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['id'] = this.id;
    data['subject_group_id'] = this.subjectGroupId;
    data['class_section_id'] = this.classSectionId;
    data['session_id'] = this.sessionId;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['class'] = this.className;
    data['section'] = this.section;
    data['lesson_id'] = this.lessonId;
    data['topic_name'] = this.topicName;
    data['lesson_name'] = this.lessonName;
    data['date'] = this.date;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}