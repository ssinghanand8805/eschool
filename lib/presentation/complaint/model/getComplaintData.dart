class ComplaintData {
  String? id;
  String? complaintType;
  String? source;
  String? name;
  String? studentSessionId;
  String? contact;
  String? email;
  String? date;
  String? description;
  String? actionTaken;
  String? assigned;
  String? note;
  String? image;

  ComplaintData(
      {this.id,
        this.complaintType,
        this.source,
        this.name,
        this.studentSessionId,
        this.contact,
        this.email,
        this.date,
        this.description,
        this.actionTaken,
        this.assigned,
        this.note,
        this.image});

  ComplaintData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    complaintType = json['complaint_type'];
    source = json['source'];
    name = json['name'];
    studentSessionId = json['student_session_id'];
    contact = json['contact'];
    email = json['email'];
    date = json['date'];
    description = json['description'];
    actionTaken = json['action_taken'];
    assigned = json['assigned'];
    note = json['note'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['complaint_type'] = this.complaintType;
    data['source'] = this.source;
    data['name'] = this.name;
    data['student_session_id'] = this.studentSessionId;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['date'] = this.date;
    data['description'] = this.description;
    data['action_taken'] = this.actionTaken;
    data['assigned'] = this.assigned;
    data['note'] = this.note;
    data['image'] = this.image;
    return data;
  }
}
