class BalanceFee {
  List<StudentDueFee>? studentDueFee;

  BalanceFee({this.studentDueFee});

  BalanceFee.fromJson(Map<String, dynamic> json) {
    if (json['student_due_fee'] != null) {
      studentDueFee = <StudentDueFee>[];
      json['student_due_fee'].forEach((v) { studentDueFee!.add(new StudentDueFee.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.studentDueFee != null) {
      data['student_due_fee'] = this.studentDueFee!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentDueFee {
  String? name;
  String? className;
  String? section;
  String? admissionNo;
  String? rollNo;
  String? fatherName;
  String? totalfee;
  String? paymentMode;
  String? deposit;
  String? fine;
  String? discount;
  String? balance;

  StudentDueFee({this.name, this.className, this.section, this.admissionNo, this.rollNo, this.fatherName, this.totalfee, this.paymentMode, this.deposit, this.fine, this.discount, this.balance});

  StudentDueFee.fromJson(Map<String, dynamic> json) {
  name = json['name'].toString();
  className = json['class'].toString();
  section = json['section'].toString();
  admissionNo = json['admission_no'].toString();
  rollNo = json['roll_no'].toString();
  fatherName = json['father_name'].toString();
  totalfee = json['totalfee'].toString();
  paymentMode = json['payment_mode'].toString();
  deposit = json['deposit'].toString();
  fine = json['fine'].toString();
  discount = json['discount'].toString();
  balance = json['balance'].toString();
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['name'] = this.name;
  data['class'] = this.className;
  data['section'] = this.section;
  data['admission_no'] = this.admissionNo;
  data['roll_no'] = this.rollNo;
  data['father_name'] = this.fatherName;
  data['totalfee'] = this.totalfee;
  data['payment_mode'] = this.paymentMode;
  data['deposit'] = this.deposit;
  data['fine'] = this.fine;
  data['discount'] = this.discount;
  data['balance'] = this.balance;
  return data;
  }
}
