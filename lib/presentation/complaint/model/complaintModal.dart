class ComplaintModal {
  List<ResultArray>? resultArray = [];

  ComplaintModal({this.resultArray});

  ComplaintModal.fromJson(Map<String, dynamic> json) {
    if (json['result_array'] != null) {
      resultArray = <ResultArray>[];
      json['result_array'].forEach((v) {
        resultArray!.add(new ResultArray.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resultArray != null) {
      data['result_array'] = this.resultArray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultArray {
  String? id;
  String? studentSessionId;
  String? fromDate;
  String? toDate;
  String? applyDate;
  String? status;
  String? docs;
  String? reason;
  String? approveBy;
  String? approveDate;
  String? requestType;
  String? createdAt;
  String? firstname;
  String? lastname;
  String? staffName;
  String? studentId;
  String? surname;

  ResultArray({this.id,
    this.studentSessionId,
    this.fromDate,
    this.toDate,
    this.applyDate,
    this.status,
    this.docs,
    this.reason,
    this.approveBy,
    this.approveDate,
    this.requestType,
    this.createdAt,
    this.firstname,
    this.lastname,
    this.staffName,
    this.studentId,
    this.surname});

  ResultArray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentSessionId = json['student_session_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    applyDate = json['apply_date'];
    status = json['status'];
    docs = json['docs'];
    reason = json['reason'];
    approveBy = json['approve_by'];
    approveDate = json['approve_date'];
    requestType = json['request_type'];
    createdAt = json['created_at'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    staffName = json['staff_name'];
    studentId = json['student_id'];
    surname = json['surname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_session_id'] = this.studentSessionId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['apply_date'] = this.applyDate;
    data['status'] = this.status;
    data['docs'] = this.docs;
    data['reason'] = this.reason;
    data['approve_by'] = this.approveBy;
    data['approve_date'] = this.approveDate;
    data['request_type'] = this.requestType;
    data['created_at'] = this.createdAt;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['staff_name'] = this.staffName;
    data['student_id'] = this.studentId;
    data['surname'] = this.surname;
    return data;
  }
}