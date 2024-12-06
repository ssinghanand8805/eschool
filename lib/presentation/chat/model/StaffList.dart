class StaffList {
  bool? success;
  Data? data;
  String? message;

  StaffList({this.success, this.data, this.message});

  StaffList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<Users>? users;

  Data({this.users});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  String? lastSeen;
  bool? isOnline;
  int? isActive;
  String? about;
  String? photoUrl;
  String? activationCode;
  String? createdAt;
  String? updatedAt;
  bool? isSystem;
  Null? playerId;
  bool? isSubscribed;
  int? privacy;
  int? gender;
  Null? deletedAt;
  String? language;
  bool? isSuperAdmin;
  int? appUserId;
  int? appRole;
  int? classId;
  int? sectionId;
  String? roleName;
  List<Roles>? roles;

  Users(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.phone,
        this.lastSeen,
        this.isOnline,
        this.isActive,
        this.about,
        this.photoUrl,
        this.activationCode,
        this.createdAt,
        this.updatedAt,
        this.isSystem,
        this.playerId,
        this.isSubscribed,
        this.privacy,
        this.gender,
        this.deletedAt,
        this.language,
        this.isSuperAdmin,
        this.appUserId,
        this.appRole,
        this.classId,
        this.sectionId,
        this.roleName,
        this.roles});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    lastSeen = json['last_seen'];
    isOnline = json['is_online'];
    isActive = json['is_active'];
    about = json['about'];
    photoUrl = json['photo_url'];
    activationCode = json['activation_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSystem = json['is_system'];
    playerId = json['player_id'];
    isSubscribed = json['is_subscribed'];
    privacy = json['privacy'];
    gender = json['gender'];
    deletedAt = json['deleted_at'];
    language = json['language'];
    isSuperAdmin = json['is_super_admin'];
    appUserId = json['app_user_id'];
    appRole = json['app_role'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    roleName = json['role_name'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['last_seen'] = this.lastSeen;
    data['is_online'] = this.isOnline;
    data['is_active'] = this.isActive;
    data['about'] = this.about;
    data['photo_url'] = this.photoUrl;
    data['activation_code'] = this.activationCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_system'] = this.isSystem;
    data['player_id'] = this.playerId;
    data['is_subscribed'] = this.isSubscribed;
    data['privacy'] = this.privacy;
    data['gender'] = this.gender;
    data['deleted_at'] = this.deletedAt;
    data['language'] = this.language;
    data['is_super_admin'] = this.isSuperAdmin;
    data['app_user_id'] = this.appUserId;
    data['app_role'] = this.appRole;
    data['class_id'] = this.classId;
    data['section_id'] = this.sectionId;
    data['role_name'] = this.roleName;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  String? guardName;
  int? isDefault;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Roles(
      {this.id,
        this.name,
        this.guardName,
        this.isDefault,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['guard_name'] = this.guardName;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? modelId;
  int? roleId;
  String? modelType;

  Pivot({this.modelId, this.roleId, this.modelType});

  Pivot.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    roleId = json['role_id'];
    modelType = json['model_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_id'] = this.modelId;
    data['role_id'] = this.roleId;
    data['model_type'] = this.modelType;
    return data;
  }
}
