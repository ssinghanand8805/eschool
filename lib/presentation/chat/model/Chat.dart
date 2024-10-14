class Chat {
  bool? success;
  Data? data;
  String? message;

  Chat({this.success, this.data, this.message});

  Chat.fromJson(Map<String, dynamic> json) {
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
  Null? user;
  Group? group;
  List<Conversations>? conversations;
  List<Conversations>? media;
  String? chatRequest;

  Data(
      {this.user,
        this.group,
        this.conversations,
        this.media,
        this.chatRequest});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
    if (json['conversations'] != null) {
      conversations = <Conversations>[];
      json['conversations'].forEach((v) {
        conversations!.add(new Conversations.fromJson(v));
      });
    }
    if (json['media'] != null) {
      media = <Conversations>[];
      json['media'].forEach((v) {
        media!.add(new Conversations.fromJson(v));
      });
    }
    chatRequest = json['chat_request'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    if (this.conversations != null) {
      data['conversations'] =
          this.conversations!.map((v) => v.toJson()).toList();
    }
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    data['chat_request'] = this.chatRequest;
    return data;
  }
}

class Group {
  String? id;
  String? name;
  String? description;
  String? photoUrl;
  int? privacy;
  int? groupType;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  int? myRole;
  bool? removedFromGroup;
  String? groupCreatedBy;
  List<Users>? users;
  List<UsersWithTrashed>? usersWithTrashed;
  List<String>? lastConversations;
  CreatedByUser? createdByUser;

  Group(
      {this.id,
        this.name,
        this.description,
        this.photoUrl,
        this.privacy,
        this.groupType,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.myRole,
        this.removedFromGroup,
        this.groupCreatedBy,
        this.users,
        this.usersWithTrashed,
        this.lastConversations,
        this.createdByUser});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    photoUrl = json['photo_url'];
    privacy = json['privacy'];
    groupType = json['group_type'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    myRole = json['my_role'];
    removedFromGroup = json['removed_from_group'];
    groupCreatedBy = json['group_created_by'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    if (json['users_with_trashed'] != null) {
      usersWithTrashed = <UsersWithTrashed>[];
      json['users_with_trashed'].forEach((v) {
        usersWithTrashed!.add(new UsersWithTrashed.fromJson(v));
      });
    }
    if (json['last_conversations'] != null) {
      lastConversations = <String>[];
      json['last_conversations'].forEach((v) {
        lastConversations!.add(v);
      });
    }
    createdByUser = json['created_by_user'] != null
        ? new CreatedByUser.fromJson(json['created_by_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['photo_url'] = this.photoUrl;
    data['privacy'] = this.privacy;
    data['group_type'] = this.groupType;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['my_role'] = this.myRole;
    data['removed_from_group'] = this.removedFromGroup;
    data['group_created_by'] = this.groupCreatedBy;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    if (this.usersWithTrashed != null) {
      data['users_with_trashed'] =
          this.usersWithTrashed!.map((v) => v.toJson()).toList();
    }
    if (this.lastConversations != null) {
      data['last_conversations'] =
          this.lastConversations!.map((v) => v).toList();
    }
    if (this.createdByUser != null) {
      data['created_by_user'] = this.createdByUser!.toJson();
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
  String? playerId;
  bool? isSubscribed;
  int? privacy;
  int? gender;
  String? deletedAt;
  String? language;
  bool? isSuperAdmin;
  String? roleName;
  Pivot? pivot;
  List<Roles>? roles;
  String? userStatus;

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
        this.roleName,
        this.pivot,
        this.roles,
        this.userStatus});

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
    roleName = json['role_name'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
    userStatus = json['user_status'];
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
    data['role_name'] = this.roleName;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    data['user_status'] = this.userStatus;
    return data;
  }
}

class Pivot {
  String? groupId;
  int? userId;
  int? role;
  String? deletedAt;
  String? createdAt;

  Pivot({this.groupId, this.userId, this.role, this.deletedAt, this.createdAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    userId = json['user_id'];
    role = json['role'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['user_id'] = this.userId;
    data['role'] = this.role;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
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


class UsersWithTrashed {
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
  String? playerId;
  bool? isSubscribed;
  int? privacy;
  int? gender;
  String? deletedAt;
  String? language;
  bool? isSuperAdmin;
  String? roleName;
  Pivot? pivot;
  List<Roles>? roles;

  UsersWithTrashed(
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
        this.roleName,
        this.pivot,
        this.roles});

  UsersWithTrashed.fromJson(Map<String, dynamic> json) {
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
    roleName = json['role_name'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    data['role_name'] = this.roleName;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class CreatedByUser {
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
  String? playerId;
  String? isSubscribed;
  int? privacy;
  String? gender;
  String? deletedAt;
  String? language;
  bool? isSuperAdmin;
  String? roleName;
  List<Roles>? roles;

  CreatedByUser(
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
        this.roleName,
        this.roles});

  CreatedByUser.fromJson(Map<String, dynamic> json) {
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
    data['role_name'] = this.roleName;
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conversations {
  int? id;
  int? fromId;
  String? toId;
  String? toType;
  String? message;
  int? status;
  int? messageType;
  String? fileName;
  String? createdAt;
  String? updatedAt;
  String? replyTo;
  String? urlDetails;
  int? readByAllCount;
  String? timeFromNowInMin;
  int? isGroup;
  String? replyMessage;
  CreatedByUser? sender;
  String? receiver;
  List<ReadBy>? readBy;

  Conversations(
      {this.id,
        this.fromId,
        this.toId,
        this.toType,
        this.message,
        this.status,
        this.messageType,
        this.fileName,
        this.createdAt,
        this.updatedAt,
        this.replyTo,
        this.urlDetails,
        this.readByAllCount,
        this.timeFromNowInMin,
        this.isGroup,
        this.replyMessage,
        this.sender,
        this.receiver,
        this.readBy});

  Conversations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    toType = json['to_type'];
    message = json['message'];
    status = json['status'];
    messageType = json['message_type'];
    fileName = json['file_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    replyTo = json['reply_to'];
    urlDetails = json['url_details'];
    readByAllCount = json['read_by_all_count'];
    timeFromNowInMin = json['time_from_now_in_min'];
    isGroup = json['is_group'];
    replyMessage = json['reply_message'];
    sender = json['sender'] != null
        ? new CreatedByUser.fromJson(json['sender'])
        : null;
    receiver = json['receiver'];
    if (json['read_by'] != null) {
      readBy = <ReadBy>[];
      json['read_by'].forEach((v) {
        readBy!.add(new ReadBy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_id'] = this.fromId;
    data['to_id'] = this.toId;
    data['to_type'] = this.toType;
    data['message'] = this.message;
    data['status'] = this.status;
    data['message_type'] = this.messageType;
    data['file_name'] = this.fileName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['reply_to'] = this.replyTo;
    data['url_details'] = this.urlDetails;
    data['read_by_all_count'] = this.readByAllCount;
    data['time_from_now_in_min'] = this.timeFromNowInMin;
    data['is_group'] = this.isGroup;
    data['reply_message'] = this.replyMessage;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    data['receiver'] = this.receiver;
    if (this.readBy != null) {
      data['read_by'] = this.readBy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReadBy {
  int? id;
  int? userId;
  int? conversationId;
  String? groupId;
  Null? readAt;
  Null? createdAt;
  Null? updatedAt;

  ReadBy(
      {this.id,
        this.userId,
        this.conversationId,
        this.groupId,
        this.readAt,
        this.createdAt,
        this.updatedAt});

  ReadBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    conversationId = json['conversation_id'];
    groupId = json['group_id'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['conversation_id'] = this.conversationId;
    data['group_id'] = this.groupId;
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
