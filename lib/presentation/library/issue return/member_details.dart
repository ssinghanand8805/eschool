class LibraryMemberDetails {
  int? status;
  String? error;
  Data? data;

  LibraryMemberDetails({this.status, this.error, this.data});

  LibraryMemberDetails.fromJson(Map<String, dynamic> json) {
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
  MemberList? memberList;
  List<IssuedBooks>? issuedBooks;

  Data({this.memberList, this.issuedBooks});

  Data.fromJson(Map<String, dynamic> json) {
    memberList = json['memberList'] != null
        ? new MemberList.fromJson(json['memberList'])
        : null;
    if (json['issued_books'] != null) {
      issuedBooks = <IssuedBooks>[];
      json['issued_books'].forEach((v) {
        issuedBooks!.add(new IssuedBooks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.memberList != null) {
      data['memberList'] = this.memberList!.toJson();
    }
    if (this.issuedBooks != null) {
      data['issued_books'] = this.issuedBooks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MemberList {
  String? libMemberId;
  String? libraryCardNo;
  String? memberType;
  String? id;
  String? parentId;
  String? admissionNo;
  String? rollNo;
  String? admissionDate;
  String? firstname;
  String? middlename;
  String? lastname;
  String? rte;
  String? image;
  String? mobileno;
  String? email;
  String? state;
  String? city;
  String? pincode;
  String? religion;
  String? cast;
  String? dob;
  String? gender;
  String? currentAddress;
  String? permanentAddress;
  String? categoryId;
  String? schoolHouseId;
  String? bloodGroup;
  String? hostelRoomId;
  String? adharNo;
  String? samagraId;
  String? bankAccountNo;
  String? bankName;
  String? ifscCode;
  String? guardianIs;
  String? fatherName;
  String? fatherPhone;
  String? fatherOccupation;
  String? motherName;
  String? motherPhone;
  String? motherOccupation;
  String? guardianName;
  String? guardianRelation;
  String? guardianPhone;
  String? guardianOccupation;
  String? guardianAddress;
  String? guardianEmail;
  String? fatherPic;
  String? motherPic;
  String? guardianPic;
  String? isActive;
  String? previousSchool;
  String? height;
  String? weight;
  String? measurementDate;
  String? disReason;
  String? note;
  String? disNote;
  String? appKey;
  String? parentAppKey;
  String? linkedEnquiryId;
  String? disableAt;
  String? createdAt;
  String? updatedAt;
  String? sessionYear;
  String? classId;
  String? sectionId;

  MemberList(
      {this.libMemberId,
        this.libraryCardNo,
        this.memberType,
        this.id,
        this.parentId,
        this.admissionNo,
        this.rollNo,
        this.admissionDate,
        this.firstname,
        this.middlename,
        this.lastname,
        this.rte,
        this.image,
        this.mobileno,
        this.email,
        this.state,
        this.city,
        this.pincode,
        this.religion,
        this.cast,
        this.dob,
        this.gender,
        this.currentAddress,
        this.permanentAddress,
        this.categoryId,
        this.schoolHouseId,
        this.bloodGroup,
        this.hostelRoomId,
        this.adharNo,
        this.samagraId,
        this.bankAccountNo,
        this.bankName,
        this.ifscCode,
        this.guardianIs,
        this.fatherName,
        this.fatherPhone,
        this.fatherOccupation,
        this.motherName,
        this.motherPhone,
        this.motherOccupation,
        this.guardianName,
        this.guardianRelation,
        this.guardianPhone,
        this.guardianOccupation,
        this.guardianAddress,
        this.guardianEmail,
        this.fatherPic,
        this.motherPic,
        this.guardianPic,
        this.isActive,
        this.previousSchool,
        this.height,
        this.weight,
        this.measurementDate,
        this.disReason,
        this.note,
        this.disNote,
        this.appKey,
        this.parentAppKey,
        this.linkedEnquiryId,
        this.disableAt,
        this.createdAt,
        this.updatedAt,
        this.sessionYear,
        this.classId,
        this.sectionId});

  MemberList.fromJson(Map<String, dynamic> json) {
    libMemberId = json['lib_member_id'];
    libraryCardNo = json['library_card_no'];
    memberType = json['member_type'];
    id = json['id'];
    parentId = json['parent_id'];
    admissionNo = json['admission_no'];
    rollNo = json['roll_no'];
    admissionDate = json['admission_date'];
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    rte = json['rte'];
    image = json['image'];
    mobileno = json['mobileno'];
    email = json['email'];
    state = json['state'];
    city = json['city'];
    pincode = json['pincode'];
    religion = json['religion'];
    cast = json['cast'];
    dob = json['dob'];
    gender = json['gender'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    categoryId = json['category_id'];
    schoolHouseId = json['school_house_id'];
    bloodGroup = json['blood_group'];
    hostelRoomId = json['hostel_room_id'];
    adharNo = json['adhar_no'];
    samagraId = json['samagra_id'];
    bankAccountNo = json['bank_account_no'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    guardianIs = json['guardian_is'];
    fatherName = json['father_name'];
    fatherPhone = json['father_phone'];
    fatherOccupation = json['father_occupation'];
    motherName = json['mother_name'];
    motherPhone = json['mother_phone'];
    motherOccupation = json['mother_occupation'];
    guardianName = json['guardian_name'];
    guardianRelation = json['guardian_relation'];
    guardianPhone = json['guardian_phone'];
    guardianOccupation = json['guardian_occupation'];
    guardianAddress = json['guardian_address'];
    guardianEmail = json['guardian_email'];
    fatherPic = json['father_pic'];
    motherPic = json['mother_pic'];
    guardianPic = json['guardian_pic'];
    isActive = json['is_active'];
    previousSchool = json['previous_school'];
    height = json['height'];
    weight = json['weight'];
    measurementDate = json['measurement_date'];
    disReason = json['dis_reason'];
    note = json['note'];
    disNote = json['dis_note'];
    appKey = json['app_key'];
    parentAppKey = json['parent_app_key'];
    linkedEnquiryId = json['linked_enquiry_id'];
    disableAt = json['disable_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sessionYear = json['session_year'];
    classId = json['class_id'];
    sectionId = json['section_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lib_member_id'] = this.libMemberId;
    data['library_card_no'] = this.libraryCardNo;
    data['member_type'] = this.memberType;
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['admission_no'] = this.admissionNo;
    data['roll_no'] = this.rollNo;
    data['admission_date'] = this.admissionDate;
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['rte'] = this.rte;
    data['image'] = this.image;
    data['mobileno'] = this.mobileno;
    data['email'] = this.email;
    data['state'] = this.state;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['religion'] = this.religion;
    data['cast'] = this.cast;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['current_address'] = this.currentAddress;
    data['permanent_address'] = this.permanentAddress;
    data['category_id'] = this.categoryId;
    data['school_house_id'] = this.schoolHouseId;
    data['blood_group'] = this.bloodGroup;
    data['hostel_room_id'] = this.hostelRoomId;
    data['adhar_no'] = this.adharNo;
    data['samagra_id'] = this.samagraId;
    data['bank_account_no'] = this.bankAccountNo;
    data['bank_name'] = this.bankName;
    data['ifsc_code'] = this.ifscCode;
    data['guardian_is'] = this.guardianIs;
    data['father_name'] = this.fatherName;
    data['father_phone'] = this.fatherPhone;
    data['father_occupation'] = this.fatherOccupation;
    data['mother_name'] = this.motherName;
    data['mother_phone'] = this.motherPhone;
    data['mother_occupation'] = this.motherOccupation;
    data['guardian_name'] = this.guardianName;
    data['guardian_relation'] = this.guardianRelation;
    data['guardian_phone'] = this.guardianPhone;
    data['guardian_occupation'] = this.guardianOccupation;
    data['guardian_address'] = this.guardianAddress;
    data['guardian_email'] = this.guardianEmail;
    data['father_pic'] = this.fatherPic;
    data['mother_pic'] = this.motherPic;
    data['guardian_pic'] = this.guardianPic;
    data['is_active'] = this.isActive;
    data['previous_school'] = this.previousSchool;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['measurement_date'] = this.measurementDate;
    data['dis_reason'] = this.disReason;
    data['note'] = this.note;
    data['dis_note'] = this.disNote;
    data['app_key'] = this.appKey;
    data['parent_app_key'] = this.parentAppKey;
    data['linked_enquiry_id'] = this.linkedEnquiryId;
    data['disable_at'] = this.disableAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['session_year'] = this.sessionYear;
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    return data;
  }
}

class IssuedBooks {
  String? id;
  String? returnDate;
  String? duereturnDate;
  String? issueDate;
  String? isReturned;
  String? bookTitle;
  String? bookNo;
  String? author;
  String? extradays;
  int? totalFineAmount;
  int? isFine;

  IssuedBooks(
      {this.id,
        this.returnDate,
        this.duereturnDate,
        this.issueDate,
        this.isReturned,
        this.bookTitle,
        this.bookNo,
        this.author,
        this.extradays,
        this.totalFineAmount,
        this.isFine});

  IssuedBooks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    returnDate = json['return_date'];
    duereturnDate = json['duereturn_date'];
    issueDate = json['issue_date'];
    isReturned = json['is_returned'];
    bookTitle = json['book_title'];
    bookNo = json['book_no'];
    author = json['author'];
    extradays = json['extradays'];
    totalFineAmount = json['totalFineAmount'];
    isFine = json['isFine'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['return_date'] = this.returnDate;
    data['duereturn_date'] = this.duereturnDate;
    data['issue_date'] = this.issueDate;
    data['is_returned'] = this.isReturned;
    data['book_title'] = this.bookTitle;
    data['book_no'] = this.bookNo;
    data['author'] = this.author;
    data['extradays'] = this.extradays;
    data['totalFineAmount'] = this.totalFineAmount;
    data['isFine'] = this.isFine;
    return data;
  }
}
