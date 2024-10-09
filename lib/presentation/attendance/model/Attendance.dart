class AttendanceDataModal {
  String? attendenceType;
  List<Data>? data;
  Counts? counts;

  AttendanceDataModal({this.attendenceType, this.data, this.counts});

  AttendanceDataModal.fromJson(Map<String, dynamic> json) {
    attendenceType = json['attendence_type'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    counts =
    json['counts'] != null ? new Counts.fromJson(json['counts']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendence_type'] = this.attendenceType;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.counts != null) {
      data['counts'] = this.counts!.toJson();
    }
    return data;
  }
}

class Data {
  String? date;
  String? type;

  Data({this.date, this.type});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['type'] = this.type;
    return data;
  }
}

class Counts {
  int? present;
  int? absent;
  // int? late;
  // int? halfDay;
  // int? holiday;
  int? leave;

  Counts({this.present, this.absent,  this.leave});

  Counts.fromJson(Map<String, dynamic> json) {
    present = json['Present'];
    absent = json['Absent'];
    // late = json['Late'];
    // halfDay = json['Half Day'];
    // holiday = json['Holiday'];
    leave = json['Leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Present'] = this.present;
    data['Absent'] = this.absent;
    // data['Late'] = this.late;
    // data['Half Day'] = this.halfDay;
    // data['Holiday'] = this.holiday;
    data['Leave'] = this.leave;
    return data;
  }
}
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}