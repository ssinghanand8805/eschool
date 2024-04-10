class UsersData {
  int? status;
  String? message;
  String? id;
  String? token;
  String? role;
  Record? record;

  UsersData(
      {this.status, this.message, this.id, this.token, this.role, this.record});

  UsersData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    id = json['id'];
    token = json['token'];
    role = json['role'];
    record =
    json['record'] != null ? new Record.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['id'] = this.id;
    data['token'] = this.token;
    data['role'] = this.role;
    if (this.record != null) {
      data['record'] = this.record!.toJson();
    }
    return data;
  }
}

class Record {
  String? id;
  String? studentId;
  String? admissionNo;
  String? role;
  String? mobileno;
  String? email;
  String? username;
  String? className;
  String? section;
  String? dateFormat;
  String? currencySymbol;
  String? currencyShortName;
  String? currencyId;
  String? timezone;
  String? schName;
  Language? language;
  String? isRtl;
  String? theme;
  Null? image;
  String? studentSessionId;
  String? startWeek;
  String? superadminRestriction;

  Record(
      {this.id,
        this.studentId,
        this.admissionNo,
        this.role,
        this.mobileno,
        this.email,
        this.username,
        this.className,
        this.section,
        this.dateFormat,
        this.currencySymbol,
        this.currencyShortName,
        this.currencyId,
        this.timezone,
        this.schName,
        this.language,
        this.isRtl,
        this.theme,
        this.image,
        this.studentSessionId,
        this.startWeek,
        this.superadminRestriction});

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    admissionNo = json['admission_no'];
    role = json['role'];
    mobileno = json['mobileno'];
    email = json['email'];
    username = json['username'];
    className = json['className'];
    section = json['section'];
    dateFormat = json['date_format'];
    currencySymbol = json['currency_symbol'];
    currencyShortName = json['currency_short_name'];
    currencyId = json['currency_id'];
    timezone = json['timezone'];
    schName = json['sch_name'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    isRtl = json['is_rtl'];
    theme = json['theme'];
    image = json['image'];
    studentSessionId = json['student_session_id'];
    startWeek = json['start_week'];
    superadminRestriction = json['superadmin_restriction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_id'] = this.studentId;
    data['admission_no'] = this.admissionNo;
    data['role'] = this.role;
    data['mobileno'] = this.mobileno;
    data['email'] = this.email;
    data['username'] = this.username;
    data['className'] = this.className;
    data['section'] = this.section;
    data['date_format'] = this.dateFormat;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_short_name'] = this.currencyShortName;
    data['currency_id'] = this.currencyId;
    data['timezone'] = this.timezone;
    data['sch_name'] = this.schName;
    if (this.language != null) {
      data['language'] = this.language!.toJson();
    }
    data['is_rtl'] = this.isRtl;
    data['theme'] = this.theme;
    data['image'] = this.image;
    data['student_session_id'] = this.studentSessionId;
    data['start_week'] = this.startWeek;
    data['superadmin_restriction'] = this.superadminRestriction;
    return data;
  }
}

class Language {
  String? langId;
  String? language;
  String? shortCode;

  Language({this.langId, this.language, this.shortCode});

  Language.fromJson(Map<String, dynamic> json) {
    langId = json['lang_id'];
    language = json['language'];
    shortCode = json['short_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang_id'] = this.langId;
    data['language'] = this.language;
    data['short_code'] = this.shortCode;
    return data;
  }
}
