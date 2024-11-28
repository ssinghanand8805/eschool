class PromoteStudent {
  int? status;
  String? error;
  Data? data;

  PromoteStudent({this.status, this.error, this.data});

  PromoteStudent.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'].toString();
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
  String? classPost;
  String? sectionPost;
  String? classPromotedPost;
  String? sectionPromotedPost;
  String? sessionPromotedPost;
  List<Resultlist>? resultlist;

  Data({this.classPost, this.sectionPost, this.classPromotedPost, this.sectionPromotedPost, this.sessionPromotedPost, this.resultlist});

  Data.fromJson(Map<String, dynamic> json) {
    classPost = json['class_post'];
    sectionPost = json['section_post'];
    classPromotedPost = json['class_promoted_post'];
    sectionPromotedPost = json['section_promoted_post'];
    sessionPromotedPost = json['session_promoted_post'];
    if (json['resultlist'] != null) {
      resultlist = <Resultlist>[];
      json['resultlist'].forEach((v) { resultlist!.add(new Resultlist.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_post'] = this.classPost;
    data['section_post'] = this.sectionPost;
    data['class_promoted_post'] = this.classPromotedPost;
    data['section_promoted_post'] = this.sectionPromotedPost;
    data['session_promoted_post'] = this.sessionPromotedPost;
    if (this.resultlist != null) {
      data['resultlist'] = this.resultlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Resultlist {
  String? promotedStudentId;
  String? classId;
  String? studentSessionId;
  String? id;
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
  String? guardianName;
  String? guardianRelation;
  String? guardianPhone;
  String? guardianAddress;
  String? isActive;
  String? createdAt;
  String? updatedAt;
  String? fatherName;
  String? rte;
  String? gender;

  Resultlist({this.promotedStudentId, this.classId, this.studentSessionId, this.id, this.className, this.sectionId, this.section, this.admissionNo, this.rollNo, this.admissionDate, this.firstname, this.middlename, this.lastname, this.image, this.mobileno, this.email, this.state, this.city, this.pincode, this.religion, this.dob, this.currentAddress, this.permanentAddress, this.categoryId, this.category, this.adharNo, this.samagraId, this.bankAccountNo, this.bankName, this.ifscCode, this.guardianName, this.guardianRelation, this.guardianPhone, this.guardianAddress, this.isActive, this.createdAt, this.updatedAt, this.fatherName, this.rte, this.gender});

  Resultlist.fromJson(Map<String, dynamic> json) {
  promotedStudentId = json['promoted_student_id'];
  classId = json['class_id'];
  studentSessionId = json['student_session_id'];
  id = json['id'];
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
  guardianName = json['guardian_name'];
  guardianRelation = json['guardian_relation'];
  guardianPhone = json['guardian_phone'];
  guardianAddress = json['guardian_address'];
  isActive = json['is_active'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];
  fatherName = json['father_name'];
  rte = json['rte'];
  gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['promoted_student_id'] = this.promotedStudentId;
  data['class_id'] = this.classId;
  data['student_session_id'] = this.studentSessionId;
  data['id'] = this.id;
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
  data['guardian_name'] = this.guardianName;
  data['guardian_relation'] = this.guardianRelation;
  data['guardian_phone'] = this.guardianPhone;
  data['guardian_address'] = this.guardianAddress;
  data['is_active'] = this.isActive;
  data['created_at'] = this.createdAt;
  data['updated_at'] = this.updatedAt;
  data['father_name'] = this.fatherName;
  data['rte'] = this.rte;
  data['gender'] = this.gender;
  return data;
  }
}
