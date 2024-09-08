class CloseHomeworkDataModal {
  String? className;
  String? section;
  String? homeworkName;
  String? subjectName;
  String? homeworkDate;
  String? submitDate;
  String? evaluationDate;
  String? staffInfo;

  CloseHomeworkDataModal(
      {this.className,
        this.section,
        this.homeworkName,
        this.subjectName,
        this.homeworkDate,
        this.submitDate,
        this.evaluationDate,
        this.staffInfo});

  CloseHomeworkDataModal.fromJson(Map<String, dynamic> json) {
    className = json['class'];
    section = json['section'];
    homeworkName = json['homework_name'];
    subjectName = json['subject_name'];
    homeworkDate = json['homework_date'];
    submitDate = json['submit_date'];
    evaluationDate = json['evaluation_date'];
    staffInfo = json['staff_info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_name'] = this.className;
    data['section'] = this.section;
    data['homework_name'] = this.homeworkName;
    data['subject_name'] = this.subjectName;
    data['homework_date'] = this.homeworkDate;
    data['submit_date'] = this.submitDate;
    data['evaluation_date'] = this.evaluationDate;
    data['staff_info'] = this.staffInfo;
    return data;
  }
}
