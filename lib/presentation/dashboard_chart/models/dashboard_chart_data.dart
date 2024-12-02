class DashboardChartData {
  String? status;
  String? error;
  Data? data;

  DashboardChartData({this.status, this.error, this.data});

  DashboardChartData.fromJson(Map<String, dynamic> json) {
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
  String? roleId;
  List<Notifications>? notifications;
  MysqlVersion? mysqlVersion;
  SqlMode? sqlMode;
  int? monthCollection;
  String? totalStudents;
  Roles? roles;
  List<String>? yearlyCollection;
  List<int>? yearlyExpense;
  List<String>? totalMonth;
  List<String>? currentMonthDays;
  List<String>? daysCollection;
  List<String>? daysExpense;
  List<String>? studentFeeHistory;
  List<String>? eventColors;
  String? role;
  List<Null>? feesAwaiting;
  List<Null>? incomegraph;
  List<Null>? expensegraph;
  int? monthExpense;
  FeesOverview? feesOverview;
  EnquiryOverview? enquiryOverview;
  int? totalPaid;
  int? totalFees;
  int? fessprogressbar;
  String? totalEnquiry;
  String? totalComplete;
  int? fenquiryprogressbar;
  BookOverview? bookOverview;
  AttendenceData? attendenceData;
  int? staffattendenceData;
  int? getTotalStaffData;
  int? percentTotalStaffData;
  SchSetting? schSetting;

  Data(
      {this.roleId,
        this.notifications,
        this.mysqlVersion,
        this.sqlMode,
        this.monthCollection,
        this.totalStudents,
        this.roles,
        this.yearlyCollection,
        this.yearlyExpense,
        this.totalMonth,
        this.currentMonthDays,
        this.daysCollection,
        this.daysExpense,
        this.studentFeeHistory,
        this.eventColors,
        this.role,
        this.feesAwaiting,
        this.incomegraph,
        this.expensegraph,
        this.monthExpense,
        this.feesOverview,
        this.enquiryOverview,
        this.totalPaid,
        this.totalFees,
        this.fessprogressbar,
        this.totalEnquiry,
        this.totalComplete,
        this.fenquiryprogressbar,
        this.bookOverview,
        this.attendenceData,
        this.staffattendenceData,
        this.getTotalStaffData,
        this.percentTotalStaffData,
        this.schSetting});

  Data.fromJson(Map<String, dynamic> json) {
    roleId = json['role_id'];
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
    mysqlVersion = json['mysqlVersion'] != null
        ? new MysqlVersion.fromJson(json['mysqlVersion'])
        : null;
    sqlMode =
    json['sqlMode'] != null ? new SqlMode.fromJson(json['sqlMode']) : null;
    monthCollection = json['month_collection'];
    totalStudents = json['total_students'];
    roles = json['roles'] != null ? new Roles.fromJson(json['roles']) : null;
    yearlyCollection = json['yearly_collection'].cast<String>();
    yearlyExpense = json['yearly_expense'].cast<int>();
    totalMonth = json['total_month'].cast<String>();
    currentMonthDays = json['current_month_days'].cast<String>();
    daysCollection = json['days_collection'].cast<String>();
    daysExpense = json['days_expense'].cast<String>();
    if (json['student_fee_history'] != null) {
      //studentFeeHistory = <Null>[];
      json['student_fee_history'].forEach((v) {
       // studentFeeHistory!.add(new Null.fromJson(v));
      });
    }
    eventColors = json['event_colors'].cast<String>();
    role = json['role'];
    if (json['fees_awaiting'] != null) {
     // feesAwaiting = <Null>[];
      json['fees_awaiting'].forEach((v) {
       // feesAwaiting!.add(new Null.fromJson(v));
      });
    }
    if (json['incomegraph'] != null) {
      //incomegraph = <Null>[];
      json['incomegraph'].forEach((v) {
       // incomegraph!.add(new Null.fromJson(v));
      });
    }
    if (json['expensegraph'] != null) {
     // expensegraph = <Null>[];
      json['expensegraph'].forEach((v) {
       // expensegraph!.add(new Null.fromJson(v));
      });
    }
    monthExpense = json['month_expense'];
    feesOverview = json['fees_overview'] != null
        ? new FeesOverview.fromJson(json['fees_overview'])
        : null;
    enquiryOverview = json['enquiry_overview'] != null
        ? new EnquiryOverview.fromJson(json['enquiry_overview'])
        : null;
    totalPaid = json['total_paid'];
    totalFees = json['total_fees'];
    fessprogressbar = json['fessprogressbar'];
    totalEnquiry = json['total_enquiry'];
    totalComplete = json['total_complete'];
    fenquiryprogressbar = json['fenquiryprogressbar'];
    bookOverview = json['book_overview'] != null
        ? new BookOverview.fromJson(json['book_overview'])
        : null;
    attendenceData = json['attendence_data'] != null
        ? new AttendenceData.fromJson(json['attendence_data'])
        : null;
    staffattendenceData = json['Staffattendence_data'];
    getTotalStaffData = json['getTotalStaff_data'];
    percentTotalStaffData = json['percentTotalStaff_data'];
    schSetting = json['sch_setting'] != null
        ? new SchSetting.fromJson(json['sch_setting'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role_id'] = this.roleId;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    if (this.mysqlVersion != null) {
      data['mysqlVersion'] = this.mysqlVersion!.toJson();
    }
    if (this.sqlMode != null) {
      data['sqlMode'] = this.sqlMode!.toJson();
    }
    data['month_collection'] = this.monthCollection;
    data['total_students'] = this.totalStudents;
    if (this.roles != null) {
      data['roles'] = this.roles!.toJson();
    }
    data['yearly_collection'] = this.yearlyCollection;
    data['yearly_expense'] = this.yearlyExpense;
    data['total_month'] = this.totalMonth;
    data['current_month_days'] = this.currentMonthDays;
    data['days_collection'] = this.daysCollection;
    data['days_expense'] = this.daysExpense;
    if (this.studentFeeHistory != null) {
      // data['student_fee_history'] =
      //     this.studentFeeHistory!.map((v) => v.toJson()).toList();
    }
    data['event_colors'] = this.eventColors;
    data['role'] = this.role;
    if (this.feesAwaiting != null) {
      // data['fees_awaiting'] =
      //     this.feesAwaiting!.map((v) => v.toJson()).toList();
    }
    if (this.incomegraph != null) {
      // data['incomegraph'] = this.incomegraph!.map((v) => v.toJson()).toList();
    }
    if (this.expensegraph != null) {
      // data['expensegraph'] = this.expensegraph!.map((v) => v.toJson()).toList();
    }
    data['month_expense'] = this.monthExpense;
    if (this.feesOverview != null) {
      data['fees_overview'] = this.feesOverview!.toJson();
    }
    if (this.enquiryOverview != null) {
      data['enquiry_overview'] = this.enquiryOverview!.toJson();
    }
    data['total_paid'] = this.totalPaid;
    data['total_fees'] = this.totalFees;
    data['fessprogressbar'] = this.fessprogressbar;
    data['total_enquiry'] = this.totalEnquiry;
    data['total_complete'] = this.totalComplete;
    data['fenquiryprogressbar'] = this.fenquiryprogressbar;
    if (this.bookOverview != null) {
      data['book_overview'] = this.bookOverview!.toJson();
    }
    if (this.attendenceData != null) {
      data['attendence_data'] = this.attendenceData!.toJson();
    }
    data['Staffattendence_data'] = this.staffattendenceData;
    data['getTotalStaff_data'] = this.getTotalStaffData;
    data['percentTotalStaff_data'] = this.percentTotalStaffData;
    if (this.schSetting != null) {
      data['sch_setting'] = this.schSetting!.toJson();
    }
    return data;
  }
}

class Notifications {
  String? id;
  String? title;
  String? publishDate;
  String? date;
  Null? attachment;
  String? message;
  String? visibleStudent;
  String? visibleStaff;
  String? visibleParent;
  String? createdBy;
  String? createdId;
  String? isActive;
  String? createdAt;
  Null? updatedAt;

  Notifications(
      {this.id,
        this.title,
        this.publishDate,
        this.date,
        this.attachment,
        this.message,
        this.visibleStudent,
        this.visibleStaff,
        this.visibleParent,
        this.createdBy,
        this.createdId,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    publishDate = json['publish_date'];
    date = json['date'];
    attachment = json['attachment'];
    message = json['message'];
    visibleStudent = json['visible_student'];
    visibleStaff = json['visible_staff'];
    visibleParent = json['visible_parent'];
    createdBy = json['created_by'];
    createdId = json['created_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['publish_date'] = this.publishDate;
    data['date'] = this.date;
    data['attachment'] = this.attachment;
    data['message'] = this.message;
    data['visible_student'] = this.visibleStudent;
    data['visible_staff'] = this.visibleStaff;
    data['visible_parent'] = this.visibleParent;
    data['created_by'] = this.createdBy;
    data['created_id'] = this.createdId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class MysqlVersion {
  String? version;

  MysqlVersion({this.version});

  MysqlVersion.fromJson(Map<String, dynamic> json) {
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    return data;
  }
}

class SqlMode {
  String? mode;

  SqlMode({this.mode});

  SqlMode.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    return data;
  }
}

class Roles {
  int? admin;
  int? teacher;
  int? accountant;
  int? librarian;
  int? receptionist;
  int? superAdmin;

  Roles(
      {this.admin,
        this.teacher,
        this.accountant,
        this.librarian,
        this.receptionist,
        this.superAdmin});

  Roles.fromJson(Map<String, dynamic> json) {
    admin = json['Admin'];
    teacher = json['Teacher'];
    accountant = json['Accountant'];
    librarian = json['Librarian'];
    receptionist = json['Receptionist'];
    superAdmin = json['Super Admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Admin'] = this.admin;
    data['Teacher'] = this.teacher;
    data['Accountant'] = this.accountant;
    data['Librarian'] = this.librarian;
    data['Receptionist'] = this.receptionist;
    data['Super Admin'] = this.superAdmin;
    return data;
  }
}

class FeesOverview {
  int? totalUnpaid;
  int? unpaidProgress;
  int? totalPaid;
  int? paidProgress;
  int? totalPartial;
  int? partialProgress;

  FeesOverview(
      {this.totalUnpaid,
        this.unpaidProgress,
        this.totalPaid,
        this.paidProgress,
        this.totalPartial,
        this.partialProgress});

  FeesOverview.fromJson(Map<String, dynamic> json) {
    totalUnpaid = json['total_unpaid'];
    unpaidProgress = json['unpaid_progress'];
    totalPaid = json['total_paid'];
    paidProgress = json['paid_progress'];
    totalPartial = json['total_partial'];
    partialProgress = json['partial_progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_unpaid'] = this.totalUnpaid;
    data['unpaid_progress'] = this.unpaidProgress;
    data['total_paid'] = this.totalPaid;
    data['paid_progress'] = this.paidProgress;
    data['total_partial'] = this.totalPartial;
    data['partial_progress'] = this.partialProgress;
    return data;
  }
}

class EnquiryOverview {
  String? won;
  int? wonProgress;
  String? active;
  int? activeProgress;
  String? passive;
  int? passiveProgress;
  String? dead;
  int? deadProgress;
  String? lost;
  int? lostProgress;

  EnquiryOverview(
      {this.won,
        this.wonProgress,
        this.active,
        this.activeProgress,
        this.passive,
        this.passiveProgress,
        this.dead,
        this.deadProgress,
        this.lost,
        this.lostProgress});

  EnquiryOverview.fromJson(Map<String, dynamic> json) {
    won = json['won'];
    wonProgress = json['won_progress'];
    active = json['active'];
    activeProgress = json['active_progress'];
    passive = json['passive'];
    passiveProgress = json['passive_progress'];
    dead = json['dead'];
    deadProgress = json['dead_progress'];
    lost = json['lost'];
    lostProgress = json['lost_progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['won'] = this.won;
    data['won_progress'] = this.wonProgress;
    data['active'] = this.active;
    data['active_progress'] = this.activeProgress;
    data['passive'] = this.passive;
    data['passive_progress'] = this.passiveProgress;
    data['dead'] = this.dead;
    data['dead_progress'] = this.deadProgress;
    data['lost'] = this.lost;
    data['lost_progress'] = this.lostProgress;
    return data;
  }
}

class BookOverview {
  Null? total;
  int? totalProgress;
  String? availble;
  int? availbleProgress;
  Null? totalIssued;
  int? issuedProgress;
  String? dueforreturn;
  String? forreturn;

  BookOverview(
      {this.total,
        this.totalProgress,
        this.availble,
        this.availbleProgress,
        this.totalIssued,
        this.issuedProgress,
        this.dueforreturn,
        this.forreturn});

  BookOverview.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalProgress = json['total_progress'];
    availble = json['availble'];
    availbleProgress = json['availble_progress'];
    totalIssued = json['total_issued'];
    issuedProgress = json['issued_progress'];
    dueforreturn = json['dueforreturn'];
    forreturn = json['forreturn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['total_progress'] = this.totalProgress;
    data['availble'] = this.availble;
    data['availble_progress'] = this.availbleProgress;
    data['total_issued'] = this.totalIssued;
    data['issued_progress'] = this.issuedProgress;
    data['dueforreturn'] = this.dueforreturn;
    data['forreturn'] = this.forreturn;
    return data;
  }
}

class AttendenceData {
  Null? present;
  Null? late;
  Null? absent;
  Null? halfDay;
  Null? totalPresent;
  Null? totalLate;
  Null? totalAbsent;
  Null? totalHalfDay;

  AttendenceData(
      {this.present,
        this.late,
        this.absent,
        this.halfDay,
        this.totalPresent,
        this.totalLate,
        this.totalAbsent,
        this.totalHalfDay});

  AttendenceData.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    late = json['late'];
    absent = json['absent'];
    halfDay = json['half_day'];
    totalPresent = json['total_present'];
    totalLate = json['total_late'];
    totalAbsent = json['total_absent'];
    totalHalfDay = json['total_half_day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['present'] = this.present;
    data['late'] = this.late;
    data['absent'] = this.absent;
    data['half_day'] = this.halfDay;
    data['total_present'] = this.totalPresent;
    data['total_late'] = this.totalLate;
    data['total_absent'] = this.totalAbsent;
    data['total_half_day'] = this.totalHalfDay;
    return data;
  }
}

class SchSetting {
  String? id;
  String? attendenceType;
  String? langId;
  String? isRtl;
  String? feeDueDays;
  String? classTeacher;
  String? cronSecretKey;
  String? timezone;
  String? name;
  String? email;
  String? biometric;
  String? biometricDevice;
  String? phone;
  String? admPrefix;
  String? admStartFrom;
  String? language;
  String? admNoDigit;
  String? admUpdateStatus;
  String? admAutoInsert;
  String? staffidPrefix;
  String? staffidStartFrom;
  String? staffidAutoInsert;
  String? staffidNoDigit;
  String? staffidUpdateStatus;
  String? address;
  String? diseCode;
  String? dateFormat;
  String? currency;
  String? currencyPlace;
  String? currencySymbol;
  String? startMonth;
  String? sessionId;
  String? image;
  String? theme;
  String? session;
  String? onlineAdmission;
  String? isDuplicateFeesInvoice;
  String? isStudentHouse;
  String? isBloodGroup;
  String? rollNo;
  String? middlename;
  String? lastname;
  String? category;
  String? cast;
  String? religion;
  String? mobileNo;
  String? studentEmail;
  String? admissionDate;
  String? studentPhoto;
  String? studentHeight;
  String? studentWeight;
  String? measurementDate;
  String? fatherName;
  String? fatherPhone;
  String? fatherOccupation;
  String? fatherPic;
  String? motherName;
  String? motherPhone;
  String? motherOccupation;
  String? motherPic;
  String? guardianRelation;
  String? guardianEmail;
  String? guardianPic;
  String? guardianAddress;
  String? currentAddress;
  String? permanentAddress;
  String? routeList;
  String? hostelId;
  String? bankAccountNo;
  String? nationalIdentificationNo;
  String? localIdentificationNo;
  String? rte;
  String? previousSchoolDetails;
  String? studentNote;
  String? uploadDocuments;
  String? staffDesignation;
  String? staffDepartment;
  String? staffLastName;
  String? staffFatherName;
  String? staffMotherName;
  String? staffDateOfJoining;
  String? staffPhone;
  String? staffEmergencyContact;
  String? staffMaritalStatus;
  String? staffPhoto;
  String? staffCurrentAddress;
  String? staffPermanentAddress;
  String? staffQualification;
  String? staffWorkExperience;
  String? staffNote;
  String? staffEpfNo;
  String? staffBasicSalary;
  String? staffContractType;
  String? staffWorkShift;
  String? staffWorkLocation;
  String? staffLeaves;
  String? staffAccountDetails;
  String? staffSocialMedia;
  String? staffUploadDocuments;
  String? adminLogo;
  String? adminSmallLogo;
  String? mobileApiUrl;
  String? appPrimaryColorCode;
  String? appSecondaryColorCode;
  String? appLogo;
  String? languageCode;
  String? studentProfileEdit;
  String? currencyFormat;
  String? studentPanelLogin;
  String? parentPanelLogin;
  String? maintenanceMode;
  String? studentTimeline;
  String? isOfflineFeePayment;
  String? offlineBankPaymentInstruction;
  String? parentLogin;

  SchSetting(
      {this.id,
        this.attendenceType,
        this.langId,
        this.isRtl,
        this.feeDueDays,
        this.classTeacher,
        this.cronSecretKey,
        this.timezone,
        this.name,
        this.email,
        this.biometric,
        this.biometricDevice,
        this.phone,
        this.admPrefix,
        this.admStartFrom,
        this.language,
        this.admNoDigit,
        this.admUpdateStatus,
        this.admAutoInsert,
        this.staffidPrefix,
        this.staffidStartFrom,
        this.staffidAutoInsert,
        this.staffidNoDigit,
        this.staffidUpdateStatus,
        this.address,
        this.diseCode,
        this.dateFormat,
        this.currency,
        this.currencyPlace,
        this.currencySymbol,
        this.startMonth,
        this.sessionId,
        this.image,
        this.theme,
        this.session,
        this.onlineAdmission,
        this.isDuplicateFeesInvoice,
        this.isStudentHouse,
        this.isBloodGroup,
        this.rollNo,
        this.middlename,
        this.lastname,
        this.category,
        this.cast,
        this.religion,
        this.mobileNo,
        this.studentEmail,
        this.admissionDate,
        this.studentPhoto,
        this.studentHeight,
        this.studentWeight,
        this.measurementDate,
        this.fatherName,
        this.fatherPhone,
        this.fatherOccupation,
        this.fatherPic,
        this.motherName,
        this.motherPhone,
        this.motherOccupation,
        this.motherPic,
        this.guardianRelation,
        this.guardianEmail,
        this.guardianPic,
        this.guardianAddress,
        this.currentAddress,
        this.permanentAddress,
        this.routeList,
        this.hostelId,
        this.bankAccountNo,
        this.nationalIdentificationNo,
        this.localIdentificationNo,
        this.rte,
        this.previousSchoolDetails,
        this.studentNote,
        this.uploadDocuments,
        this.staffDesignation,
        this.staffDepartment,
        this.staffLastName,
        this.staffFatherName,
        this.staffMotherName,
        this.staffDateOfJoining,
        this.staffPhone,
        this.staffEmergencyContact,
        this.staffMaritalStatus,
        this.staffPhoto,
        this.staffCurrentAddress,
        this.staffPermanentAddress,
        this.staffQualification,
        this.staffWorkExperience,
        this.staffNote,
        this.staffEpfNo,
        this.staffBasicSalary,
        this.staffContractType,
        this.staffWorkShift,
        this.staffWorkLocation,
        this.staffLeaves,
        this.staffAccountDetails,
        this.staffSocialMedia,
        this.staffUploadDocuments,
        this.adminLogo,
        this.adminSmallLogo,
        this.mobileApiUrl,
        this.appPrimaryColorCode,
        this.appSecondaryColorCode,
        this.appLogo,
        this.languageCode,
        this.studentProfileEdit,
        this.currencyFormat,
        this.studentPanelLogin,
        this.parentPanelLogin,
        this.maintenanceMode,
        this.studentTimeline,
        this.isOfflineFeePayment,
        this.offlineBankPaymentInstruction,
        this.parentLogin});

  SchSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attendenceType = json['attendence_type'];
    langId = json['lang_id'];
    isRtl = json['is_rtl'];
    feeDueDays = json['fee_due_days'];
    classTeacher = json['class_teacher'];
    cronSecretKey = json['cron_secret_key'];
    timezone = json['timezone'];
    name = json['name'];
    email = json['email'];
    biometric = json['biometric'];
    biometricDevice = json['biometric_device'];
    phone = json['phone'];
    admPrefix = json['adm_prefix'];
    admStartFrom = json['adm_start_from'];
    language = json['language'];
    admNoDigit = json['adm_no_digit'];
    admUpdateStatus = json['adm_update_status'];
    admAutoInsert = json['adm_auto_insert'];
    staffidPrefix = json['staffid_prefix'];
    staffidStartFrom = json['staffid_start_from'];
    staffidAutoInsert = json['staffid_auto_insert'];
    staffidNoDigit = json['staffid_no_digit'];
    staffidUpdateStatus = json['staffid_update_status'];
    address = json['address'];
    diseCode = json['dise_code'];
    dateFormat = json['date_format'];
    currency = json['currency'];
    currencyPlace = json['currency_place'];
    currencySymbol = json['currency_symbol'];
    startMonth = json['start_month'];
    sessionId = json['session_id'];
    image = json['image'];
    theme = json['theme'];
    session = json['session'];
    onlineAdmission = json['online_admission'];
    isDuplicateFeesInvoice = json['is_duplicate_fees_invoice'];
    isStudentHouse = json['is_student_house'];
    isBloodGroup = json['is_blood_group'];
    rollNo = json['roll_no'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    category = json['category'];
    cast = json['cast'];
    religion = json['religion'];
    mobileNo = json['mobile_no'];
    studentEmail = json['student_email'];
    admissionDate = json['admission_date'];
    studentPhoto = json['student_photo'];
    studentHeight = json['student_height'];
    studentWeight = json['student_weight'];
    measurementDate = json['measurement_date'];
    fatherName = json['father_name'];
    fatherPhone = json['father_phone'];
    fatherOccupation = json['father_occupation'];
    fatherPic = json['father_pic'];
    motherName = json['mother_name'];
    motherPhone = json['mother_phone'];
    motherOccupation = json['mother_occupation'];
    motherPic = json['mother_pic'];
    guardianRelation = json['guardian_relation'];
    guardianEmail = json['guardian_email'];
    guardianPic = json['guardian_pic'];
    guardianAddress = json['guardian_address'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    routeList = json['route_list'];
    hostelId = json['hostel_id'];
    bankAccountNo = json['bank_account_no'];
    nationalIdentificationNo = json['national_identification_no'];
    localIdentificationNo = json['local_identification_no'];
    rte = json['rte'];
    previousSchoolDetails = json['previous_school_details'];
    studentNote = json['student_note'];
    uploadDocuments = json['upload_documents'];
    staffDesignation = json['staff_designation'];
    staffDepartment = json['staff_department'];
    staffLastName = json['staff_last_name'];
    staffFatherName = json['staff_father_name'];
    staffMotherName = json['staff_mother_name'];
    staffDateOfJoining = json['staff_date_of_joining'];
    staffPhone = json['staff_phone'];
    staffEmergencyContact = json['staff_emergency_contact'];
    staffMaritalStatus = json['staff_marital_status'];
    staffPhoto = json['staff_photo'];
    staffCurrentAddress = json['staff_current_address'];
    staffPermanentAddress = json['staff_permanent_address'];
    staffQualification = json['staff_qualification'];
    staffWorkExperience = json['staff_work_experience'];
    staffNote = json['staff_note'];
    staffEpfNo = json['staff_epf_no'];
    staffBasicSalary = json['staff_basic_salary'];
    staffContractType = json['staff_contract_type'];
    staffWorkShift = json['staff_work_shift'];
    staffWorkLocation = json['staff_work_location'];
    staffLeaves = json['staff_leaves'];
    staffAccountDetails = json['staff_account_details'];
    staffSocialMedia = json['staff_social_media'];
    staffUploadDocuments = json['staff_upload_documents'];
    adminLogo = json['admin_logo'];
    adminSmallLogo = json['admin_small_logo'];
    mobileApiUrl = json['mobile_api_url'];
    appPrimaryColorCode = json['app_primary_color_code'];
    appSecondaryColorCode = json['app_secondary_color_code'];
    appLogo = json['app_logo'];
    languageCode = json['language_code'];
    studentProfileEdit = json['student_profile_edit'];
    currencyFormat = json['currency_format'];
    studentPanelLogin = json['student_panel_login'];
    parentPanelLogin = json['parent_panel_login'];
    maintenanceMode = json['maintenance_mode'];
    studentTimeline = json['student_timeline'];
    isOfflineFeePayment = json['is_offline_fee_payment'];
    offlineBankPaymentInstruction = json['offline_bank_payment_instruction'];
    parentLogin = json['parent_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attendence_type'] = this.attendenceType;
    data['lang_id'] = this.langId;
    data['is_rtl'] = this.isRtl;
    data['fee_due_days'] = this.feeDueDays;
    data['class_teacher'] = this.classTeacher;
    data['cron_secret_key'] = this.cronSecretKey;
    data['timezone'] = this.timezone;
    data['name'] = this.name;
    data['email'] = this.email;
    data['biometric'] = this.biometric;
    data['biometric_device'] = this.biometricDevice;
    data['phone'] = this.phone;
    data['adm_prefix'] = this.admPrefix;
    data['adm_start_from'] = this.admStartFrom;
    data['language'] = this.language;
    data['adm_no_digit'] = this.admNoDigit;
    data['adm_update_status'] = this.admUpdateStatus;
    data['adm_auto_insert'] = this.admAutoInsert;
    data['staffid_prefix'] = this.staffidPrefix;
    data['staffid_start_from'] = this.staffidStartFrom;
    data['staffid_auto_insert'] = this.staffidAutoInsert;
    data['staffid_no_digit'] = this.staffidNoDigit;
    data['staffid_update_status'] = this.staffidUpdateStatus;
    data['address'] = this.address;
    data['dise_code'] = this.diseCode;
    data['date_format'] = this.dateFormat;
    data['currency'] = this.currency;
    data['currency_place'] = this.currencyPlace;
    data['currency_symbol'] = this.currencySymbol;
    data['start_month'] = this.startMonth;
    data['session_id'] = this.sessionId;
    data['image'] = this.image;
    data['theme'] = this.theme;
    data['session'] = this.session;
    data['online_admission'] = this.onlineAdmission;
    data['is_duplicate_fees_invoice'] = this.isDuplicateFeesInvoice;
    data['is_student_house'] = this.isStudentHouse;
    data['is_blood_group'] = this.isBloodGroup;
    data['roll_no'] = this.rollNo;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['category'] = this.category;
    data['cast'] = this.cast;
    data['religion'] = this.religion;
    data['mobile_no'] = this.mobileNo;
    data['student_email'] = this.studentEmail;
    data['admission_date'] = this.admissionDate;
    data['student_photo'] = this.studentPhoto;
    data['student_height'] = this.studentHeight;
    data['student_weight'] = this.studentWeight;
    data['measurement_date'] = this.measurementDate;
    data['father_name'] = this.fatherName;
    data['father_phone'] = this.fatherPhone;
    data['father_occupation'] = this.fatherOccupation;
    data['father_pic'] = this.fatherPic;
    data['mother_name'] = this.motherName;
    data['mother_phone'] = this.motherPhone;
    data['mother_occupation'] = this.motherOccupation;
    data['mother_pic'] = this.motherPic;
    data['guardian_relation'] = this.guardianRelation;
    data['guardian_email'] = this.guardianEmail;
    data['guardian_pic'] = this.guardianPic;
    data['guardian_address'] = this.guardianAddress;
    data['current_address'] = this.currentAddress;
    data['permanent_address'] = this.permanentAddress;
    data['route_list'] = this.routeList;
    data['hostel_id'] = this.hostelId;
    data['bank_account_no'] = this.bankAccountNo;
    data['national_identification_no'] = this.nationalIdentificationNo;
    data['local_identification_no'] = this.localIdentificationNo;
    data['rte'] = this.rte;
    data['previous_school_details'] = this.previousSchoolDetails;
    data['student_note'] = this.studentNote;
    data['upload_documents'] = this.uploadDocuments;
    data['staff_designation'] = this.staffDesignation;
    data['staff_department'] = this.staffDepartment;
    data['staff_last_name'] = this.staffLastName;
    data['staff_father_name'] = this.staffFatherName;
    data['staff_mother_name'] = this.staffMotherName;
    data['staff_date_of_joining'] = this.staffDateOfJoining;
    data['staff_phone'] = this.staffPhone;
    data['staff_emergency_contact'] = this.staffEmergencyContact;
    data['staff_marital_status'] = this.staffMaritalStatus;
    data['staff_photo'] = this.staffPhoto;
    data['staff_current_address'] = this.staffCurrentAddress;
    data['staff_permanent_address'] = this.staffPermanentAddress;
    data['staff_qualification'] = this.staffQualification;
    data['staff_work_experience'] = this.staffWorkExperience;
    data['staff_note'] = this.staffNote;
    data['staff_epf_no'] = this.staffEpfNo;
    data['staff_basic_salary'] = this.staffBasicSalary;
    data['staff_contract_type'] = this.staffContractType;
    data['staff_work_shift'] = this.staffWorkShift;
    data['staff_work_location'] = this.staffWorkLocation;
    data['staff_leaves'] = this.staffLeaves;
    data['staff_account_details'] = this.staffAccountDetails;
    data['staff_social_media'] = this.staffSocialMedia;
    data['staff_upload_documents'] = this.staffUploadDocuments;
    data['admin_logo'] = this.adminLogo;
    data['admin_small_logo'] = this.adminSmallLogo;
    data['mobile_api_url'] = this.mobileApiUrl;
    data['app_primary_color_code'] = this.appPrimaryColorCode;
    data['app_secondary_color_code'] = this.appSecondaryColorCode;
    data['app_logo'] = this.appLogo;
    data['language_code'] = this.languageCode;
    data['student_profile_edit'] = this.studentProfileEdit;
    data['currency_format'] = this.currencyFormat;
    data['student_panel_login'] = this.studentPanelLogin;
    data['parent_panel_login'] = this.parentPanelLogin;
    data['maintenance_mode'] = this.maintenanceMode;
    data['student_timeline'] = this.studentTimeline;
    data['is_offline_fee_payment'] = this.isOfflineFeePayment;
    data['offline_bank_payment_instruction'] =
        this.offlineBankPaymentInstruction;
    data['parent_login'] = this.parentLogin;
    return data;
  }
}
