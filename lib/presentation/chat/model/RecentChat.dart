class RecentChat {
  bool? success;
  Data? data;
  String? message;

  RecentChat({this.success, this.data, this.message});

  RecentChat.fromJson(Map<String, dynamic> json) {
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
  List<Conversations>? conversations;

  Data({this.conversations});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['conversations'] != null) {
      conversations = <Conversations>[];
      json['conversations'].forEach((v) {
        conversations!.add(new Conversations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.conversations != null) {
      data['conversations'] =
          this.conversations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Conversations {
  int? latestId;
  int? userId;
  String? groupId;
  String? unreadCount;
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
  String? timeFromNowInMin;
  int? isGroup;
  String? replyMessage;
  Group? group;
  User? user;

  Conversations(
      {this.latestId,
        this.userId,
        this.groupId,
        this.unreadCount,
        this.id,
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
        this.timeFromNowInMin,
        this.isGroup,
        this.replyMessage,
        this.group,
        this.user});
  Conversations.fromJson(Map<String, dynamic> json) {
    try {
      // Wrap each assignment in its own try-catch block for detailed logging
      try {
        latestId = json['latest_id'];
      } catch (e) {
        print("❌ Error parsing 'latest_id': $e");
      }

      try {
        userId = json['user_id'];
      } catch (e) {
        print("❌ Error parsing 'user_id': $e");
      }

      try {
        groupId = json['group_id'];
      } catch (e) {
        print("❌ Error parsing 'group_id': $e");
      }

      try {
        unreadCount = json['unread_count'];
      } catch (e) {
        print("❌ Error parsing 'unread_count': $e");
      }

      try {
        id = json['id'];
      } catch (e) {
        print("❌ Error parsing 'id': $e");
      }

      try {
        fromId = json['from_id'];
      } catch (e) {
        print("❌ Error parsing 'from_id': $e");
      }

      try {
        toId = json['to_id'];
      } catch (e) {
        print("❌ Error parsing 'to_id': $e");
      }

      try {
        toType = json['to_type'];
      } catch (e) {
        print("❌ Error parsing 'to_type': $e");
      }

      try {
        message = json['message'];
      } catch (e) {
        print("❌ Error parsing 'message': $e");
      }

      try {
        status = json['status'];
      } catch (e) {
        print("❌ Error parsing 'status': $e");
      }

      try {
        messageType = json['message_type'];
      } catch (e) {
        print("❌ Error parsing 'message_type': $e");
      }

      try {
        fileName = json['file_name'];
      } catch (e) {
        print("❌ Error parsing 'file_name': $e");
      }

      try {
        createdAt = json['created_at'];
      } catch (e) {
        print("❌ Error parsing 'created_at': $e");
      }

      try {
        updatedAt = json['updated_at'];
      } catch (e) {
        print("❌ Error parsing 'updated_at': $e");
      }

      try {
        replyTo = json['reply_to'];
      } catch (e) {
        print("❌ Error parsing 'reply_to': $e");
      }

      try {
        urlDetails = json['url_details'];
      } catch (e) {
        print("❌ Error parsing 'url_details': $e");
      }

      try {
        timeFromNowInMin = json['time_from_now_in_min'];
      } catch (e) {
        print("❌ Error parsing 'time_from_now_in_min': $e");
      }

      try {
        isGroup = json['is_group'];
      } catch (e) {
        print("❌ Error parsing 'is_group': $e");
      }

      try {
        replyMessage = json['reply_message'];
      } catch (e) {
        print("❌ Error parsing 'reply_message': $e");
      }

      try {
        group = json['group'] != null ? Group.fromJson(json['group']) : null;
      } catch (e) {
        print("❌ Error parsing 'group': $e");
      }

      try {
        user = json['user'] != null ? User.fromJson(json['user']) : null;
      } catch (e) {
        print("❌ Error parsing 'user': $e");
      }
    } catch (e) {
      print("❌ General Error: $e");
    }
  }

  // Conversations.fromJson(Map<String, dynamic> json) {
  //   try{
  //     latestId = json['latest_id'];
  //     userId = json['user_id'];
  //     groupId = json['group_id'];
  //     unreadCount = json['unread_count'];
  //     id = json['id'];
  //     fromId = json['from_id'];
  //     toId = json['to_id'];
  //     toType = json['to_type'];
  //     message = json['message'];
  //     status = json['status'];
  //     messageType = json['message_type'];
  //     fileName = json['file_name'];
  //     createdAt = json['created_at'];
  //     updatedAt = json['updated_at'];
  //     replyTo = json['reply_to'];
  //     urlDetails = json['url_details'];
  //     timeFromNowInMin = json['time_from_now_in_min'];
  //     isGroup = json['is_group'];
  //     replyMessage = json['reply_message'];
  //     group = json['group'] != null ? new Group.fromJson(json['group']) : null;
  //     user = json['user'] != null ? new User.fromJson(json['user']) : null;
  //   }
  //   catch(e)
  //   {
  //     print("❌ DATA: ${e}");
  //   }
  //
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latest_id'] = this.latestId;
    data['user_id'] = this.userId;
    data['group_id'] = this.groupId;
    data['unread_count'] = this.unreadCount;
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
    data['time_from_now_in_min'] = this.timeFromNowInMin;
    data['is_group'] = this.isGroup;
    data['reply_message'] = this.replyMessage;
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
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
  List<Users>? users;
  List<Users>? usersWithTrashed;
  List<Conversations>? lastConversations;

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
        this.users,
        this.usersWithTrashed,
        this.lastConversations});

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
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    if (json['users_with_trashed'] != null) {
      usersWithTrashed = <Users>[];
      json['users_with_trashed'].forEach((v) {
        usersWithTrashed!.add(new Users.fromJson(v));
      });
    }
    if (json['last_conversations'] != null) {
      lastConversations = <Conversations>[];
      json['last_conversations'].forEach((v) {
        lastConversations!.add(new Conversations.fromJson(v));
      });
    }
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
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    if (this.usersWithTrashed != null) {
      data['users_with_trashed'] =
          this.usersWithTrashed!.map((v) => v.toJson()).toList();
    }
    if (this.lastConversations != null) {
      data['last_conversations'] =
          this.lastConversations!.map((v) => v.toJson()).toList();
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
        this.roles});

  Users.fromJson(Map<String, dynamic> json) {
    try{
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
    catch(e)
    {
      print("❌ USER: ${e}");
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



class User {
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
  String? userStatus;

  User(
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
        this.roles,
        this.userStatus});
  User.fromJson(Map<String, dynamic> json) {
    try {
      try {
        id = json['id'];
      } catch (e) {
        print("❌ Error parsing 'id': $e");
      }

      try {
        name = json['name'];
      } catch (e) {
        print("❌ Error parsing 'name': $e");
      }

      try {
        email = json['email'];
      } catch (e) {
        print("❌ Error parsing 'email': $e");
      }

      try {
        emailVerifiedAt = json['email_verified_at'];
      } catch (e) {
        print("❌ Error parsing 'email_verified_at': $e");
      }

      try {
        phone = json['phone'];
      } catch (e) {
        print("❌ Error parsing 'phone': $e");
      }

      try {
        lastSeen = json['last_seen'];
      } catch (e) {
        print("❌ Error parsing 'last_seen': $e");
      }

      try {
        isOnline = json['is_online'];
      } catch (e) {
        print("❌ Error parsing 'is_online': $e");
      }

      try {
        isActive = json['is_active'];
      } catch (e) {
        print("❌ Error parsing 'is_active': $e");
      }

      try {
        about = json['about'];
      } catch (e) {
        print("❌ Error parsing 'about': $e");
      }

      try {
        photoUrl = json['photo_url'];
      } catch (e) {
        print("❌ Error parsing 'photo_url': $e");
      }

      try {
        activationCode = json['activation_code'];
      } catch (e) {
        print("❌ Error parsing 'activation_code': $e");
      }

      try {
        createdAt = json['created_at'];
      } catch (e) {
        print("❌ Error parsing 'created_at': $e");
      }

      try {
        updatedAt = json['updated_at'];
      } catch (e) {
        print("❌ Error parsing 'updated_at': $e");
      }

      try {
        isSystem = json['is_system'];
      } catch (e) {
        print("❌ Error parsing 'is_system': $e");
      }

      try {
        playerId = json['player_id'];
      } catch (e) {
        print("❌ Error parsing 'player_id': $e");
      }

      try {
        isSubscribed = json['is_subscribed']?.toString();
      } catch (e) {
        print("❌ Error parsing 'is_subscribed': $e");
      }

      try {
        privacy = json['privacy'];
      } catch (e) {
        print("❌ Error parsing 'privacy': $e");
      }

      try {
        gender = json['gender'].toString();
      } catch (e) {
        print("❌ Error parsing 'gender': $e");
      }

      try {
        deletedAt = json['deleted_at'];
      } catch (e) {
        print("❌ Error parsing 'deleted_at': $e");
      }

      try {
        language = json['language'];
      } catch (e) {
        print("❌ Error parsing 'language': $e");
      }

      try {
        isSuperAdmin = json['is_super_admin'];
      } catch (e) {
        print("❌ Error parsing 'is_super_admin': $e");
      }

      try {
        roleName = json['role_name'];
      } catch (e) {
        print("❌ Error parsing 'role_name': $e");
      }

      try {
        if (json['roles'] != null) {
          roles = <Roles>[];
          json['roles'].forEach((v) {
            roles!.add(Roles.fromJson(v));
          });
        }
      } catch (e) {
        print("❌ Error parsing 'roles': $e");
      }

      try {
        userStatus = json['user_status'];
      } catch (e) {
        print("❌ Error parsing 'user_status': $e");
      }
    } catch (e) {
      print("❌ General Error in User.fromJson: $e");
    }
  }

  // User.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   email = json['email'];
  //   emailVerifiedAt = json['email_verified_at'];
  //   phone = json['phone'];
  //   lastSeen = json['last_seen'];
  //   isOnline = json['is_online'];
  //   isActive = json['is_active'];
  //   about = json['about'];
  //   photoUrl = json['photo_url'];
  //   activationCode = json['activation_code'];
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  //   isSystem = json['is_system'];
  //   playerId = json['player_id'];
  //   isSubscribed = json['is_subscribed'].toString();
  //   privacy = json['privacy'];
  //   gender = json['gender'];
  //   deletedAt = json['deleted_at'];
  //   language = json['language'];
  //   isSuperAdmin = json['is_super_admin'];
  //   roleName = json['role_name'];
  //   if (json['roles'] != null) {
  //     roles = <Roles>[];
  //     json['roles'].forEach((v) {
  //       roles!.add(new Roles.fromJson(v));
  //     });
  //   }
  //   userStatus = json['user_status'];
  // }

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
    data['user_status'] = this.userStatus;
    return data;
  }
}
