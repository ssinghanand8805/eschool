class StudentGaurdian {
  String? status;
  String? error;
  String? message;
  List<Data>? data;

  StudentGaurdian({this.status, this.error, this.message, this.data});

  StudentGaurdian.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) { data!.add(new Data.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? classId;
  String? id;
  String? parentId;
  String? className;
  String? sectionId;
  String? section;
  String? admissionNo;
  String? rollNo;
  String? admissionDate;
  String? firstname;
  String? middlename;
  String? lastname;
  String? image;
  String? mobileno;
  String? email;
  String? state;
  String? city;
  String? pincode;
  String? religion;
  String? dob;
  String? currentAddress;
  String? permanentAddress;
  String? categoryId;
  String? category;
  String? adharNo;
  String? samagraId;
  String? bankAccountNo;
  String? bankName;
  String? ifscCode;
  String? fatherName;
  String? guardianName;
  String? guardianRelation;
  String? guardianEmail;
  String? guardianPhone;
  String? guardianAddress;
  String? isActive;
  String? createdAt;
  String? updatedAt;
  String? gender;
  String? rte;
  String? appKey;
  String? parentAppKey;
  String? sessionId;
  String? fullname;

  Data({this.classId, this.id, this.parentId, this.className, this.sectionId, this.section, this.admissionNo, this.rollNo, this.admissionDate, this.firstname, this.middlename, this.lastname, this.image, this.mobileno, this.email, this.state, this.city, this.pincode, this.religion, this.dob, this.currentAddress, this.permanentAddress, this.categoryId, this.category, this.adharNo, this.samagraId, this.bankAccountNo, this.bankName, this.ifscCode, this.fatherName, this.guardianName, this.guardianRelation, this.guardianEmail, this.guardianPhone, this.guardianAddress, this.isActive, this.createdAt, this.updatedAt, this.gender, this.rte, this.appKey, this.parentAppKey, this.sessionId, this.fullname});

  Data.fromJson(Map<String, dynamic> json) {
  classId = json['class_id'];
  id = json['id'];
  parentId = json['parent_id'];
  className = json['class'];
  sectionId = json['section_id'];
  section = json['section'];
  admissionNo = json['admission_no'];
  rollNo = json['roll_no'];
  admissionDate = json['admission_date'];
  firstname = json['firstname'];
  middlename = json['middlename'];
  lastname = json['lastname'];
  image = json['image'];
  mobileno = json['mobileno'];
  email = json['email'];
  state = json['state'];
  city = json['city'];
  pincode = json['pincode'];
  religion = json['religion'];
  dob = json['dob'];
  currentAddress = json['current_address'];
  permanentAddress = json['permanent_address'];
  categoryId = json['category_id'];
  category = json['category'];
  adharNo = json['adhar_no'];
  samagraId = json['samagra_id'];
  bankAccountNo = json['bank_account_no'];
  bankName = json['bank_name'];
  ifscCode = json['ifsc_code'];
  fatherName = json['father_name'];
  guardianName = json['guardian_name'];
  guardianRelation = json['guardian_relation'];
  guardianEmail = json['guardian_email'];
  guardianPhone = json['guardian_phone'];
  guardianAddress = json['guardian_address'];
  isActive = json['is_active'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];
  gender = json['gender'];
  rte = json['rte'];
  appKey = json['app_key'];
  parentAppKey = json['parent_app_key'];
  sessionId = json['session_id'];
  fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['class_id'] = this.classId;
  data['id'] = this.id;
  data['parent_id'] = this.parentId;
  data['class'] = this.className;
  data['section_id'] = this.sectionId;
  data['section'] = this.section;
  data['admission_no'] = this.admissionNo;
  data['roll_no'] = this.rollNo;
  data['admission_date'] = this.admissionDate;
  data['firstname'] = this.firstname;
  data['middlename'] = this.middlename;
  data['lastname'] = this.lastname;
  data['image'] = this.image;
  data['mobileno'] = this.mobileno;
  data['email'] = this.email;
  data['state'] = this.state;
  data['city'] = this.city;
  data['pincode'] = this.pincode;
  data['religion'] = this.religion;
  data['dob'] = this.dob;
  data['current_address'] = this.currentAddress;
  data['permanent_address'] = this.permanentAddress;
  data['category_id'] = this.categoryId;
  data['category'] = this.category;
  data['adhar_no'] = this.adharNo;
  data['samagra_id'] = this.samagraId;
  data['bank_account_no'] = this.bankAccountNo;
  data['bank_name'] = this.bankName;
  data['ifsc_code'] = this.ifscCode;
  data['father_name'] = this.fatherName;
  data['guardian_name'] = this.guardianName;
  data['guardian_relation'] = this.guardianRelation;
  data['guardian_email'] = this.guardianEmail;
  data['guardian_phone'] = this.guardianPhone;
  data['guardian_address'] = this.guardianAddress;
  data['is_active'] = this.isActive;
  data['created_at'] = this.createdAt;
  data['updated_at'] = this.updatedAt;
  data['gender'] = this.gender;
  data['rte'] = this.rte;
  data['app_key'] = this.appKey;
  data['parent_app_key'] = this.parentAppKey;
  data['session_id'] = this.sessionId;
  data['fullname'] = this.fullname;
  return data;
  }
}
