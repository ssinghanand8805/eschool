class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class Attendance {
  String? attendenceType;
  List<Data>? data;

  Attendance({this.attendenceType, this.data});

  Attendance.fromJson(Map<String, dynamic> json) {
    attendenceType = json['attendence_type'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendence_type'] = this.attendenceType;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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