class Visitor {
  List<Result>? result;

  Visitor({this.result});

  Visitor.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? id;
  Null? staffId;
  String? studentSessionId;
  Null? source;
  String? purpose;
  String? name;
  Null? email;
  String? contact;
  String? idProof;
  String? noOfPeople;
  String? date;
  String? inTime;
  String? outTime;
  String? note;
  String? image;
  String? meetingWith;
  String? createdAt;

  Result(
      {this.id,
        this.staffId,
        this.studentSessionId,
        this.source,
        this.purpose,
        this.name,
        this.email,
        this.contact,
        this.idProof,
        this.noOfPeople,
        this.date,
        this.inTime,
        this.outTime,
        this.note,
        this.image,
        this.meetingWith,
        this.createdAt});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    staffId = json['staff_id'];
    studentSessionId = json['student_session_id'];
    source = json['source'];
    purpose = json['purpose'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    idProof = json['id_proof'];
    noOfPeople = json['no_of_people'];
    date = json['date'];
    inTime = json['in_time'];
    outTime = json['out_time'];
    note = json['note'];
    image = json['image'];
    meetingWith = json['meeting_with'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['student_session_id'] = this.studentSessionId;
    data['source'] = this.source;
    data['purpose'] = this.purpose;
    data['name'] = this.name;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['id_proof'] = this.idProof;
    data['no_of_people'] = this.noOfPeople;
    data['date'] = this.date;
    data['in_time'] = this.inTime;
    data['out_time'] = this.outTime;
    data['note'] = this.note;
    data['image'] = this.image;
    data['meeting_with'] = this.meetingWith;
    data['created_at'] = this.createdAt;
    return data;
  }
}