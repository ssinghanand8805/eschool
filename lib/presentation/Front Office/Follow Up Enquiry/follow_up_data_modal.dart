class FollowUpDataModal {
  int? id;
  EnquiryData? enquiryData;
  String? assignedStaff;
  List<String>? nextDate;
  List<CreatedBy>? createdBy;
  EnquiryStatus? enquiryStatus;
  String? staffRole;
  String? loginStaffId;
  String? superadminRest;

  FollowUpDataModal(
      {this.id,
        this.enquiryData,
        this.assignedStaff,
        this.nextDate,
        this.createdBy,
        this.enquiryStatus,
        this.staffRole,
        this.loginStaffId,
        this.superadminRest});

  FollowUpDataModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enquiryData = json['enquiry_data'] != null
        ? new EnquiryData.fromJson(json['enquiry_data'])
        : null;
    assignedStaff = json['assigned_staff'];
    if (json['next_date'] != null) {
      nextDate = <String>[];
      json['next_date'].forEach((v) {
        nextDate!.add(v.toString());
      });
    }
    if (json['created_by'] != null) {
      createdBy = <CreatedBy>[];
      json['created_by'].forEach((v) {
        createdBy!.add(new CreatedBy.fromJson(v));
      });
    }
    enquiryStatus = json['enquiry_status'] != null
        ? new EnquiryStatus.fromJson(json['enquiry_status'])
        : null;
    staffRole = json['staff_role'];
    loginStaffId = json['login_staff_id'];
    superadminRest = json['superadmin_rest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.enquiryData != null) {
      data['enquiry_data'] = this.enquiryData!.toJson();
    }
    data['assigned_staff'] = this.assignedStaff;
    if (this.nextDate != null) {
      data['next_date'] = this.nextDate!.map((v) => v).toList();
    }
    if (this.createdBy != null) {
      data['created_by'] = this.createdBy!.map((v) => v.toJson()).toList();
    }
    if (this.enquiryStatus != null) {
      data['enquiry_status'] = this.enquiryStatus!.toJson();
    }
    data['staff_role'] = this.staffRole;
    data['login_staff_id'] = this.loginStaffId;
    data['superadmin_rest'] = this.superadminRest;
    return data;
  }
}

class EnquiryData {
  String? id;
  String? name;
  String? contact;
  String? address;
  String? referenceId;
  String? date;
  String? description;
  String? followUpDate;
  String? note;
  String? sourceId;
  String? email;
  Null? assigned;
  String? classId;
  String? noOfChild;
  String? status;
  String? dob;
  String? lastschool;
  String? lastclass;
  String? fathername;
  String? occupation;
  String? createdBy;
  String? createdAt;
  String? classname;
  Null? staffId;
  Null? staffName;
  Null? staffSurname;
  Null? employeeId;

  EnquiryData(
      {this.id,
        this.name,
        this.contact,
        this.address,
        this.referenceId,
        this.date,
        this.description,
        this.followUpDate,
        this.note,
        this.sourceId,
        this.email,
        this.assigned,
        this.classId,
        this.noOfChild,
        this.status,
        this.dob,
        this.lastschool,
        this.lastclass,
        this.fathername,
        this.occupation,
        this.createdBy,
        this.createdAt,
        this.classname,
        this.staffId,
        this.staffName,
        this.staffSurname,
        this.employeeId});

  EnquiryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    address = json['address'];
    referenceId = json['reference_id'];
    date = json['date'];
    description = json['description'];
    followUpDate = json['follow_up_date'];
    note = json['note'];
    sourceId = json['source_id'];
    email = json['email'];
    assigned = json['assigned'];
    classId = json['class_id'];
    noOfChild = json['no_of_child'];
    status = json['status'];
    dob = json['dob'];
    lastschool = json['lastschool'];
    lastclass = json['lastclass'];
    fathername = json['fathername'];
    occupation = json['occupation'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    classname = json['classname'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    staffSurname = json['staff_surname'];
    employeeId = json['employee_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['address'] = this.address;
    data['reference_id'] = this.referenceId;
    data['date'] = this.date;
    data['description'] = this.description;
    data['follow_up_date'] = this.followUpDate;
    data['note'] = this.note;
    data['source_id'] = this.sourceId;
    data['email'] = this.email;
    data['assigned'] = this.assigned;
    data['class_id'] = this.classId;
    data['no_of_child'] = this.noOfChild;
    data['status'] = this.status;
    data['dob'] = this.dob;
    data['lastschool'] = this.lastschool;
    data['lastclass'] = this.lastclass;
    data['fathername'] = this.fathername;
    data['occupation'] = this.occupation;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['classname'] = this.classname;
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    data['staff_surname'] = this.staffSurname;
    data['employee_id'] = this.employeeId;
    return data;
  }
}

class CreatedBy {
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
  Null? language;
  Null? isRtl;
  String? userType;
  String? roleId;

  CreatedBy(
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
        this.language,
        this.isRtl,
        this.userType,
        this.roleId});

  CreatedBy.fromJson(Map<String, dynamic> json) {
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
    language = json['language'];
    isRtl = json['is_rtl'];
    userType = json['user_type'];
    roleId = json['role_id'];
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
    data['language'] = this.language;
    data['is_rtl'] = this.isRtl;
    data['user_type'] = this.userType;
    data['role_id'] = this.roleId;
    return data;
  }
}

class EnquiryStatus {
  String? active;
  String? passive;
  String? dead;
  String? won;
  String? lost;

  EnquiryStatus({this.active, this.passive, this.dead, this.won, this.lost});

  EnquiryStatus.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    passive = json['passive'];
    dead = json['dead'];
    won = json['won'];
    lost = json['lost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['passive'] = this.passive;
    data['dead'] = this.dead;
    data['won'] = this.won;
    data['lost'] = this.lost;
    return data;
  }
}
