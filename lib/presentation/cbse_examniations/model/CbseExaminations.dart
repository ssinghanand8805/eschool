class Exam {
  List<Exams>? exams;

  Exam({this.exams});

  Exam.fromJson(Map<String, dynamic> json) {
    if (json['exams'] != null) {
      exams = <Exams>[];
      json['exams'].forEach((v) {
        exams!.add(new Exams.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exams != null) {
      data['exams'] = this.exams!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exams {
  String? examId;
  String? examName;
  List<ExamAssessments>? examAssessments;
  double? totalMarks;
  double? maxMarks;
  double? percentage;
  String? grade;
  String? examRank;

  Exams(
      {this.examId,
        this.examName,
        this.examAssessments,
        this.totalMarks,
        this.maxMarks,
        this.percentage,
        this.grade,
        this.examRank});

  Exams.fromJson(Map<String, dynamic> json) {
    examId = json['exam_id'];
    examName = json['exam_name'];
    if (json['exam_assessments'] != null) {
      examAssessments = <ExamAssessments>[];
      json['exam_assessments'].forEach((v) {
        examAssessments!.add(new ExamAssessments.fromJson(v));
      });
    }
    totalMarks = double.parse(json['total_marks'].toString());
    maxMarks = double.parse(json['max_marks'].toString());
    percentage = double.parse(json['percentage'].toString());
    grade = json['grade'];
    examRank = json['exam_rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exam_id'] = this.examId;
    data['exam_name'] = this.examName;
    if (this.examAssessments != null) {
      data['exam_assessments'] =
          this.examAssessments!.map((v) => v.toJson()).toList();
    }
    data['total_marks'] = this.totalMarks;
    data['max_marks'] = this.maxMarks;
    data['percentage'] = this.percentage;
    data['grade'] = this.grade;
    data['exam_rank'] = this.examRank;
    return data;
  }
}

class ExamAssessments {
  String? assessmentId;
  String? assessmentName;
  List<Subjects>? subjects;

  ExamAssessments({this.assessmentId, this.assessmentName, this.subjects});

  ExamAssessments.fromJson(Map<String, dynamic> json) {
    assessmentId = json['assessment_id'];
    assessmentName = json['assessment_name'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assessment_id'] = this.assessmentId;
    data['assessment_name'] = this.assessmentName;
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  String? subjectId;
  String? subjectName;
  String? marks;
  String? maximumMarks;
  String? isAbsent;

  Subjects(
      {this.subjectId,
        this.subjectName,
        this.marks,
        this.maximumMarks,
        this.isAbsent});

  Subjects.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
    marks = json['marks'];
    maximumMarks = json['maximum_marks'];
    isAbsent = json['is_absent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_id'] = this.subjectId;
    data['subject_name'] = this.subjectName;
    data['marks'] = this.marks;
    data['maximum_marks'] = this.maximumMarks;
    data['is_absent'] = this.isAbsent;
    return data;
  }
}
