class ApproveLeaveModal {
  int? status;
  String? error;
  Data? data;

  ApproveLeaveModal({this.status, this.error, this.data});

  ApproveLeaveModal.fromJson(Map<String, dynamic> json) {
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
  List<LeaveRequest>? leaveRequest;

  Data({this.leaveRequest});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['leave_request'] != null) {
      leaveRequest = <LeaveRequest>[];
      json['leave_request'].forEach((v) {
        leaveRequest!.add(new LeaveRequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaveRequest != null) {
      data['leave_request'] =
          this.leaveRequest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveRequest {
  String? name;
  String? surname;
  String? employeeId;
  String? id;
  String? staffId;
  String? leaveTypeId;
  String? leaveFrom;
  String? leaveTo;
  String? leaveDays;
  String? employeeRemark;
  String? adminRemark;
  String? status;
  String? appliedBy;
  String? documentFile;
  String? date;
  String? createdAt;
  String? type;

  LeaveRequest(
      {this.name,
        this.surname,
        this.employeeId,
        this.id,
        this.staffId,
        this.leaveTypeId,
        this.leaveFrom,
        this.leaveTo,
        this.leaveDays,
        this.employeeRemark,
        this.adminRemark,
        this.status,
        this.appliedBy,
        this.documentFile,
        this.date,
        this.createdAt,
        this.type});

  LeaveRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    employeeId = json['employee_id'];
    id = json['id'];
    staffId = json['staff_id'];
    leaveTypeId = json['leave_type_id'];
    leaveFrom = json['leave_from'];
    leaveTo = json['leave_to'];
    leaveDays = json['leave_days'];
    employeeRemark = json['employee_remark'];
    adminRemark = json['admin_remark'];
    status = json['status'];
    appliedBy = json['applied_by'];
    documentFile = json['document_file'];
    date = json['date'];
    createdAt = json['created_at'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['employee_id'] = this.employeeId;
    data['id'] = this.id;
    data['staff_id'] = this.staffId;
    data['leave_type_id'] = this.leaveTypeId;
    data['leave_from'] = this.leaveFrom;
    data['leave_to'] = this.leaveTo;
    data['leave_days'] = this.leaveDays;
    data['employee_remark'] = this.employeeRemark;
    data['admin_remark'] = this.adminRemark;
    data['status'] = this.status;
    data['applied_by'] = this.appliedBy;
    data['document_file'] = this.documentFile;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['type'] = this.type;
    return data;
  }
}
