class CloseHomeworkDataModal {
  String? id;
  String? className;
  String? section;
  String? homeworkName;
  String? homeworkDocument;
  String? subjectName;
  String? homeworkDate;
  String? submitDate;
  String? evaluationDate;
  String? staffInfo;

  CloseHomeworkDataModal(
      {
        this.id,
        this.className,
        this.section,
        this.homeworkName,
        this.homeworkDocument,
        this.subjectName,
        this.homeworkDate,
        this.submitDate,
        this.evaluationDate,
        this.staffInfo});

  CloseHomeworkDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class'];
    section = json['section'];
    homeworkName = json['homework_name'];
    homeworkDocument = json['homework_document'];
    subjectName = json['subject_name'];
    homeworkDate = json['homework_date'];
    submitDate = json['submit_date'];
    evaluationDate = json['evaluation_date'];
    staffInfo = json['staff_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['class_name'] = this.className;
    data['section'] = this.section;
    data['homework_name'] = this.homeworkName;
    data['homework_document'] = this.homeworkDocument;
    data['subject_name'] = this.subjectName;
    data['homework_date'] = this.homeworkDate;
    data['submit_date'] = this.submitDate;
    data['evaluation_date'] = this.evaluationDate;
    data['staff_info'] = this.staffInfo;
    return data;
  }
}
