import '../../../apiHelper/GlobalData.dart';

class Faculity{
  String? id;
  String? employeeId;
  String? langId;
  String? currencyId;
  String? department;
  String? designation;
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
  String? dateOfJoining;
  String? dateOfLeaving;
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
  String? disableAt;
  String? language;
  String? languageId;
  String? isRtl;
  String? currencyName;
  String? symbol;
  String? basePrice;
  String? currency;
  String? chatAccessToken;
  String? chatUserId;
  Roles? roles;

  Faculity(
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
        this.languageId,
        this.isRtl,
        this.currencyName,
        this.symbol,
        this.basePrice,
        this.currency,
        this.chatAccessToken,
        this.chatUserId,
        this.roles});

  Faculity.fromJson(Map<String, dynamic> json) {

    String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
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
    image = json['image'] == "" ? "" : baseUrlFromPref + 'uploads/staff_images/' + json['image'];
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
    languageId = json['language_id'];
    isRtl = json['is_rtl'];
    currencyName = json['currency_name'];
    symbol = json['symbol'];
    basePrice = json['base_price'];
    currency = json['currency'];
    chatAccessToken = json['chatAccessToken'];
    chatUserId = json['chatUserId'].toString();
    roles = json['roles'] != null ? new Roles.fromJson(json['roles']) : null;
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
    data['language_id'] = this.languageId;
    data['is_rtl'] = this.isRtl;
    data['currency_name'] = this.currencyName;
    data['symbol'] = this.symbol;
    data['base_price'] = this.basePrice;
    data['currency'] = this.currency;
    data['chatAccessToken'] = this.chatAccessToken;
    data['chatUserId'] = this.chatUserId;
    if (this.roles != null) {
      data['roles'] = this.roles!.toJson();
    }
    return data;
  }
}

class Roles {
  String? roleName;
  String? roleId;

  Roles({this.roleName,this.roleId});

  Roles.fromJson(Map<String, dynamic> json) {
    roleName = json['roleName'];
    roleId = json['roleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleName'] = this.roleName;
    data['roleId'] = this.roleId;
    return data;
  }
}