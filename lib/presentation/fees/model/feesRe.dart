class FeesReceiptModal {
  List<Receipt>? receipt;

  FeesReceiptModal({this.receipt});

  FeesReceiptModal.fromJson(Map<String, dynamic> json) {
    if (json['receipt'] != null) {
      receipt = [];
      for (var v in json['receipt']) {
        receipt!.add(Receipt.fromJson(v));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (receipt != null) {
      data['receipt'] = receipt!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Receipt {
  final String id;
  final String feeRecieptNo;
  final String isAnnual;
  final String createdDate;
  final String schoolGroup;
  final String url;

  Receipt({
    required this.id,
    required this.feeRecieptNo,
    required this.isAnnual,
    required this.createdDate,
    required this.schoolGroup,
    required this.url,
  });

  Receipt.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        feeRecieptNo = json['fee_reciept_no'],
        isAnnual = json['isAnnual'],
        createdDate = json['createdDate'],
        schoolGroup = json['school_group'],
        url = json['url'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fee_reciept_no': feeRecieptNo,
      'isAnnual': isAnnual,
      'createdDate': createdDate,
      'school_group': schoolGroup,
      'url': url,
    };
  }
}
