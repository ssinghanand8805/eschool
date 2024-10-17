class NoticeBoard {
  String? status;
  String? error;
  String? message;
  List<Data>? data;

  NoticeBoard({this.status, this.error, this.message, this.data});

  NoticeBoard.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? publishDate;
  String? date;
  String? attachment;
  String? message;
  String? visibleStudent;
  String? visibleStaff;
  String? visibleParent;
  String? createdBy;
  String? createdId;
  String? isActive;
  String? createdAt;
  String? updatedAt;
  String? sendNotificationId;
  String? roles;

  Data(
      {this.id,
        this.title,
        this.publishDate,
        this.date,
        this.attachment,
        this.message,
        this.visibleStudent,
        this.visibleStaff,
        this.visibleParent,
        this.createdBy,
        this.createdId,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.sendNotificationId,
        this.roles});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    publishDate = json['publish_date'];
    date = json['date'];
    attachment = json['attachment'];
    message = json['message'];
    visibleStudent = json['visible_student'];
    visibleStaff = json['visible_staff'];
    visibleParent = json['visible_parent'];
    createdBy = json['created_by'];
    createdId = json['created_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sendNotificationId = json['send_notification_id'];
    roles = json['roles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['publish_date'] = this.publishDate;
    data['date'] = this.date;
    data['attachment'] = this.attachment;
    data['message'] = this.message;
    data['visible_student'] = this.visibleStudent;
    data['visible_staff'] = this.visibleStaff;
    data['visible_parent'] = this.visibleParent;
    data['created_by'] = this.createdBy;
    data['created_id'] = this.createdId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['send_notification_id'] = this.sendNotificationId;
    data['roles'] = this.roles;
    return data;
  }
}
