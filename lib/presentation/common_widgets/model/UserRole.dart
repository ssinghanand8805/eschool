class UserRole {
  String? status;
  String? error;
  String? message;
  List<Data>? data;

  UserRole({this.status, this.error, this.message, this.data});

  UserRole.fromJson(Map<String, dynamic> json) {
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
  String? name;
  Null? slug;
  String? isActive;
  String? isSystem;
  String? isSuperadmin;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.slug,
        this.isActive,
        this.isSystem,
        this.isSuperadmin,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    isActive = json['is_active'];
    isSystem = json['is_system'];
    isSuperadmin = json['is_superadmin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['is_active'] = this.isActive;
    data['is_system'] = this.isSystem;
    data['is_superadmin'] = this.isSuperadmin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
