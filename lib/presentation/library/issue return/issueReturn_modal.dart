class LibraryMemberList {
  int? status;
  String? error;
  Data? data;

  LibraryMemberList({this.status, this.error, this.data});

  LibraryMemberList.fromJson(Map<String, dynamic> json) {
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
  List<MemberList>? memberList;

  Data({this.memberList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['memberList'] != null) {
      memberList = <MemberList>[];
      json['memberList'].forEach((v) {
        memberList!.add(new MemberList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.memberList != null) {
      data['memberList'] = this.memberList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MemberList {
  String? libMemberId;
  String? libraryCardNo;
  String? memberType;
  String? admissionNo;
  String? firstname;
  String? lastname;
  String? guardianPhone;
  String? teacherName;
  String? teacherEmail;
  String? teacherSex;
  String? teacherPhone;
  String? middlename;
  String? staffId;
  String? stuId;
  String? empId;

  MemberList(
      {this.libMemberId,
        this.libraryCardNo,
        this.memberType,
        this.admissionNo,
        this.firstname,
        this.lastname,
        this.guardianPhone,
        this.teacherName,
        this.teacherEmail,
        this.teacherSex,
        this.teacherPhone,
        this.middlename,
        this.staffId,
        this.stuId,
        this.empId});

  MemberList.fromJson(Map<String, dynamic> json) {
    libMemberId = json['lib_member_id'];
    libraryCardNo = json['library_card_no'];
    memberType = json['member_type'];
    admissionNo = json['admission_no'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    guardianPhone = json['guardian_phone'];
    teacherName = json['teacher_name'];
    teacherEmail = json['teacher_email'];
    teacherSex = json['teacher_sex'];
    teacherPhone = json['teacher_phone'];
    middlename = json['middlename'];
    staffId = json['staff_id'];
    stuId = json['stu_id'];
    empId = json['emp_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lib_member_id'] = this.libMemberId;
    data['library_card_no'] = this.libraryCardNo;
    data['member_type'] = this.memberType;
    data['admission_no'] = this.admissionNo;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['guardian_phone'] = this.guardianPhone;
    data['teacher_name'] = this.teacherName;
    data['teacher_email'] = this.teacherEmail;
    data['teacher_sex'] = this.teacherSex;
    data['teacher_phone'] = this.teacherPhone;
    data['middlename'] = this.middlename;
    data['staff_id'] = this.staffId;
    data['stu_id'] = this.stuId;
    data['emp_id'] = this.empId;
    return data;
  }
}



