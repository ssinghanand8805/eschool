class FeesReceiptModal {
  List<Receipt>? receipt;

  FeesReceiptModal({this.receipt});

  FeesReceiptModal.fromJson(Map<String, dynamic> json) {
    if (json['receipt'] != null) {
      receipt = <Receipt>[];
      json['receipt'].forEach((v) {
        receipt!.add(new Receipt.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.receipt != null) {
      data['receipt'] = this.receipt!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Receipt {
  String? id;
  String? feeRecieptNo;
  String? isAnnual;
  String? createdDate;
  String? schoolGroup;
  String? url;

  Receipt(
      {this.id,
        this.feeRecieptNo,
        this.isAnnual,
        this.createdDate,
        this.schoolGroup,
        this.url});

  Receipt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feeRecieptNo = json['fee_reciept_no'];
    isAnnual = json['isAnnual'];
    createdDate = json['createdDate'];
    schoolGroup = json['school_group'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fee_reciept_no'] = this.feeRecieptNo;
    data['isAnnual'] = this.isAnnual;
    data['createdDate'] = this.createdDate;
    data['school_group'] = this.schoolGroup;
    data['url'] = this.url;
    return data;
  }
}
