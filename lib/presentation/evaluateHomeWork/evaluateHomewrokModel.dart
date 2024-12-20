class EvaluateHomework {
  int? status;
  Data? data;

  EvaluateHomework({this.status, this.data});

  EvaluateHomework.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Studentlist>? studentlist;
  Result? result;
  String? createdBy;
  String? evaluatedBy;

  Data({this.studentlist, this.result, this.createdBy, this.evaluatedBy});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['studentlist'] != null) {
      studentlist = <Studentlist>[];
      json['studentlist'].forEach((v) {
        studentlist!.add(new Studentlist.fromJson(v));
      });
    }
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    createdBy = json['created_by'];
    evaluatedBy = json['evaluated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.studentlist != null) {
      data['studentlist'] = this.studentlist!.map((v) => v.toJson()).toList();
    }
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['created_by'] = this.createdBy;
    data['evaluated_by'] = this.evaluatedBy;
    return data;
  }
}

class Studentlist {
  String? homeworkEvaluationId;
  String? note;
  String? marks;
  String? id;
  String? sessionId;
  String? studentId;
  String? classId;
  String? sectionId;
  String? hostelRoomId;
  String? vehrouteId;
  String? routePickupPointId;
  String? transportFees;
  String? feesDiscount;
  String? isLeave;
  String? isActive;
  String? isAlumni;
  String? defaultLogin;
  String? createdAt;
  String? updatedAt;
  String? firstname;
  String? middlename;
  String? lastname;
  String? admissionNo;
  List<Assignmentlist>? assignmentlist;

  Studentlist(
      {this.homeworkEvaluationId,
      this.note,
      this.marks,
      this.id,
      this.sessionId,
      this.studentId,
      this.classId,
      this.sectionId,
      this.hostelRoomId,
      this.vehrouteId,
      this.routePickupPointId,
      this.transportFees,
      this.feesDiscount,
      this.isLeave,
      this.isActive,
      this.isAlumni,
      this.defaultLogin,
      this.createdAt,
      this.updatedAt,
      this.firstname,
      this.middlename,
      this.lastname,
      this.admissionNo,
      this.assignmentlist});

  Studentlist.fromJson(Map<String, dynamic> json) {
    homeworkEvaluationId = json['homework_evaluation_id'];
    note = json['note'];
    marks = json['marks'];
    id = json['id'];
    sessionId = json['session_id'];
    studentId = json['student_id'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    hostelRoomId = json['hostel_room_id'];
    vehrouteId = json['vehroute_id'];
    routePickupPointId = json['route_pickup_point_id'];
    transportFees = json['transport_fees'];
    feesDiscount = json['fees_discount'];
    isLeave = json['is_leave'];
    isActive = json['is_active'];
    isAlumni = json['is_alumni'];
    defaultLogin = json['default_login'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    admissionNo = json['admission_no'];
    if (json['assignmentlist'] != null) {
      assignmentlist = <Assignmentlist>[];
      json['assignmentlist'].forEach((v) {
        assignmentlist!.add(new Assignmentlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['homework_evaluation_id'] = this.homeworkEvaluationId;
    data['note'] = this.note;
    data['marks'] = this.marks;
    data['id'] = this.id;
    data['session_id'] = this.sessionId;
    data['student_id'] = this.studentId;
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    data['hostel_room_id'] = this.hostelRoomId;
    data['vehroute_id'] = this.vehrouteId;
    data['route_pickup_point_id'] = this.routePickupPointId;
    data['transport_fees'] = this.transportFees;
    data['fees_discount'] = this.feesDiscount;
    data['is_leave'] = this.isLeave;
    data['is_active'] = this.isActive;
    data['is_alumni'] = this.isAlumni;
    data['default_login'] = this.defaultLogin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['admission_no'] = this.admissionNo;
    if (this.assignmentlist != null) {
      data['assignmentlist'] =
          this.assignmentlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Assignmentlist {
  String? submitAssignmentId;
  String? docs;
  String? message;
  String? studentId;

  Assignmentlist(
      {this.submitAssignmentId, this.docs, this.message, this.studentId});

  Assignmentlist.fromJson(Map<String, dynamic> json) {
    submitAssignmentId = json['submit_assignment_id'];
    docs = json['docs'];
    message = json['message'];
    studentId = json['student_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['submit_assignment_id'] = this.submitAssignmentId;
    data['docs'] = this.docs;
    data['message'] = this.message;
    data['student_id'] = this.studentId;
    return data;
  }
}

class Result {
  String? id;
  String? classId;
  String? sectionId;
  String? sessionId;
  String? staffId;
  String? subjectGroupSubjectId;
  String? subjectId;
  String? homeworkDate;
  String? submitDate;
  String? marks;
  String? description;
  String? isAssignment;
  String? createDate;
  String? evaluationDate;
  String? document;
  String? createdBy;
  String? evaluatedBy;
  String? createdAt;
  String? className;
  String? section;
  String? name;
  String? code;
  String? subjectGroup;
  String? createdStaffId;
  String? createdEmployeeId;
  String? createdStaffName;
  String? createdStaffSurname;
  String? createdStaffRoleid;

  Result(
      {this.id,
      this.classId,
      this.sectionId,
      this.sessionId,
      this.staffId,
      this.subjectGroupSubjectId,
      this.subjectId,
      this.homeworkDate,
      this.submitDate,
      this.marks,
      this.description,
      this.isAssignment,
      this.createDate,
      this.evaluationDate,
      this.document,
      this.createdBy,
      this.evaluatedBy,
      this.createdAt,
      this.className,
      this.section,
      this.name,
      this.code,
      this.subjectGroup,
      this.createdStaffId,
      this.createdEmployeeId,
      this.createdStaffName,
      this.createdStaffSurname,
      this.createdStaffRoleid});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    sessionId = json['session_id'];
    staffId = json['staff_id'];
    subjectGroupSubjectId = json['subject_group_subject_id'];
    subjectId = json['subject_id'];
    homeworkDate = json['homework_date'];
    submitDate = json['submit_date'];
    marks = json['marks'];
    description = json['description'];
    isAssignment = json['isAssignment'];
    createDate = json['create_date'];
    evaluationDate = json['evaluation_date'];
    document = json['document'];
    createdBy = json['created_by'];
    evaluatedBy = json['evaluated_by'];
    createdAt = json['created_at'];
    className = json['class'];
    section = json['section'];
    name = json['name'];
    code = json['code'];
    subjectGroup = json['subject_group'];
    createdStaffId = json['created_staff_id'];
    createdEmployeeId = json['created_employee_id'];
    createdStaffName = json['created_staff_name'];
    createdStaffSurname = json['created_staff_surname'];
    createdStaffRoleid = json['created_staff_roleid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    data['session_id'] = this.sessionId;
    data['staff_id'] = this.staffId;
    data['subject_group_subject_id'] = this.subjectGroupSubjectId;
    data['subject_id'] = this.subjectId;
    data['homework_date'] = this.homeworkDate;
    data['submit_date'] = this.submitDate;
    data['marks'] = this.marks;
    data['description'] = this.description;
    data['isAssignment'] = this.isAssignment;
    data['create_date'] = this.createDate;
    data['evaluation_date'] = this.evaluationDate;
    data['document'] = this.document;
    data['created_by'] = this.createdBy;
    data['evaluated_by'] = this.evaluatedBy;
    data['created_at'] = this.createdAt;
    data['class'] = this.className;
    data['section'] = this.section;
    data['name'] = this.name;
    data['code'] = this.code;
    data['subject_group'] = this.subjectGroup;
    data['created_staff_id'] = this.createdStaffId;
    data['created_employee_id'] = this.createdEmployeeId;
    data['created_staff_name'] = this.createdStaffName;
    data['created_staff_surname'] = this.createdStaffSurname;
    data['created_staff_roleid'] = this.createdStaffRoleid;
    return data;
  }
}
