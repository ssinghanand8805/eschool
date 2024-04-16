class Exam {
  String? id;
  String? cbseExamId;
  String? studentSessionId;
  String? staffId;
  String? rollNo;
  String? remark;
  String? totalPresentDays;
  String? deleteStudentId;
  String? createdAt;
  String? cbseExamAssessmentId;
  String? cbseTermId;
  String? name;
  String? useExamRollNo;
  String? isActive;
  String? isPublish;
  String? cbseExamGradeId;
  String? totalWorkingDays;
  List<Subject>? subjects;
  List<Grade>? grades;
  List<ExamAssessment>? examAssessments;
  List<ExamSubjectAssessment>? examSubjectAssessments;
  ExamData? examData;
  String? examTotalMarks;
  String? examObtainMarks;
  String? examPercentage;
  String? examGrade;
  String? examRank;

  Exam({
    this.id,
    this.cbseExamId,
    this.studentSessionId,
    this.staffId,
    this.rollNo,
    this.remark,
    this.totalPresentDays,
    this.deleteStudentId,
    this.createdAt,
    this.cbseExamAssessmentId,
    this.cbseTermId,
    this.name,
    this.useExamRollNo,
    this.isActive,
    this.isPublish,
    this.cbseExamGradeId,
    this.totalWorkingDays,
    this.subjects,
    this.grades,
    this.examAssessments,
    this.examSubjectAssessments,
    this.examData,
    this.examTotalMarks,
    this.examObtainMarks,
    this.examPercentage,
    this.examGrade,
    this.examRank,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      cbseExamId: json['cbse_exam_id'],
      studentSessionId: json['student_session_id'],
      staffId: json['staff_id'],
      rollNo: json['roll_no'],
      remark: json['remark'],
      totalPresentDays: json['total_present_days'],
      deleteStudentId: json['delete_student_id'],
      createdAt: json['created_at'],
      cbseExamAssessmentId: json['cbse_exam_assessment_id'],
      cbseTermId: json['cbse_term_id'],
      name: json['name'],
      useExamRollNo: json['use_exam_roll_no'],
      isActive: json['is_active'],
      isPublish: json['is_publish'],
      cbseExamGradeId: json['cbse_exam_grade_id'],
      totalWorkingDays: json['total_working_days'],
      subjects: List<Subject>.from(json['subjects'].map((x) => Subject.fromJson(x))),
      grades: List<Grade>.from(json['grades'].map((x) => Grade.fromJson(x))),
      examAssessments: List<ExamAssessment>.from(json['exam_assessments'].map((x) => ExamAssessment.fromJson(x))),
      examSubjectAssessments: List<ExamSubjectAssessment>.from(json['exam_subject_assessments'].map((x) => ExamSubjectAssessment.fromJson(x))),
      examData: ExamData.fromJson(json['exam_data']),
      examTotalMarks: json['exam_total_marks'].toString(),
      examObtainMarks: json['exam_obtain_marks'].toString(),
      examPercentage: json['exam_percentage'].toString(),
      examGrade: json['exam_grade'].toString(),
      examRank: json['exam_rank'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cbse_exam_id': cbseExamId,
      'student_session_id': studentSessionId,
      'staff_id': staffId,
      'roll_no': rollNo,
      'remark': remark,
      'total_present_days': totalPresentDays,
      'delete_student_id': deleteStudentId,
      'created_at': createdAt,
      'cbse_exam_assessment_id': cbseExamAssessmentId,
      'cbse_term_id': cbseTermId,
      'name': name,
      'use_exam_roll_no': useExamRollNo,
      'is_active': isActive,
      'is_publish': isPublish,
      'cbse_exam_grade_id': cbseExamGradeId,
      'total_working_days': totalWorkingDays,
      'subjects': List<dynamic>.from(subjects!.map((x) => x.toJson())),
      'grades': List<dynamic>.from(grades!.map((x) => x.toJson())),
      'exam_assessments': List<dynamic>.from(examAssessments!.map((x) => x.toJson())),
      'exam_subject_assessments': List<dynamic>.from(examSubjectAssessments!.map((x) => x.toJson())),
      'exam_data': examData!.toJson(),
      'exam_total_marks': examTotalMarks,
      'exam_obtain_marks': examObtainMarks,
      'exam_percentage': examPercentage,
      'exam_grade': examGrade,
      'exam_rank': examRank,
    };
  }
}

class Subject {
  String? id;
  String? cbseExamId;
  String? subjectId;
  String? date;
  String? timeFrom;
  String? timeTo;
  String? duration;
  String? roomNo;
  String? isWritten;
  String? writtenMaximumMarks;
  String? isPractical;
  String? practicalMaximumMark;
  String? createdBy;
  String? createdAt;
  String? subjectName;
  String? subjectCode;
  List<SubjectAssessment>? subjectAssessments;

  Subject({
    this.id,
    this.cbseExamId,
    this.subjectId,
    this.date,
    this.timeFrom,
    this.timeTo,
    this.duration,
    this.roomNo,
    this.isWritten,
    this.writtenMaximumMarks,
    this.isPractical,
    this.practicalMaximumMark,
    this.createdBy,
    this.createdAt,
    this.subjectName,
    this.subjectCode,
    this.subjectAssessments,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      cbseExamId: json['cbse_exam_id'],
      subjectId: json['subject_id'],
      date: json['date'],
      timeFrom: json['time_from'],
      timeTo: json['time_to'],
      duration: json['duration'],
      roomNo: json['room_no'],
      isWritten: json['is_written'],
      writtenMaximumMarks: json['written_maximum_marks'],
      isPractical: json['is_practical'],
      practicalMaximumMark: json['practical_maximum_mark'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      subjectName: json['subject_name'],
      subjectCode: json['subject_code'],
      subjectAssessments: List<SubjectAssessment>.from(json['subject_assessments'].map((x) => SubjectAssessment.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cbse_exam_id': cbseExamId,
      'subject_id': subjectId,
      'date': date,
      'time_from': timeFrom,
      'time_to': timeTo,
      'duration': duration,
      'room_no': roomNo,
      'is_written': isWritten,
      'written_maximum_marks': writtenMaximumMarks,
      'is_practical': isPractical,
      'practical_maximum_mark': practicalMaximumMark,
      'created_by': createdBy,
      'created_at': createdAt,
      'subject_name': subjectName,
      'subject_code': subjectCode,
      'subject_assessments': List<dynamic>.from(subjectAssessments!.map((x) => x.toJson())),
    };
  }
}

class SubjectAssessment {
  String? id;
  String? cbseExamTimetableId;
  String? cbseExamAssessmentTypeId;
  String? createdAt;

  SubjectAssessment({
    this.id,
    this.cbseExamTimetableId,
    this.cbseExamAssessmentTypeId,
    this.createdAt,
  });

  factory SubjectAssessment.fromJson(Map<String, dynamic> json) {
    return SubjectAssessment(
      id: json['id'],
      cbseExamTimetableId: json['cbse_exam_timetable_id'],
      cbseExamAssessmentTypeId: json['cbse_exam_assessment_type_id'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cbse_exam_timetable_id': cbseExamTimetableId,
      'cbse_exam_assessment_type_id': cbseExamAssessmentTypeId,
      'created_at': createdAt,
    };
  }
}

class Grade {
  String? id;
  String? cbseExamGradeId;
  String? name;
  String? minimumPercentage;
  String? maximumPercentage;
  String? description;
  String? createdBy;
  String? createdAt;

  Grade({
    this.id,
    this.cbseExamGradeId,
    this.name,
    this.minimumPercentage,
    this.maximumPercentage,
    this.description,
    this.createdBy,
    this.createdAt,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      cbseExamGradeId: json['cbse_exam_grade_id'],
      name: json['name'],
      minimumPercentage: json['minimum_percentage'],
      maximumPercentage: json['maximum_percentage'],
      description: json['description'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cbse_exam_grade_id': cbseExamGradeId,
      'name': name,
      'minimum_percentage': minimumPercentage,
      'maximum_percentage': maximumPercentage,
      'description': description,
      'created_by': createdBy,
      'created_at': createdAt,
    };
  }
}
class ExamDataSubjectExamAssesment {
  String? cbseExamAssessmentTypeName;
  String? cbseExamAssessmentTypeId;
  String? cbseExamAssessmentTypeCode;
  String? maximumMarks;
  String? cbseStudentSubjectMarksId;
  String? marks;
  String? note;
  String? isAbsent;

  ExamDataSubjectExamAssesment(
      {this.cbseExamAssessmentTypeName,
        this.cbseExamAssessmentTypeId,
        this.cbseExamAssessmentTypeCode,
        this.maximumMarks,
        this.cbseStudentSubjectMarksId,
        this.marks,
        this.note,
        this.isAbsent});

  ExamDataSubjectExamAssesment.fromJson(Map<String, dynamic> json) {
    cbseExamAssessmentTypeName = json['cbse_exam_assessment_type_name'];
    cbseExamAssessmentTypeId = json['cbse_exam_assessment_type_id'];
    cbseExamAssessmentTypeCode = json['cbse_exam_assessment_type_code'];
    maximumMarks = json['maximum_marks'];
    cbseStudentSubjectMarksId = json['cbse_student_subject_marks_id'];
    marks = json['marks'];
    note = json['note'];
    isAbsent = json['is_absent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cbse_exam_assessment_type_name'] = this.cbseExamAssessmentTypeName;
    data['cbse_exam_assessment_type_id'] = this.cbseExamAssessmentTypeId;
    data['cbse_exam_assessment_type_code'] = this.cbseExamAssessmentTypeCode;
    data['maximum_marks'] = this.maximumMarks;
    data['cbse_student_subject_marks_id'] = this.cbseStudentSubjectMarksId;
    data['marks'] = this.marks;
    data['note'] = this.note;
    data['is_absent'] = this.isAbsent;
    return data;
  }
}
class ExamAssessment {
  String? id;
  String? cbseExamAssessmentId;
  String? name;
  String? code;
  String? maximumMarks;
  String? passPercentage;
  String? description;
  String? createdBy;
  String? createdAt;

  ExamAssessment({
    this.id,
    this.cbseExamAssessmentId,
    this.name,
    this.code,
    this.maximumMarks,
    this.passPercentage,
    this.description,
    this.createdBy,
    this.createdAt,
  });

  factory ExamAssessment.fromJson(Map<String, dynamic> json) {
    print("####################${json}");
    return ExamAssessment(
      id: json['id'],
      cbseExamAssessmentId: json['cbse_exam_assessment_id'],
      name: json['name'],
      code: json['code'],
      maximumMarks: json['maximum_marks'],
      passPercentage: json['pass_percentage'],
      description: json['description'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cbse_exam_assessment_id': cbseExamAssessmentId,
      'name': name,
      'code': code,
      'maximum_marks': maximumMarks,
      'pass_percentage': passPercentage,
      'description': description,
      'created_by': createdBy,
      'created_at': createdAt,
    };
  }
}

class ExamSubjectAssessment {
  String? id;
  String? cbseExamId;
  String? subjectId;
  String? date;
  String? timeFrom;
  String? timeTo;
  String? duration;
  String? roomNo;
  String? isWritten;
  String? writtenMaximumMarks;
  String? isPractical;
  String? practicalMaximumMark;
  String? createdBy;
  String? createdAt;
  String? subjectName;
  String? subjectCode;
  List<SubjectAssessment>? subjectAssessments;

  ExamSubjectAssessment({
    this.id,
    this.cbseExamId,
    this.subjectId,
    this.date,
    this.timeFrom,
    this.timeTo,
    this.duration,
    this.roomNo,
    this.isWritten,
    this.writtenMaximumMarks,
    this.isPractical,
    this.practicalMaximumMark,
    this.createdBy,
    this.createdAt,
    this.subjectName,
    this.subjectCode,
    this.subjectAssessments,
  });

  factory ExamSubjectAssessment.fromJson(Map<String, dynamic> json) {
    return ExamSubjectAssessment(
      id: json['id'],
      cbseExamId: json['cbse_exam_id'],
      subjectId: json['subject_id'],
      date: json['date'],
      timeFrom: json['time_from'],
      timeTo: json['time_to'],
      duration: json['duration'],
      roomNo: json['room_no'],
      isWritten: json['is_written'],
      writtenMaximumMarks: json['written_maximum_marks'],
      isPractical: json['is_practical'],
      practicalMaximumMark: json['practical_maximum_mark'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      subjectName: json['subject_name'],
      subjectCode: json['subject_code'],
      subjectAssessments: List<SubjectAssessment>.from(json['subject_assessments'].map((x) => SubjectAssessment.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cbse_exam_id': cbseExamId,
      'subject_id': subjectId,
      'date': date,
      'time_from': timeFrom,
      'time_to': timeTo,
      'duration': duration,
      'room_no': roomNo,
      'is_written': isWritten,
      'written_maximum_marks': writtenMaximumMarks,
      'is_practical': isPractical,
      'practical_maximum_mark': practicalMaximumMark,
      'created_by': createdBy,
      'created_at': createdAt,
      'subject_name': subjectName,
      'subject_code': subjectCode,
      'subject_assessments': List<dynamic>.from(subjectAssessments!.map((x) => x.toJson())),
    };
  }
}

class ExamData {
  List<Subject2>? subjects;

  ExamData({
    this.subjects,
  });

  factory ExamData.fromJson(Map<String, dynamic> json) {
    return ExamData(
      subjects: List<Subject2>.from(json['subjects'].map((x) => Subject2.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjects': List<dynamic>.from(subjects!.map((x) => x.toJson())),
    };
  }
}

class Subject2 {
  String? subjectId;
  String? subjectName;
  String? subjectCode;
  ExamAssessments? examAssessments;

  Subject2({
    this.subjectId,
    this.subjectName,
    this.subjectCode,
    this.examAssessments,
  });

  factory Subject2.fromJson(Map<String, dynamic> json) {
    return Subject2(
      subjectId: json['subject_id'],
      subjectName: json['subject_name'],
      subjectCode: json['subject_code'],
      examAssessments: ExamAssessments.fromJson(json['exam_assessments']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject_id': subjectId,
      'subject_name': subjectName,
      'subject_code': subjectCode,
      'exam_assessments': examAssessments!.toJson(),
    };
  }
}

class ExamAssessments {
  ExamDataSubjectExamAssesment? examAssessment1;
  ExamDataSubjectExamAssesment? examAssessment2;
  ExamDataSubjectExamAssesment? examAssessment3;
  ExamDataSubjectExamAssesment? examAssessment4;

  ExamAssessments({
    this.examAssessment1,
    this.examAssessment2,
    this.examAssessment3,
    this.examAssessment4,
  });

  factory ExamAssessments.fromJson(Map<String, dynamic> json) {
    print("***********${json}");
    return ExamAssessments(
      examAssessment1: json.containsKey('1') ?  ExamDataSubjectExamAssesment.fromJson(json['1']): null,
      examAssessment2: json.containsKey('2') ?  ExamDataSubjectExamAssesment.fromJson(json['2']): null,
      examAssessment3: json.containsKey('3') ?  ExamDataSubjectExamAssesment.fromJson(json['3']): null,
      examAssessment4: json.containsKey('4') ? ExamDataSubjectExamAssesment.fromJson(json!['4']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '1': examAssessment1!.toJson(),
      '2': examAssessment2!.toJson(),
      '3': examAssessment3!.toJson(),
      // '4': examAssessment4!.toJson(),
    };
  }
}

// class Exam {
//   String id;
//   String cbseExamId;
//   String studentSessionId;
//   String staffId;
//   dynamic rollNo;
//   String remark;
//   String totalPresentDays;
//   String deleteStudentId;
//   String createdAt;
//   String cbseExamAssessmentId;
//   String cbseTermId;
//   String name;
//   String useExamRollNo;
//   String isActive;
//   String isPublish;
//   String cbseExamGradeId;
//   String totalWorkingDays;
//   List<ExamSubjectAssessment> subjects;
//   List<Grade> grades;
//   List<ExamAssessment> examAssessments;
//   ExamData examData;
//   String examTotalMarks;
//   String examObtainMarks;
//   String examPercentage;
//   String examGrade;
//   String examRank;
//
//   Exam({
//     this.id,
//     this.cbseExamId,
//     this.studentSessionId,
//     this.staffId,
//     this.rollNo,
//     this.remark,
//     this.totalPresentDays,
//     this.deleteStudentId,
//     this.createdAt,
//     this.cbseExamAssessmentId,
//     this.cbseTermId,
//     this.name,
//     this.useExamRollNo,
//     this.isActive,
//     this.isPublish,
//     this.cbseExamGradeId,
//     this.totalWorkingDays,
//     this.subjects,
//     this.grades,
//     this.examAssessments,
//     this.examData,
//     this.examTotalMarks,
//     this.examObtainMarks,
//     this.examPercentage,
//     this.examGrade,
//     this.examRank,
//   });
//
//   factory Exam.fromJson(Map<String, dynamic> json) {
//     return Exam(
//       id: json['id'],
//       cbseExamId: json['cbse_exam_id'],
//       studentSessionId: json['student_session_id'],
//       staffId: json['staff_id'],
//       rollNo: json['roll_no'],
//       remark: json['remark'],
//       totalPresentDays: json['total_present_days'],
//       deleteStudentId: json['delete_student_id'],
//       createdAt: json['created_at'],
//       cbseExamAssessmentId: json['cbse_exam_assessment_id'],
//       cbseTermId: json['cbse_term_id'],
//       name: json['name'],
//       useExamRollNo: json['use_exam_roll_no'],
//       isActive: json['is_active'],
//       isPublish: json['is_publish'],
//       cbseExamGradeId: json['cbse_exam_grade_id'],
//       totalWorkingDays: json['total_working_days'],
//       subjects: List<ExamSubjectAssessment>.from(json['subjects'].map((x) => ExamSubjectAssessment.fromJson(x))),
//       grades: List<Grade>.from(json['grades'].map((x) => Grade.fromJson(x))),
//       examAssessments: List<ExamAssessment>.from(json['exam_assessments'].map((x) => ExamAssessment.fromJson(x))),
//       examData: ExamData.fromJson(json['exam_data']),
//       examTotalMarks: json['exam_total_marks'],
//       examObtainMarks: json['exam_obtain_marks'],
//       examPercentage: json['exam_percentage'],
//       examGrade: json['exam_grade'],
//       examRank: json['exam_rank'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'cbse_exam_id': cbseExamId,
//       'student_session_id': studentSessionId,
//       'staff_id': staffId,
//       'roll_no': rollNo,
//       'remark': remark,
//       'total_present_days': totalPresentDays,
//       'delete_student_id': deleteStudentId,
//       'created_at': createdAt,
//       'cbse_exam_assessment_id': cbseExamAssessmentId,
//       'cbse_term_id': cbseTermId,
//       'name': name,
//       'use_exam_roll_no': useExamRollNo,
//       'is_active': isActive,
//       'is_publish': isPublish,
//       'cbse_exam_grade_id': cbseExamGradeId,
//       'total_working_days': totalWorkingDays,
//       'subjects': List<dynamic>.from(subjects.map((x) => x.toJson())),
//       'grades': List<dynamic>.from(grades.map((x) => x.toJson())),
//       'exam_assessments': List<dynamic>.from(examAssessments.map((x) => x.toJson())),
//       'exam_data': examData.toJson(),
//       'exam_total_marks': examTotalMarks,
//       'exam_obtain_marks': examObtainMarks,
//       'exam_percentage': examPercentage,
//       'exam_grade': examGrade,
//       'exam_rank': examRank,
//     };
//   }
// }

