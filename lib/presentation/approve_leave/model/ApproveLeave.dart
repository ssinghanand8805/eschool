class ApproveLeave {
  List<Resultlist>? resultlist;

  ApproveLeave({ this.resultlist});

  ApproveLeave.fromJson(Map<String, dynamic> json) {

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
class EditApproveLeave {
  List<StudentList>? studentList;
  Resultlist? resultlist;

  EditApproveLeave({this.studentList, this.resultlist});

  EditApproveLeave.fromJson(Map<String, dynamic> json) {
    Resultlist result = Resultlist(
      id: '',
      studentSessionId: '',
      fromDate: '',
      toDate: '',
      applyDate: '',
      status: '',
      docs: '',
      reason: '',
      approveBy: '',
      approveDate: '',
      requestType: '',
      createdAt: '',
      applyLeaveStatus: '',
      firstname: '',
      middlename: '',
      lastname: '',
      staffId: '',
      staffName: '',
      studId: '',
      admissionNo: '',
      surname: '',
      classId: '',
      sectionId: '',
      className: '',
      section: '',
    );
    if (json['studentList'] != null) {
      studentList = <StudentList>[];
      json['studentList'].forEach((v) {
        studentList!.add(new StudentList.fromJson(v));
      });
    }
    if (json['resultlist'] != null) {
      resultlist = result;
      // json['resultlist'].forEach((v) {
        resultlist = Resultlist.fromJson(json['resultlist']);
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.studentList != null) {
      data['studentList'] = this.studentList!.map((v) => v.toJson()).toList();
    }
    if (this.resultlist != null) {
      data['resultlist'] = this.resultlist!.toJson();
    }
    return data;
  }
}




class StudentList {
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
  String? appKey;
  String? parentAppKey;
  String? rte;
  String? gender;
  String? vehicleNo;
  String? routeTitle;
  String? routePickupPointId;
  String? pickupPoint;

  StudentList(
      {this.classId,
        this.studentSessionId,
        this.id,
        this.className,
        this.sectionId,
        this.section,
        this.admissionNo,
        this.rollNo,
        this.admissionDate,
        this.firstname,
        this.middlename,
        this.lastname,
        this.image,
        this.mobileno,
        this.email,
        this.state,
        this.city,
        this.pincode,
        this.religion,
        this.dob,
        this.currentAddress,
        this.permanentAddress,
        this.categoryId,
        this.category,
        this.adharNo,
        this.samagraId,
        this.bankAccountNo,
        this.bankName,
        this.ifscCode,
        this.guardianName,
        this.guardianRelation,
        this.guardianPhone,
        this.guardianAddress,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.fatherName,
        this.appKey,
        this.parentAppKey,
        this.rte,
        this.gender,
        this.vehicleNo,
        this.routeTitle,
        this.routePickupPointId,
        this.pickupPoint});

  StudentList.fromJson(Map<String, dynamic> json) {
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
    appKey = json['app_key'];
    parentAppKey = json['parent_app_key'];
    rte = json['rte'];
    gender = json['gender'];
    vehicleNo = json['vehicle_no'];
    routeTitle = json['route_title'];
    routePickupPointId = json['route_pickup_point_id'];
    pickupPoint = json['pickup_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['app_key'] = this.appKey;
    data['parent_app_key'] = this.parentAppKey;
    data['rte'] = this.rte;
    data['gender'] = this.gender;
    data['vehicle_no'] = this.vehicleNo;
    data['route_title'] = this.routeTitle;
    data['route_pickup_point_id'] = this.routePickupPointId;
    data['pickup_point'] = this.pickupPoint;
    return data;
  }
}

class Resultlist {
  String? id;
  String? studentSessionId;
  String? fromDate;
  String? toDate;
  String? applyDate;
  String? status;
  String? docs;
  String? reason;
  String? approveBy;
  String? approveDate;
  String? requestType;
  String? createdAt;
  String? applyLeaveStatus;
  String? firstname;
  String? middlename;
  String? lastname;
  String? staffId;
  String? staffName;
  String? studId;
  String? admissionNo;
  String? surname;
  String? classId;
  String? sectionId;
  String? className;
  String? section;

  Resultlist(
      {this.id,
        this.studentSessionId,
        this.fromDate,
        this.toDate,
        this.applyDate,
        this.status,
        this.docs,
        this.reason,
        this.approveBy,
        this.approveDate,
        this.requestType,
        this.createdAt,
        this.applyLeaveStatus,
        this.firstname,
        this.middlename,
        this.lastname,
        this.staffId,
        this.staffName,
        this.studId,
        this.admissionNo,
        this.surname,
        this.classId,
        this.sectionId,
        this.className,
        this.section});

  Resultlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentSessionId = json['student_session_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    applyDate = json['apply_date'];
    status = json['status'];
    docs = json['docs'];
    reason = json['reason'];
    approveBy = json['approve_by'];
    approveDate = json['approve_date'];
    requestType = json['request_type'];
    createdAt = json['created_at'];
    applyLeaveStatus = json['apply_leave_status'];
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    studId = json['stud_id'];
    admissionNo = json['admission_no'];
    surname = json['surname'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    className = json['class'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_session_id'] = this.studentSessionId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['apply_date'] = this.applyDate;
    data['status'] = this.status;
    data['docs'] = this.docs;
    data['reason'] = this.reason;
    data['approve_by'] = this.approveBy;
    data['approve_date'] = this.approveDate;
    data['request_type'] = this.requestType;
    data['created_at'] = this.createdAt;
    data['apply_leave_status'] = this.applyLeaveStatus;
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    data['stud_id'] = this.studId;
    data['admission_no'] = this.admissionNo;
    data['surname'] = this.surname;
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    data['class'] = this.className;
    data['section'] = this.section;
    return data;
  }
}
