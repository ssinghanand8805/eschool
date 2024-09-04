class SubjectGroup {
  String? name;
  String? id;
  String? subjectGroupId;
  String? classSectionId;
  String? sessionId;
  String? description;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  SubjectGroup(
      {this.name,
        this.id,
        this.subjectGroupId,
        this.classSectionId,
        this.sessionId,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  SubjectGroup.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    subjectGroupId = json['subject_group_id'];
    classSectionId = json['class_section_id'];
    sessionId = json['session_id'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['subject_group_id'] = this.subjectGroupId;
    data['class_section_id'] = this.classSectionId;
    data['session_id'] = this.sessionId;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


class TimeTableList {
  String? classId;
  String? sectionId;
  String? subjectGroupId;
  List<Staff>? staff;
  DayWisePriviousRecord? dayWisePriviousRecord;
  GetDaysnameList? getDaysnameList;
  List<Subject>? subject;

  TimeTableList(
      {this.classId,
        this.sectionId,
        this.subjectGroupId,
        this.staff,
        this.dayWisePriviousRecord,
        this.getDaysnameList,
        this.subject});

  TimeTableList.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    sectionId = json['section_id'];
    subjectGroupId = json['subject_group_id'];
    if (json['staff'] != null) {
      staff = <Staff>[];
      json['staff'].forEach((v) {
        staff!.add(new Staff.fromJson(v));
      });
    }
    dayWisePriviousRecord = json['dayWisePriviousRecord'] != null
        ? new DayWisePriviousRecord.fromJson(json['dayWisePriviousRecord'])
        : null;
    getDaysnameList = json['getDaysnameList'] != null
        ? new GetDaysnameList.fromJson(json['getDaysnameList'])
        : null;
    if (json['subject'] != null) {
      subject = <Subject>[];
      json['subject'].forEach((v) {
        subject!.add(new Subject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    data['subject_group_id'] = this.subjectGroupId;
    if (this.staff != null) {
      data['staff'] = this.staff!.map((v) => v.toJson()).toList();
    }
    if (this.dayWisePriviousRecord != null) {
      data['dayWisePriviousRecord'] = this.dayWisePriviousRecord!.toJson();
    }
    if (this.getDaysnameList != null) {
      data['getDaysnameList'] = this.getDaysnameList!.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Staff {
  String? id;
  String? employeeId;
  String? langId;
  String? currencyId;
  Null? department;
  Null? designation;
  String? qualification;
  String? workExp;
  String? name;
  String? surname;
  String? fatherName;
  String? motherName;
  String? contactNo;
  String? emergencyContactNo;
  String? email;
  String? dob;
  String? maritalStatus;
  Null? dateOfJoining;
  Null? dateOfLeaving;
  String? localAddress;
  String? permanentAddress;
  String? note;
  String? image;
  String? password;
  String? gender;
  String? accountTitle;
  String? bankAccountNo;
  String? bankName;
  String? ifscCode;
  String? bankBranch;
  String? payscale;
  String? basicSalary;
  String? epfNo;
  String? contractType;
  String? shift;
  String? location;
  String? facebook;
  String? twitter;
  String? linkedin;
  String? instagram;
  String? resume;
  String? joiningLetter;
  String? resignationLetter;
  String? otherDocumentName;
  String? otherDocumentFile;
  String? userId;
  String? isActive;
  String? verificationCode;
  Null? disableAt;
  String? roleId;
  String? userType;

  Staff(
      {this.id,
        this.employeeId,
        this.langId,
        this.currencyId,
        this.department,
        this.designation,
        this.qualification,
        this.workExp,
        this.name,
        this.surname,
        this.fatherName,
        this.motherName,
        this.contactNo,
        this.emergencyContactNo,
        this.email,
        this.dob,
        this.maritalStatus,
        this.dateOfJoining,
        this.dateOfLeaving,
        this.localAddress,
        this.permanentAddress,
        this.note,
        this.image,
        this.password,
        this.gender,
        this.accountTitle,
        this.bankAccountNo,
        this.bankName,
        this.ifscCode,
        this.bankBranch,
        this.payscale,
        this.basicSalary,
        this.epfNo,
        this.contractType,
        this.shift,
        this.location,
        this.facebook,
        this.twitter,
        this.linkedin,
        this.instagram,
        this.resume,
        this.joiningLetter,
        this.resignationLetter,
        this.otherDocumentName,
        this.otherDocumentFile,
        this.userId,
        this.isActive,
        this.verificationCode,
        this.disableAt,
        this.roleId,
        this.userType});

  Staff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    langId = json['lang_id'];
    currencyId = json['currency_id'];
    department = json['department'];
    designation = json['designation'];
    qualification = json['qualification'];
    workExp = json['work_exp'];
    name = json['name'];
    surname = json['surname'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    contactNo = json['contact_no'];
    emergencyContactNo = json['emergency_contact_no'];
    email = json['email'];
    dob = json['dob'];
    maritalStatus = json['marital_status'];
    dateOfJoining = json['date_of_joining'];
    dateOfLeaving = json['date_of_leaving'];
    localAddress = json['local_address'];
    permanentAddress = json['permanent_address'];
    note = json['note'];
    image = json['image'];
    password = json['password'];
    gender = json['gender'];
    accountTitle = json['account_title'];
    bankAccountNo = json['bank_account_no'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    bankBranch = json['bank_branch'];
    payscale = json['payscale'];
    basicSalary = json['basic_salary'];
    epfNo = json['epf_no'];
    contractType = json['contract_type'];
    shift = json['shift'];
    location = json['location'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    instagram = json['instagram'];
    resume = json['resume'];
    joiningLetter = json['joining_letter'];
    resignationLetter = json['resignation_letter'];
    otherDocumentName = json['other_document_name'];
    otherDocumentFile = json['other_document_file'];
    userId = json['user_id'];
    isActive = json['is_active'];
    verificationCode = json['verification_code'];
    disableAt = json['disable_at'];
    roleId = json['role_id'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['lang_id'] = this.langId;
    data['currency_id'] = this.currencyId;
    data['department'] = this.department;
    data['designation'] = this.designation;
    data['qualification'] = this.qualification;
    data['work_exp'] = this.workExp;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['contact_no'] = this.contactNo;
    data['emergency_contact_no'] = this.emergencyContactNo;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['marital_status'] = this.maritalStatus;
    data['date_of_joining'] = this.dateOfJoining;
    data['date_of_leaving'] = this.dateOfLeaving;
    data['local_address'] = this.localAddress;
    data['permanent_address'] = this.permanentAddress;
    data['note'] = this.note;
    data['image'] = this.image;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['account_title'] = this.accountTitle;
    data['bank_account_no'] = this.bankAccountNo;
    data['bank_name'] = this.bankName;
    data['ifsc_code'] = this.ifscCode;
    data['bank_branch'] = this.bankBranch;
    data['payscale'] = this.payscale;
    data['basic_salary'] = this.basicSalary;
    data['epf_no'] = this.epfNo;
    data['contract_type'] = this.contractType;
    data['shift'] = this.shift;
    data['location'] = this.location;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['linkedin'] = this.linkedin;
    data['instagram'] = this.instagram;
    data['resume'] = this.resume;
    data['joining_letter'] = this.joiningLetter;
    data['resignation_letter'] = this.resignationLetter;
    data['other_document_name'] = this.otherDocumentName;
    data['other_document_file'] = this.otherDocumentFile;
    data['user_id'] = this.userId;
    data['is_active'] = this.isActive;
    data['verification_code'] = this.verificationCode;
    data['disable_at'] = this.disableAt;
    data['role_id'] = this.roleId;
    data['user_type'] = this.userType;
    return data;
  }
}

class DayWisePriviousRecord {
  Monday? monday;
  Monday? tuesday;
  Monday? wednesday;
  Monday? thursday;
  Monday? friday;
  Monday? saturday;
  Monday? sunday;

  DayWisePriviousRecord(
      {this.monday,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.friday,
        this.saturday,
        this.sunday});

  DayWisePriviousRecord.fromJson(Map<String, dynamic> json) {
    monday =
    json['Monday'] != null ? new Monday.fromJson(json['Monday']) : null;
    tuesday =
    json['Tuesday'] != null ? new Monday.fromJson(json['Tuesday']) : null;
    wednesday = json['Wednesday'] != null
        ? new Monday.fromJson(json['Wednesday'])
        : null;
    thursday =
    json['Thursday'] != null ? new Monday.fromJson(json['Thursday']) : null;
    friday =
    json['Friday'] != null ? new Monday.fromJson(json['Friday']) : null;
    saturday =
    json['Saturday'] != null ? new Monday.fromJson(json['Saturday']) : null;
    sunday =
    json['Sunday'] != null ? new Monday.fromJson(json['Sunday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monday != null) {
      data['Monday'] = this.monday!.toJson();
    }
    if (this.tuesday != null) {
      data['Tuesday'] = this.tuesday!.toJson();
    }
    if (this.wednesday != null) {
      data['Wednesday'] = this.wednesday!.toJson();
    }
    if (this.thursday != null) {
      data['Thursday'] = this.thursday!.toJson();
    }
    if (this.friday != null) {
      data['Friday'] = this.friday!.toJson();
    }
    if (this.saturday != null) {
      data['Saturday'] = this.saturday!.toJson();
    }
    if (this.sunday != null) {
      data['Sunday'] = this.sunday!.toJson();
    }
    return data;
  }
}

class Monday {
  int? totalCount;
  List<Record>? record;

  Monday({this.totalCount, this.record});

  Monday.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['record'] != null) {
      record = <Record>[];
      json['record'].forEach((v) {
        record!.add(new Record.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.record != null) {
      data['record'] = this.record!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Record {
  String? id;
  String? sessionId;
  String? classId;
  String? sectionId;
  String? subjectGroupId;
  String? subjectGroupSubjectId;
  String? staffId;
  String? day;
  String? timeFrom;
  String? timeTo;
  String? startTime;
  String? endTime;
  String? roomNo;
  String? createdAt;

  Record(
      {this.id,
        this.sessionId,
        this.classId,
        this.sectionId,
        this.subjectGroupId,
        this.subjectGroupSubjectId,
        this.staffId,
        this.day,
        this.timeFrom,
        this.timeTo,
        this.startTime,
        this.endTime,
        this.roomNo,
        this.createdAt});

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    subjectGroupId = json['subject_group_id'];
    subjectGroupSubjectId = json['subject_group_subject_id'];
    staffId = json['staff_id'];
    day = json['day'];
    timeFrom = json['time_from'];
    timeTo = json['time_to'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    roomNo = json['room_no'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session_id'] = this.sessionId;
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    data['subject_group_id'] = this.subjectGroupId;
    data['subject_group_subject_id'] = this.subjectGroupSubjectId;
    data['staff_id'] = this.staffId;
    data['day'] = this.day;
    data['time_from'] = this.timeFrom;
    data['time_to'] = this.timeTo;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['room_no'] = this.roomNo;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class GetDaysnameList {
  String? monday;
  String? tuesday;
  String? wednesday;
  String? thursday;
  String? friday;
  String? saturday;
  String? sunday;

  GetDaysnameList(
      {this.monday,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.friday,
        this.saturday,
        this.sunday});

  GetDaysnameList.fromJson(Map<String, dynamic> json) {
    monday = json['Monday'];
    tuesday = json['Tuesday'];
    wednesday = json['Wednesday'];
    thursday = json['Thursday'];
    friday = json['Friday'];
    saturday = json['Saturday'];
    sunday = json['Sunday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Monday'] = this.monday;
    data['Tuesday'] = this.tuesday;
    data['Wednesday'] = this.wednesday;
    data['Thursday'] = this.thursday;
    data['Friday'] = this.friday;
    data['Saturday'] = this.saturday;
    data['Sunday'] = this.sunday;
    return data;
  }
}

class Subject {
  String? id;
  String? subjectGroupId;
  String? sessionId;
  String? subjectId;
  String? createdAt;
  String? name;
  String? code;
  String? type;

  Subject(
      {this.id,
        this.subjectGroupId,
        this.sessionId,
        this.subjectId,
        this.createdAt,
        this.name,
        this.code,
        this.type});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectGroupId = json['subject_group_id'];
    sessionId = json['session_id'];
    subjectId = json['subject_id'];
    createdAt = json['created_at'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subject_group_id'] = this.subjectGroupId;
    data['session_id'] = this.sessionId;
    data['subject_id'] = this.subjectId;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    data['code'] = this.code;
    data['type'] = this.type;
    return data;
  }
}
