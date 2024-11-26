class StaffListModal {
  String? status;
  String? error;
  Data? data;

  StaffListModal({this.status, this.error, this.data});

  StaffListModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Resultlist>? resultlist;

  Data({this.resultlist});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['resultlist'] != null) {
      resultlist = <Resultlist>[];
      json['resultlist'].forEach((v) {
        resultlist!.add(new Resultlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resultlist != null) {
      data['resultlist'] = this.resultlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Resultlist {
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

  Resultlist(
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

  Resultlist.fromJson(Map<String, dynamic> json) {
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
