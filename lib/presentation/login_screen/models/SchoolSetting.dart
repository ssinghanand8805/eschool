class SchoolSetting {
  String? lastname;
  String? middlename;
  String? id;
  String? langId;
  String? languages;
  String? classTeacher;
  String? cronSecretKey;
  String? timezone;
  String? superadminRestriction;
  String? studentTimeline;
  String? name;
  String? email;
  String? biometric;
  String? biometricDevice;
  String? timeFormat;
  String? phone;
  String? language;
  String? attendenceType;
  String? address;
  String? diseCode;
  String? dateFormat;
  String? currency;
  String? currencyPlace;
  String? startMonth;
  String? startWeek;
  String? sessionId;
  String? feeDueDays;
  String? image;
  String? theme;
  String? session;
  String? onlineAdmission;
  String? isDuplicateFeesInvoice;
  String? isStudentHouse;
  String? isBloodGroup;
  String? adminLogo;
  String? adminSmallLogo;
  String? mobileApiUrl;
  String? appPrimaryColorCode;
  String? appSecondaryColorCode;
  String? appLogo;
  String? studentProfileEdit;
  String? staffBarcode;
  String? studentBarcode;
  String? isRtl;
  String? studentPanelLogin;
  String? parentPanelLogin;
  String? currencyFormat;
  String? examResult;
  String? baseUrl;
  String? folderPath;
  String? currencySymbol;
  String? basePrice;
  String? onlineAdmissionApplicationForm;
  String? currencyId;
  String? adminLoginPageBackground;
  String? userLoginPageBackground;
  String? lowAttendanceLimit;
  CurrentSession? currentSession;

  SchoolSetting(
      {this.lastname,
        this.middlename,
        this.id,
        this.langId,
        this.languages,
        this.classTeacher,
        this.cronSecretKey,
        this.timezone,
        this.superadminRestriction,
        this.studentTimeline,
        this.name,
        this.email,
        this.biometric,
        this.biometricDevice,
        this.timeFormat,
        this.phone,
        this.language,
        this.attendenceType,
        this.address,
        this.diseCode,
        this.dateFormat,
        this.currency,
        this.currencyPlace,
        this.startMonth,
        this.startWeek,
        this.sessionId,
        this.feeDueDays,
        this.image,
        this.theme,
        this.session,
        this.onlineAdmission,
        this.isDuplicateFeesInvoice,
        this.isStudentHouse,
        this.isBloodGroup,
        this.adminLogo,
        this.adminSmallLogo,
        this.mobileApiUrl,
        this.appPrimaryColorCode,
        this.appSecondaryColorCode,
        this.appLogo,
        this.studentProfileEdit,
        this.staffBarcode,
        this.studentBarcode,
        this.isRtl,
        this.studentPanelLogin,
        this.parentPanelLogin,
        this.currencyFormat,
        this.examResult,
        this.baseUrl,
        this.folderPath,
        this.currencySymbol,
        this.basePrice,
        this.onlineAdmissionApplicationForm,
        this.currencyId,
        this.adminLoginPageBackground,
        this.userLoginPageBackground,
        this.lowAttendanceLimit,
        this.currentSession});

  SchoolSetting.fromJson(Map<String, dynamic> json) {
    lastname = json['lastname'];
    middlename = json['middlename'];
    id = json['id'];
    langId = json['lang_id'];
    languages = json['languages'];
    classTeacher = json['class_teacher'];
    cronSecretKey = json['cron_secret_key'];
    timezone = json['timezone'];
    superadminRestriction = json['superadmin_restriction'];
    studentTimeline = json['student_timeline'];
    name = json['name'];
    email = json['email'];
    biometric = json['biometric'];
    biometricDevice = json['biometric_device'];
    timeFormat = json['time_format'];
    phone = json['phone'];
    language = json['language'];
    attendenceType = json['attendence_type'];
    address = json['address'];
    diseCode = json['dise_code'];
    dateFormat = json['date_format'];
    currency = json['currency'];
    currencyPlace = json['currency_place'];
    startMonth = json['start_month'];
    startWeek = json['start_week'];
    sessionId = json['session_id'];
    feeDueDays = json['fee_due_days'];
    image = json['image'];
    theme = json['theme'];
    session = json['session'];
    onlineAdmission = json['online_admission'];
    isDuplicateFeesInvoice = json['is_duplicate_fees_invoice'];
    isStudentHouse = json['is_student_house'];
    isBloodGroup = json['is_blood_group'];
    adminLogo = json['admin_logo'];
    adminSmallLogo = json['admin_small_logo'];
    mobileApiUrl = json['mobile_api_url'];
    appPrimaryColorCode = json['app_primary_color_code'];
    appSecondaryColorCode = json['app_secondary_color_code'];
    appLogo = json['app_logo'];
    studentProfileEdit = json['student_profile_edit'];
    staffBarcode = json['staff_barcode'];
    studentBarcode = json['student_barcode'];
    isRtl = json['is_rtl'];
    studentPanelLogin = json['student_panel_login'];
    parentPanelLogin = json['parent_panel_login'];
    currencyFormat = json['currency_format'];
    examResult = json['exam_result'];
    baseUrl = json['base_url'];
    folderPath = json['folder_path'];
    currencySymbol = json['currency_symbol'];
    basePrice = json['base_price'];
    onlineAdmissionApplicationForm = json['online_admission_application_form'];
    currencyId = json['currency_id'];
    adminLoginPageBackground = json['admin_login_page_background'];
    userLoginPageBackground = json['user_login_page_background'];
    lowAttendanceLimit = json['low_attendance_limit'];
    currentSession = json['current_session'] != null
        ? new CurrentSession.fromJson(json['current_session'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastname'] = this.lastname;
    data['middlename'] = this.middlename;
    data['id'] = this.id;
    data['lang_id'] = this.langId;
    data['languages'] = this.languages;
    data['class_teacher'] = this.classTeacher;
    data['cron_secret_key'] = this.cronSecretKey;
    data['timezone'] = this.timezone;
    data['superadmin_restriction'] = this.superadminRestriction;
    data['student_timeline'] = this.studentTimeline;
    data['name'] = this.name;
    data['email'] = this.email;
    data['biometric'] = this.biometric;
    data['biometric_device'] = this.biometricDevice;
    data['time_format'] = this.timeFormat;
    data['phone'] = this.phone;
    data['language'] = this.language;
    data['attendence_type'] = this.attendenceType;
    data['address'] = this.address;
    data['dise_code'] = this.diseCode;
    data['date_format'] = this.dateFormat;
    data['currency'] = this.currency;
    data['currency_place'] = this.currencyPlace;
    data['start_month'] = this.startMonth;
    data['start_week'] = this.startWeek;
    data['session_id'] = this.sessionId;
    data['fee_due_days'] = this.feeDueDays;
    data['image'] = this.image;
    data['theme'] = this.theme;
    data['session'] = this.session;
    data['online_admission'] = this.onlineAdmission;
    data['is_duplicate_fees_invoice'] = this.isDuplicateFeesInvoice;
    data['is_student_house'] = this.isStudentHouse;
    data['is_blood_group'] = this.isBloodGroup;
    data['admin_logo'] = this.adminLogo;
    data['admin_small_logo'] = this.adminSmallLogo;
    data['mobile_api_url'] = this.mobileApiUrl;
    data['app_primary_color_code'] = this.appPrimaryColorCode;
    data['app_secondary_color_code'] = this.appSecondaryColorCode;
    data['app_logo'] = this.appLogo;
    data['student_profile_edit'] = this.studentProfileEdit;
    data['staff_barcode'] = this.staffBarcode;
    data['student_barcode'] = this.studentBarcode;
    data['is_rtl'] = this.isRtl;
    data['student_panel_login'] = this.studentPanelLogin;
    data['parent_panel_login'] = this.parentPanelLogin;
    data['currency_format'] = this.currencyFormat;
    data['exam_result'] = this.examResult;
    data['base_url'] = this.baseUrl;
    data['folder_path'] = this.folderPath;
    data['currency_symbol'] = this.currencySymbol;
    data['base_price'] = this.basePrice;
    data['online_admission_application_form'] =
        this.onlineAdmissionApplicationForm;
    data['currency_id'] = this.currencyId;
    data['admin_login_page_background'] = this.adminLoginPageBackground;
    data['user_login_page_background'] = this.userLoginPageBackground;
    data['low_attendance_limit'] = this.lowAttendanceLimit;
    if (this.currentSession != null) {
      data['current_session'] = this.currentSession!.toJson();
    }
    return data;
  }
}

class CurrentSession {
  String? sessionId;
  String? session;

  CurrentSession({this.sessionId, this.session});

  CurrentSession.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    session = json['session'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_id'] = this.sessionId;
    data['session'] = this.session;
    return data;
  }
}
