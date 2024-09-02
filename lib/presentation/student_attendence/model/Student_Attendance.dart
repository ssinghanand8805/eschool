class StudentAttendence {
  List<Attendencetypeslist>? attendencetypeslist;
  List<Resultlist>? resultlist;

  StudentAttendence({this.attendencetypeslist, this.resultlist});

  StudentAttendence.fromJson(Map<String, dynamic> json) {
    if (json['attendencetypeslist'] != null) {
      attendencetypeslist = <Attendencetypeslist>[];
      json['attendencetypeslist'].forEach((v) {
        attendencetypeslist!.add(new Attendencetypeslist.fromJson(v));
      });
    }
    if (json['resultlist'] != null) {
      resultlist = <Resultlist>[];
      json['resultlist'].forEach((v) {
        resultlist!.add(new Resultlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attendencetypeslist != null) {
      data['attendencetypeslist'] =
          this.attendencetypeslist!.map((v) => v.toJson()).toList();
    }
    if (this.resultlist != null) {
      data['resultlist'] = this.resultlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendencetypeslist {
  String? id;
  String? type;
  String? keyValue;
  String? longLangName;
  String? longNameStyle;
  String? isActive;
  String? forQrAttendance;
  String? createdAt;
  String? updatedAt;

  Attendencetypeslist(
      {this.id,
        this.type,
        this.keyValue,
        this.longLangName,
        this.longNameStyle,
        this.isActive,
        this.forQrAttendance,
        this.createdAt,
        this.updatedAt});

  Attendencetypeslist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    keyValue = json['key_value'];
    longLangName = json['long_lang_name'];
    longNameStyle = json['long_name_style'];
    isActive = json['is_active'];
    forQrAttendance = json['for_qr_attendance'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['key_value'] = this.keyValue;
    data['long_lang_name'] = this.longLangName;
    data['long_name_style'] = this.longNameStyle;
    data['is_active'] = this.isActive;
    data['for_qr_attendance'] = this.forQrAttendance;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Resultlist {
  String? attendenceId;
  String? attendenceDt;
  String? firstname;
  Null? middlename;
  String? lastname;
  String? date;
  String? remark;
  String? biometricAttendence;
  String? qrcodeAttendance;
  Null? biometricDeviceData;
  Null? userAgent;
  String? rollNo;
  String? admissionNo;
  String? stdId;
  String? attendenceTypeId;
  String? studentSessionId;
  String? attType;
  String? key;
  String? longLangName;
  String? longNameStyle;

  Resultlist(
      {this.attendenceId,
        this.attendenceDt,
        this.firstname,
        this.middlename,
        this.lastname,
        this.date,
        this.remark,
        this.biometricAttendence,
        this.qrcodeAttendance,
        this.biometricDeviceData,
        this.userAgent,
        this.rollNo,
        this.admissionNo,
        this.stdId,
        this.attendenceTypeId,
        this.studentSessionId,
        this.attType,
        this.key,
        this.longLangName,
        this.longNameStyle});

  Resultlist.fromJson(Map<String, dynamic> json) {
    attendenceId = json['attendence_id'];
    attendenceDt = json['attendence_dt'];
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    date = json['date'];
    remark = json['remark'];
    biometricAttendence = json['biometric_attendence'];
    qrcodeAttendance = json['qrcode_attendance'];
    biometricDeviceData = json['biometric_device_data'];
    userAgent = json['user_agent'];
    rollNo = json['roll_no'];
    admissionNo = json['admission_no'];
    stdId = json['std_id'];
    attendenceTypeId = json['attendence_type_id'];
    studentSessionId = json['student_session_id'];
    attType = json['att_type'];
    key = json['key'];
    longLangName = json['long_lang_name'];
    longNameStyle = json['long_name_style'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendence_id'] = this.attendenceId;
    data['attendence_dt'] = this.attendenceDt;
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['date'] = this.date;
    data['remark'] = this.remark;
    data['biometric_attendence'] = this.biometricAttendence;
    data['qrcode_attendance'] = this.qrcodeAttendance;
    data['biometric_device_data'] = this.biometricDeviceData;
    data['user_agent'] = this.userAgent;
    data['roll_no'] = this.rollNo;
    data['admission_no'] = this.admissionNo;
    data['std_id'] = this.stdId;
    data['attendence_type_id'] = this.attendenceTypeId;
    data['student_session_id'] = this.studentSessionId;
    data['att_type'] = this.attType;
    data['key'] = this.key;
    data['long_lang_name'] = this.longLangName;
    data['long_name_style'] = this.longNameStyle;
    return data;
  }
}



class StudentAttendenceModel {
  String? studentSession;
  String? attendendenceId;
  String? attendencetype;
  String? remark;

  StudentAttendenceModel(
      {this.studentSession,
        this.attendendenceId,
        this.attendencetype,
        this.remark});

  StudentAttendenceModel.fromJson(Map<String, dynamic> json) {
    studentSession = json['student_session'];
    attendendenceId = json['attendendence_id'];
    attendencetype = json['attendencetype'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_session'] = this.studentSession;
    data['attendendence_id'] = this.attendendenceId;
    data['attendencetype'] = this.attendencetype;
    data['remark'] = this.remark;
    return data;
  }

}