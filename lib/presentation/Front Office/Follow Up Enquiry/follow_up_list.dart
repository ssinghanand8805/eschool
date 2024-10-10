class FollowUpDetails {
  String? id;
  String? lastFollowUpDate;
  String? nextFollowUpDate;
  String? enquiryDate;
  String? status;
  String? email;
  String? contact;
  String? address;
  String? description;
  String? note;
  String? noOfChild;
  String? dob;
  String? lastschool;
  String? lastclass;
  String? fathername;
  String? occupation;
  String? assignedStaffName;
  String? createdByStaffName;
  EnquiryStatus? enquiryStatus;
  List<FollowUpList>? followUpList;

  FollowUpDetails(
      {this.id,
        this.lastFollowUpDate,
        this.nextFollowUpDate,
        this.enquiryDate,
        this.status,
        this.email,
        this.contact,
        this.address,
        this.description,
        this.note,
        this.noOfChild,
        this.dob,
        this.lastschool,
        this.lastclass,
        this.fathername,
        this.occupation,
        this.assignedStaffName,
        this.createdByStaffName,
        this.enquiryStatus,
        this.followUpList});

  FollowUpDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lastFollowUpDate = json['last_follow_up_date'];
    nextFollowUpDate = json['next_follow_up_date'];
    enquiryDate = json['enquiry_date'];
    status = json['status'];
    email = json['email'];
    contact = json['contact'];
    address = json['address'];
    description = json['description'];
    note = json['note'];
    noOfChild = json['no_of_child'];
    dob = json['dob'];
    lastschool = json['lastschool'];
    lastclass = json['lastclass'];
    fathername = json['fathername'];
    occupation = json['occupation'];
    assignedStaffName = json['assigned_staff_name'];
    createdByStaffName = json['created_by_staff_name'];
    enquiryStatus = json['enquiry_status'] != null
        ? new EnquiryStatus.fromJson(json['enquiry_status'])
        : null;
    if (json['follow_up_list'] != null) {
      followUpList = <FollowUpList>[];
      json['follow_up_list'].forEach((v) {
        followUpList!.add(new FollowUpList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['last_follow_up_date'] = this.lastFollowUpDate;
    data['next_follow_up_date'] = this.nextFollowUpDate;
    data['enquiry_date'] = this.enquiryDate;
    data['status'] = this.status;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['address'] = this.address;
    data['description'] = this.description;
    data['note'] = this.note;
    data['no_of_child'] = this.noOfChild;
    data['dob'] = this.dob;
    data['lastschool'] = this.lastschool;
    data['lastclass'] = this.lastclass;
    data['fathername'] = this.fathername;
    data['occupation'] = this.occupation;
    data['assigned_staff_name'] = this.assignedStaffName;
    data['created_by_staff_name'] = this.createdByStaffName;
    if (this.enquiryStatus != null) {
      data['enquiry_status'] = this.enquiryStatus!.toJson();
    }
    if (this.followUpList != null) {
      data['follow_up_list'] =
          this.followUpList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EnquiryStatus {
  String? active;
  String? passive;
  String? dead;
  String? won;
  String? lost;

  EnquiryStatus({this.active, this.passive, this.dead, this.won, this.lost});

  EnquiryStatus.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    passive = json['passive'];
    dead = json['dead'];
    won = json['won'];
    lost = json['lost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['passive'] = this.passive;
    data['dead'] = this.dead;
    data['won'] = this.won;
    data['lost'] = this.lost;
    return data;
  }
}

class FollowUpList {
  String? id;
  String? enquiryId;
  String? date;
  String? nextDate;
  String? response;
  String? note;
  String? followupBy;
  String? createdAt;
  String? employeeId;
  String? name;
  String? surname;
  String? createdBy;

  FollowUpList(
      {this.id,
        this.enquiryId,
        this.date,
        this.nextDate,
        this.response,
        this.note,
        this.followupBy,
        this.createdAt,
        this.employeeId,
        this.name,
        this.surname,
        this.createdBy});

  FollowUpList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enquiryId = json['enquiry_id'];
    date = json['date'];
    nextDate = json['next_date'];
    response = json['response'];
    note = json['note'];
    followupBy = json['followup_by'];
    createdAt = json['created_at'];
    employeeId = json['employee_id'];
    name = json['name'];
    surname = json['surname'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enquiry_id'] = this.enquiryId;
    data['date'] = this.date;
    data['next_date'] = this.nextDate;
    data['response'] = this.response;
    data['note'] = this.note;
    data['followup_by'] = this.followupBy;
    data['created_at'] = this.createdAt;
    data['employee_id'] = this.employeeId;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['created_by'] = this.createdBy;
    return data;
  }
}
