class Sessionlist {
  String? id;
  String? session;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  Sessionlist(
      {this.id, this.session, this.isActive, this.createdAt, this.updatedAt});

  Sessionlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    session = json['session'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session'] = this.session;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}