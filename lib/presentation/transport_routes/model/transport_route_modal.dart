class TransportRoutesModal {
  List<PickupPoint>? pickupPoint;
  RouteData? route;

  TransportRoutesModal({this.pickupPoint, this.route});

  TransportRoutesModal.fromJson(Map<String, dynamic> json) {
    if (json['pickup_point'] != null) {
      pickupPoint = <PickupPoint>[];
      json['pickup_point'].forEach((v) {
        pickupPoint!.add(new PickupPoint.fromJson(v));
      });
    }
    route = json['route'] != null ? new RouteData.fromJson(json['route']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pickupPoint != null) {
      data['pickup_point'] = this.pickupPoint!.map((v) => v.toJson()).toList();
    }
    if (this.route != null) {
      data['route'] = this.route!.toJson();
    }
    return data;
  }
}

class PickupPoint {
  String? id;
  String? transportRouteId;
  String? pickupPointId;
  String? fees;
  String? destinationDistance;
  String? pickupTime;
  String? orderNumber;
  String? createdAt;
  String? pickupPoint;
  String? routeTitle;

  PickupPoint(
      {this.id,
        this.transportRouteId,
        this.pickupPointId,
        this.fees,
        this.destinationDistance,
        this.pickupTime,
        this.orderNumber,
        this.createdAt,
        this.pickupPoint,
        this.routeTitle});

  PickupPoint.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transportRouteId = json['transport_route_id'];
    pickupPointId = json['pickup_point_id'];
    fees = json['fees'];
    destinationDistance = json['destination_distance'];
    pickupTime = json['pickup_time'];
    orderNumber = json['order_number'];
    createdAt = json['created_at'];
    pickupPoint = json['pickup_point'];
    routeTitle = json['route_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transport_route_id'] = this.transportRouteId;
    data['pickup_point_id'] = this.pickupPointId;
    data['fees'] = this.fees;
    data['destination_distance'] = this.destinationDistance;
    data['pickup_time'] = this.pickupTime;
    data['order_number'] = this.orderNumber;
    data['created_at'] = this.createdAt;
    data['pickup_point'] = this.pickupPoint;
    data['route_title'] = this.routeTitle;
    return data;
  }
}

class RouteData {
  String? pickupPointName;
  String? routePickupPointId;
  String? transportFees;
  String? appKey;
  String? parentAppKey;
  String? vehrouteId;
  String? routeId;
  String? vehicleId;
  String? routeTitle;
  String? vehicleNo;
  String? roomNo;
  String? driverName;
  String? driverContact;
  String? vehicleModel;
  String? manufactureYear;
  String? driverLicence;
  String? vehiclePhoto;
  String? hostelId;
  String? hostelName;
  String? roomTypeId;
  String? roomType;
  String? hostelRoomId;
  String? studentSessionId;
  String? feesDiscount;
  String? classId;
  String? className;
  String? sectionId;
  String? section;
  String? id;
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
  String? note;
  String? religion;
  String? cast;
  String? houseName;
  String? dob;
  String? currentAddress;
  String? previousSchool;
  String? guardianIs;
  String? parentId;
  String? permanentAddress;
  String? categoryId;
  String? category;
  String? adharNo;
  String? samagraId;
  String? bankAccountNo;
  String? bankName;
  String? ifscCode;
  String? guardianName;
  String? fatherPic;
  String? height;
  String? weight;
  String? measurementDate;
  String? motherPic;
  String? guardianPic;
  String? guardianRelation;
  String? guardianPhone;
  String? guardianAddress;
  String? isActive;
  String? createdAt;
  String? updatedAt;
  String? fatherName;
  String? fatherPhone;
  String? bloodGroup;
  String? schoolHouseId;
  String? fatherOccupation;
  String? motherName;
  String? motherPhone;
  String? motherOccupation;
  String? guardianOccupation;
  String? gender;
  String? rte;
  String? guardianEmail;
  String? username;
  String? password;
  String? disReason;
  String? disNote;
  String? disableAt;
  String? currencyName;
  String? symbol;
  String? basePrice;
  String? currencyId;
  String? sessionId;
  String? session;

  RouteData(
      {this.pickupPointName,
        this.routePickupPointId,
        this.transportFees,
        this.appKey,
        this.parentAppKey,
        this.vehrouteId,
        this.routeId,
        this.vehicleId,
        this.routeTitle,
        this.vehicleNo,
        this.roomNo,
        this.driverName,
        this.driverContact,
        this.vehicleModel,
        this.manufactureYear,
        this.driverLicence,
        this.vehiclePhoto,
        this.hostelId,
        this.hostelName,
        this.roomTypeId,
        this.roomType,
        this.hostelRoomId,
        this.studentSessionId,
        this.feesDiscount,
        this.classId,
        this.className,
        this.sectionId,
        this.section,
        this.id,
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
        this.note,
        this.religion,
        this.cast,
        this.houseName,
        this.dob,
        this.currentAddress,
        this.previousSchool,
        this.guardianIs,
        this.parentId,
        this.permanentAddress,
        this.categoryId,
        this.category,
        this.adharNo,
        this.samagraId,
        this.bankAccountNo,
        this.bankName,
        this.ifscCode,
        this.guardianName,
        this.fatherPic,
        this.height,
        this.weight,
        this.measurementDate,
        this.motherPic,
        this.guardianPic,
        this.guardianRelation,
        this.guardianPhone,
        this.guardianAddress,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.fatherName,
        this.fatherPhone,
        this.bloodGroup,
        this.schoolHouseId,
        this.fatherOccupation,
        this.motherName,
        this.motherPhone,
        this.motherOccupation,
        this.guardianOccupation,
        this.gender,
        this.rte,
        this.guardianEmail,
        this.username,
        this.password,
        this.disReason,
        this.disNote,
        this.disableAt,
        this.currencyName,
        this.symbol,
        this.basePrice,
        this.currencyId,
        this.sessionId,
        this.session});

  RouteData.fromJson(Map<String, dynamic> json) {
    pickupPointName = json['pickup_point_name'];
    routePickupPointId = json['route_pickup_point_id'];
    transportFees = json['transport_fees'];
    appKey = json['app_key'];
    parentAppKey = json['parent_app_key'];
    vehrouteId = json['vehroute_id'];
    routeId = json['route_id'];
    vehicleId = json['vehicle_id'];
    routeTitle = json['route_title'];
    vehicleNo = json['vehicle_no'];
    roomNo = json['room_no'];
    driverName = json['driver_name'];
    driverContact = json['driver_contact'];
    vehicleModel = json['vehicle_model'];
    manufactureYear = json['manufacture_year'];
    driverLicence = json['driver_licence'];
    vehiclePhoto = json['vehicle_photo'];
    hostelId = json['hostel_id'];
    hostelName = json['hostel_name'];
    roomTypeId = json['room_type_id'];
    roomType = json['room_type'];
    hostelRoomId = json['hostel_room_id'];
    studentSessionId = json['student_session_id'];
    feesDiscount = json['fees_discount'];
    classId = json['class_id'];
    className = json['className'];
    sectionId = json['section_id'];
    section = json['section'];
    id = json['id'];
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
    note = json['note'];
    religion = json['religion'];
    cast = json['cast'];
    houseName = json['house_name'];
    dob = json['dob'];
    currentAddress = json['current_address'];
    previousSchool = json['previous_school'];
    guardianIs = json['guardian_is'];
    parentId = json['parent_id'];
    permanentAddress = json['permanent_address'];
    categoryId = json['category_id'];
    category = json['category'];
    adharNo = json['adhar_no'];
    samagraId = json['samagra_id'];
    bankAccountNo = json['bank_account_no'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    guardianName = json['guardian_name'];
    fatherPic = json['father_pic'];
    height = json['height'];
    weight = json['weight'];
    measurementDate = json['measurement_date'];
    motherPic = json['mother_pic'];
    guardianPic = json['guardian_pic'];
    guardianRelation = json['guardian_relation'];
    guardianPhone = json['guardian_phone'];
    guardianAddress = json['guardian_address'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fatherName = json['father_name'];
    fatherPhone = json['father_phone'];
    bloodGroup = json['blood_group'];
    schoolHouseId = json['school_house_id'];
    fatherOccupation = json['father_occupation'];
    motherName = json['mother_name'];
    motherPhone = json['mother_phone'];
    motherOccupation = json['mother_occupation'];
    guardianOccupation = json['guardian_occupation'];
    gender = json['gender'];
    rte = json['rte'];
    guardianEmail = json['guardian_email'];
    username = json['username'];
    password = json['password'];
    disReason = json['dis_reason'];
    disNote = json['dis_note'];
    disableAt = json['disable_at'];
    currencyName = json['currency_name'];
    symbol = json['symbol'];
    basePrice = json['base_price'];
    currencyId = json['currency_id'];
    sessionId = json['session_id'];
    session = json['session'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pickup_point_name'] = this.pickupPointName;
    data['route_pickup_point_id'] = this.routePickupPointId;
    data['transport_fees'] = this.transportFees;
    data['app_key'] = this.appKey;
    data['parent_app_key'] = this.parentAppKey;
    data['vehroute_id'] = this.vehrouteId;
    data['route_id'] = this.routeId;
    data['vehicle_id'] = this.vehicleId;
    data['route_title'] = this.routeTitle;
    data['vehicle_no'] = this.vehicleNo;
    data['room_no'] = this.roomNo;
    data['driver_name'] = this.driverName;
    data['driver_contact'] = this.driverContact;
    data['vehicle_model'] = this.vehicleModel;
    data['manufacture_year'] = this.manufactureYear;
    data['driver_licence'] = this.driverLicence;
    data['vehicle_photo'] = this.vehiclePhoto;
    data['hostel_id'] = this.hostelId;
    data['hostel_name'] = this.hostelName;
    data['room_type_id'] = this.roomTypeId;
    data['room_type'] = this.roomType;
    data['hostel_room_id'] = this.hostelRoomId;
    data['student_session_id'] = this.studentSessionId;
    data['fees_discount'] = this.feesDiscount;
    data['class_id'] = this.classId;
    data['className'] = this.className;
    data['section_id'] = this.sectionId;
    data['section'] = this.section;
    data['id'] = this.id;
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
    data['note'] = this.note;
    data['religion'] = this.religion;
    data['cast'] = this.cast;
    data['house_name'] = this.houseName;
    data['dob'] = this.dob;
    data['current_address'] = this.currentAddress;
    data['previous_school'] = this.previousSchool;
    data['guardian_is'] = this.guardianIs;
    data['parent_id'] = this.parentId;
    data['permanent_address'] = this.permanentAddress;
    data['category_id'] = this.categoryId;
    data['category'] = this.category;
    data['adhar_no'] = this.adharNo;
    data['samagra_id'] = this.samagraId;
    data['bank_account_no'] = this.bankAccountNo;
    data['bank_name'] = this.bankName;
    data['ifsc_code'] = this.ifscCode;
    data['guardian_name'] = this.guardianName;
    data['father_pic'] = this.fatherPic;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['measurement_date'] = this.measurementDate;
    data['mother_pic'] = this.motherPic;
    data['guardian_pic'] = this.guardianPic;
    data['guardian_relation'] = this.guardianRelation;
    data['guardian_phone'] = this.guardianPhone;
    data['guardian_address'] = this.guardianAddress;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['father_name'] = this.fatherName;
    data['father_phone'] = this.fatherPhone;
    data['blood_group'] = this.bloodGroup;
    data['school_house_id'] = this.schoolHouseId;
    data['father_occupation'] = this.fatherOccupation;
    data['mother_name'] = this.motherName;
    data['mother_phone'] = this.motherPhone;
    data['mother_occupation'] = this.motherOccupation;
    data['guardian_occupation'] = this.guardianOccupation;
    data['gender'] = this.gender;
    data['rte'] = this.rte;
    data['guardian_email'] = this.guardianEmail;
    data['username'] = this.username;
    data['password'] = this.password;
    data['dis_reason'] = this.disReason;
    data['dis_note'] = this.disNote;
    data['disable_at'] = this.disableAt;
    data['currency_name'] = this.currencyName;
    data['symbol'] = this.symbol;
    data['base_price'] = this.basePrice;
    data['currency_id'] = this.currencyId;
    data['session_id'] = this.sessionId;
    data['session'] = this.session;
    return data;
  }
}
