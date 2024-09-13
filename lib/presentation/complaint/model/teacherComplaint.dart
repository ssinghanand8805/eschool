class ComplaintType {
  String? id;
  String? complaintType;
  String? description;
  String? createdAt;

  ComplaintType(
      {this.id, this.complaintType, this.description, this.createdAt});

  ComplaintType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    complaintType = json['complaint_type'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['complaint_type'] = this.complaintType;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    return data;
  }
}
