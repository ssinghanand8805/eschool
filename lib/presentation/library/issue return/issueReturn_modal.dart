class  IssueReturn {
  String? status;
  String? error;
  String? message;
  List<Data>? data;

  IssueReturn({this.status, this.error, this.message, this.data});

  IssueReturn.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? sendTo;
  String? title;
  String? shareDate;
  String? validUpto;
  String? description;
  String? createdBy;
  String? createdAt;
  String? name;
  String? surname;
  String? employeeId;

  Data(
      {this.id,
        this.sendTo,
        this.title,
        this.shareDate,
        this.validUpto,
        this.description,
        this.createdBy,
        this.createdAt,
        this.name,
        this.surname,
        this.employeeId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sendTo = json['send_to'];
    title = json['title'];
    shareDate = json['share_date'];
    validUpto = json['valid_upto'];
    description = json['description'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    name = json['name'];
    surname = json['surname'];
    employeeId = json['employee_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['send_to'] = this.sendTo;
    data['title'] = this.title;
    data['share_date'] = this.shareDate;
    data['valid_upto'] = this.validUpto;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['employee_id'] = this.employeeId;
    return data;
  }
}
