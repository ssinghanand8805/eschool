class TimeLine {
  String? id;
  String? studentId;
  String? title;
  String? timelineDate;
  String? description;
  String? document;
  String? status;
  String? createdStudentId;
  String? date;

  TimeLine(
      {this.id,
      this.studentId,
      this.title,
      this.timelineDate,
      this.description,
      this.document,
      this.status,
      this.createdStudentId,
      this.date});

  TimeLine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    title = json['title'];
    timelineDate = json['timeline_date'];
    description = json['description'];
    document = json['document'];
    status = json['status'];
    createdStudentId = json['created_student_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_id'] = this.studentId;
    data['title'] = this.title;
    data['timeline_date'] = this.timelineDate;
    data['description'] = this.description;
    data['document'] = this.document;
    data['status'] = this.status;
    data['created_student_id'] = this.createdStudentId;
    data['date'] = this.date;
    return data;
  }
}