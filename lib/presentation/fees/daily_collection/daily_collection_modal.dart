import 'package:intl/intl.dart';

class DailyCollection {
  List<FeesData>? feesData;

  DailyCollection({this.feesData});

  DailyCollection.fromJson(Map<String, dynamic> json) {
    if (json['fees_data'] != null) {
      feesData = <FeesData>[];
      json['fees_data'].forEach((v) {
        feesData!.add(new FeesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.feesData != null) {
      data['fees_data'] = this.feesData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeesData {
  Txn? txn;

  FeesData({this.txn});

  FeesData.fromJson(Map<String, dynamic> json) {
    txn = json['txn'] != null ? new Txn.fromJson(json['txn']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.txn != null) {
      data['txn'] = this.txn!.toJson();
    }
    return data;
  }
}

class Txn {
  String? date;
  int? amt;
  int? count;
  List<String>? studentFeesDepositeIds;

  Txn({this.date, this.amt, this.count, this.studentFeesDepositeIds});

  Txn.fromJson(Map<String, dynamic> json) {
    date = DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000));
    amt = json['amt'];
    count = json['count'];
    studentFeesDepositeIds = json['student_fees_deposite_ids'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['amt'] = this.amt;
    data['count'] = this.count;
    data['student_fees_deposite_ids'] = this.studentFeesDepositeIds;
    return data;
  }
}
