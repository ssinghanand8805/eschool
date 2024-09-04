class CLassTimeTable {
  Timetable? timetable;

  CLassTimeTable({this.timetable});

  CLassTimeTable.fromJson(Map<String, dynamic> json) {
    timetable = json['timetable'] != null
        ? new Timetable.fromJson(json['timetable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.timetable != null) {
      data['timetable'] = this.timetable!.toJson();
    }
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
  String? subjectId;
  String? subjectName;
  String? code;
  String? type;
  String? name;
  String? surname;
  String? employeeId;
  String? id;
  String? sessionId;
  String? classId;
  String? sectionId;
  String? subjectGroupId;
  String? subjectGroupSubjectId;
  String? staffId;
  String? day;
  String? timeFrom;
  String? timeTo;
  String? startTime;
  String? endTime;
  String? roomNo;
  String? createdAt;
  String? subjectGroupClassSectionsId;

  Day(
      {this.subjectId,
        this.subjectName,
        this.code,
        this.type,
        this.name,
        this.surname,
        this.employeeId,
        this.id,
        this.sessionId,
        this.classId,
        this.sectionId,
        this.subjectGroupId,
        this.subjectGroupSubjectId,
        this.staffId,
        this.day,
        this.timeFrom,
        this.timeTo,
        this.startTime,
        this.endTime,
        this.roomNo,
        this.createdAt,
        this.subjectGroupClassSectionsId});

  Day.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
    code = json['code'];
    type = json['type'];
    name = json['name'];
    surname = json['surname'];
    employeeId = json['employee_id'];
    id = json['id'];
    sessionId = json['session_id'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    subjectGroupId = json['subject_group_id'];
    subjectGroupSubjectId = json['subject_group_subject_id'];
    staffId = json['staff_id'];
    day = json['day'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    roomNo = json['room_no'];
    createdAt = json['created_at'];
    subjectGroupClassSectionsId = json['subject_group_class_sections_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_id'] = this.subjectId;
    data['subject_name'] = this.subjectName;
    data['code'] = this.code;
    data['type'] = this.type;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['employee_id'] = this.employeeId;
    data['id'] = this.id;
    data['session_id'] = this.sessionId;
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    data['subject_group_id'] = this.subjectGroupId;
    data['subject_group_subject_id'] = this.subjectGroupSubjectId;
    data['staff_id'] = this.staffId;
    data['day'] = this.day;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['room_no'] = this.roomNo;
    data['created_at'] = this.createdAt;
    data['subject_group_class_sections_id'] = this.subjectGroupClassSectionsId;
    return data;
  }
}

class TimeTableSaveModel {
  String dayName;
  String? subjectID;
  String? teacherID;
  String? timeFrom;
  String? timeTo;
  String? roomNo;

  TimeTableSaveModel({required this.dayName, this.subjectID, this.teacherID,this.timeFrom,this.timeTo,this.roomNo});
}