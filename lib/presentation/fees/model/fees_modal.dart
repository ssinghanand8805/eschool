class FeesDataModal {
  int? payMethod;
  List<StudentDueFee>? studentDueFee;
  List<TransportFees>? transportFees;
  List<StudentDiscountFee>? studentDiscountFee;
  GrandFee? grandFee;

  FeesDataModal(
      {this.payMethod,
        this.studentDueFee,
        this.transportFees,
        this.studentDiscountFee,
        this.grandFee});

  FeesDataModal.fromJson(Map<String, dynamic> json) {
    payMethod = json['pay_method'];
    if (json['student_due_fee'] != null) {
      studentDueFee = <StudentDueFee>[];
      json['student_due_fee'].forEach((v) {
        studentDueFee!.add(new StudentDueFee.fromJson(v));
      });
    }
    if (json['transport_fees'] != null) {
      transportFees = <TransportFees>[];
      json['transport_fees'].forEach((v) {
        transportFees!.add(new TransportFees.fromJson(v));
      });
    }
    if (json['student_discount_fee'] != null) {
      studentDiscountFee = <StudentDiscountFee>[];
      json['student_discount_fee'].forEach((v) {
        studentDiscountFee!.add(new StudentDiscountFee.fromJson(v));
      });
    }
    grandFee = json['grand_fee'] != null
        ? new GrandFee.fromJson(json['grand_fee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pay_method'] = this.payMethod;
    if (this.studentDueFee != null) {
      data['student_due_fee'] =
          this.studentDueFee!.map((v) => v.toJson()).toList();
    }
    if (this.transportFees != null) {
      data['transport_fees'] =
          this.transportFees!.map((v) => v.toJson()).toList();
    }
    if (this.studentDiscountFee != null) {
      data['student_discount_fee'] =
          this.studentDiscountFee!.map((v) => v.toJson()).toList();
    }
    if (this.grandFee != null) {
      data['grand_fee'] = this.grandFee!.toJson();
    }
    return data;
  }
}

class StudentDueFee {
  String? id;
  String? isSystem;
  String? studentSessionId;
  String? feeSessionGroupId;
  String? amount;
  String? isActive;
  String? createdAt;
  String? name;
  List<Fees>? fees;

  StudentDueFee(
      {this.id,
        this.isSystem,
        this.studentSessionId,
        this.feeSessionGroupId,
        this.amount,
        this.isActive,
        this.createdAt,
        this.name,
        this.fees});

  StudentDueFee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isSystem = json['is_system'];
    studentSessionId = json['student_session_id'];
    feeSessionGroupId = json['fee_session_group_id'];
    amount = json['amount'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    name = json['name'];
    if (json['fees'] != null) {
      fees = <Fees>[];
      json['fees'].forEach((v) {
        fees!.add(new Fees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_system'] = this.isSystem;
    data['student_session_id'] = this.studentSessionId;
    data['fee_session_group_id'] = this.feeSessionGroupId;
    data['amount'] = this.amount;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    if (this.fees != null) {
      data['fees'] = this.fees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fees {
  String? id;
  String? isSystem;
  String? studentSessionId;
  String? feeSessionGroupId;
  String? amount;
  String? isActive;
  String? createdAt;
  String? feeGroupsFeetypeId;
  String? fineAmount;
  String? dueDate;
  String? feeGroupsId;
  String? name;
  String? feetypeId;
  String? code;
  String? type;
  String? studentFeesDepositeId;
  String? amountDetail;
  int? totalAmountPaid;
  int? totalAmountDiscount;
  int? totalAmountFine;
  int? totalAmountDisplay;
  String? totalAmountRemaining;
  String? status;
  int? feesFineAmount;

  Fees(
      {this.id,
        this.isSystem,
        this.studentSessionId,
        this.feeSessionGroupId,
        this.amount,
        this.isActive,
        this.createdAt,
        this.feeGroupsFeetypeId,
        this.fineAmount,
        this.dueDate,
        this.feeGroupsId,
        this.name,
        this.feetypeId,
        this.code,
        this.type,
        this.studentFeesDepositeId,
        this.amountDetail,
        this.totalAmountPaid,
        this.totalAmountDiscount,
        this.totalAmountFine,
        this.totalAmountDisplay,
        this.totalAmountRemaining,
        this.status,
        this.feesFineAmount});

  Fees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isSystem = json['is_system'];
    studentSessionId = json['student_session_id'];
    feeSessionGroupId = json['fee_session_group_id'];
    amount = json['amount'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    feeGroupsFeetypeId = json['fee_groups_feetype_id'];
    fineAmount = json['fine_amount'];
    dueDate = json['due_date'];
    feeGroupsId = json['fee_groups_id'];
    name = json['name'];
    feetypeId = json['feetype_id'];
    code = json['code'];
    type = json['type'];
    studentFeesDepositeId = json['student_fees_deposite_id'];
    amountDetail = json['amount_detail'];
    totalAmountPaid = json['total_amount_paid'];
    totalAmountDiscount = json['total_amount_discount'];
    totalAmountFine = json['total_amount_fine'];
    totalAmountDisplay = json['total_amount_display'];
    totalAmountRemaining = json['total_amount_remaining'];
    status = json['status'];
    feesFineAmount = json['fees_fine_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_system'] = this.isSystem;
    data['student_session_id'] = this.studentSessionId;
    data['fee_session_group_id'] = this.feeSessionGroupId;
    data['amount'] = this.amount;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['fee_groups_feetype_id'] = this.feeGroupsFeetypeId;
    data['fine_amount'] = this.fineAmount;
    data['due_date'] = this.dueDate;
    data['fee_groups_id'] = this.feeGroupsId;
    data['name'] = this.name;
    data['feetype_id'] = this.feetypeId;
    data['code'] = this.code;
    data['type'] = this.type;
    data['student_fees_deposite_id'] = this.studentFeesDepositeId;
    data['amount_detail'] = this.amountDetail;
    data['total_amount_paid'] = this.totalAmountPaid;
    data['total_amount_discount'] = this.totalAmountDiscount;
    data['total_amount_fine'] = this.totalAmountFine;
    data['total_amount_display'] = this.totalAmountDisplay;
    data['total_amount_remaining'] = this.totalAmountRemaining;
    data['status'] = this.status;
    data['fees_fine_amount'] = this.feesFineAmount;
    return data;
  }
}

class TransportFees {
  String? id;
  String? transportFeemasterId;
  String? studentSessionId;
  String? routePickupPointId;
  String? generatedBy;
  String? createdAt;
  String? month;
  String? dueDate;
  String? fees;
  String? fineAmount;
  String? fineType;
  String? finePercentage;
  String? studentFeesDepositeId;
  String? amountDetail;
  int? totalAmountPaid;
  int? totalAmountDiscount;
  int? totalAmountFine;
  int? totalAmountDisplay;
  String? totalAmountRemaining;
  String? status;
  int? feesFineAmount;

  TransportFees(
      {this.id,
        this.transportFeemasterId,
        this.studentSessionId,
        this.routePickupPointId,
        this.generatedBy,
        this.createdAt,
        this.month,
        this.dueDate,
        this.fees,
        this.fineAmount,
        this.fineType,
        this.finePercentage,
        this.studentFeesDepositeId,
        this.amountDetail,
        this.totalAmountPaid,
        this.totalAmountDiscount,
        this.totalAmountFine,
        this.totalAmountDisplay,
        this.totalAmountRemaining,
        this.status,
        this.feesFineAmount});

  TransportFees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transportFeemasterId = json['transport_feemaster_id'];
    studentSessionId = json['student_session_id'];
    routePickupPointId = json['route_pickup_point_id'];
    generatedBy = json['generated_by'];
    createdAt = json['created_at'];
    month = json['month'];
    dueDate = json['due_date'];
    fees = json['fees'];
    fineAmount = json['fine_amount'];
    fineType = json['fine_type'];
    finePercentage = json['fine_percentage'];
    studentFeesDepositeId = json['student_fees_deposite_id'];
    amountDetail = json['amount_detail'];
    totalAmountPaid = json['total_amount_paid'];
    totalAmountDiscount = json['total_amount_discount'];
    totalAmountFine = json['total_amount_fine'];
    totalAmountDisplay = json['total_amount_display'];
    totalAmountRemaining = json['total_amount_remaining'];
    status = json['status'];
    feesFineAmount = json['fees_fine_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transport_feemaster_id'] = this.transportFeemasterId;
    data['student_session_id'] = this.studentSessionId;
    data['route_pickup_point_id'] = this.routePickupPointId;
    data['generated_by'] = this.generatedBy;
    data['created_at'] = this.createdAt;
    data['month'] = this.month;
    data['due_date'] = this.dueDate;
    data['fees'] = this.fees;
    data['fine_amount'] = this.fineAmount;
    data['fine_type'] = this.fineType;
    data['fine_percentage'] = this.finePercentage;
    data['student_fees_deposite_id'] = this.studentFeesDepositeId;
    data['amount_detail'] = this.amountDetail;
    data['total_amount_paid'] = this.totalAmountPaid;
    data['total_amount_discount'] = this.totalAmountDiscount;
    data['total_amount_fine'] = this.totalAmountFine;
    data['total_amount_display'] = this.totalAmountDisplay;
    data['total_amount_remaining'] = this.totalAmountRemaining;
    data['status'] = this.status;
    data['fees_fine_amount'] = this.feesFineAmount;
    return data;
  }
}

class StudentDiscountFee {
  String? id;
  String? studentSessionId;
  String? status;
  String? paymentId;
  Null? studentFeesDiscountDescription;
  String? feesDiscountId;
  String? name;
  String? code;
  String? amount;
  String? description;
  String? sessionId;
  String? percentage;
  String? type;

  StudentDiscountFee(
      {this.id,
        this.studentSessionId,
        this.status,
        this.paymentId,
        this.studentFeesDiscountDescription,
        this.feesDiscountId,
        this.name,
        this.code,
        this.amount,
        this.description,
        this.sessionId,
        this.percentage,
        this.type});

  StudentDiscountFee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentSessionId = json['student_session_id'];
    status = json['status'];
    paymentId = json['payment_id'];
    studentFeesDiscountDescription = json['student_fees_discount_description'];
    feesDiscountId = json['fees_discount_id'];
    name = json['name'];
    code = json['code'];
    amount = json['amount'];
    description = json['description'];
    sessionId = json['session_id'];
    percentage = json['percentage'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_session_id'] = this.studentSessionId;
    data['status'] = this.status;
    data['payment_id'] = this.paymentId;
    data['student_fees_discount_description'] =
        this.studentFeesDiscountDescription;
    data['fees_discount_id'] = this.feesDiscountId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['session_id'] = this.sessionId;
    data['percentage'] = this.percentage;
    data['type'] = this.type;
    return data;
  }
}

class GrandFee {
  int? amount;
  int? amountDiscount;
  int? amountFine;
  int? amountPaid;
  int? amountRemaining;
  int? feeFine;

  GrandFee(
      {this.amount,
        this.amountDiscount,
        this.amountFine,
        this.amountPaid,
        this.amountRemaining,
        this.feeFine});

  GrandFee.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    amountDiscount = json['amount_discount'];
    amountFine = json['amount_fine'];
    amountPaid = json['amount_paid'];
    amountRemaining = json['amount_remaining'];
    feeFine = json['fee_fine'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['amount_discount'] = this.amountDiscount;
    data['amount_fine'] = this.amountFine;
    data['amount_paid'] = this.amountPaid;
    data['amount_remaining'] = this.amountRemaining;
    data['fee_fine'] = this.feeFine;
    return data;
  }
}
