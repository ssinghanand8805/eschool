class Documents {
  String? id;
  String? student_id;
  String? title;
  String? doc;

  Documents(
      {this.id,
        this.student_id,
        this.title,
        this.doc});

  Documents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    student_id = json['student_id'];
    title = json['title'];
    doc = json['doc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_id'] = this.student_id;
    data['title'] = this.title;
    data['doc'] = this.doc;
    return data;
  }
}