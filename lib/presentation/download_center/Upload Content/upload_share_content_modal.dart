class UploadContent {
  List<Content>? content;
  int? totalItems;
  bool? hasMore;

  UploadContent({this.content, this.totalItems, this.hasMore});

  UploadContent.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
    totalItems = json['total_items'];
    hasMore = json['has_more'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['total_items'] = this.totalItems;
    data['has_more'] = this.hasMore;
    return data;
  }
}

class Content {
  String? id;
  String? contentTypeId;
  Null? image;
  String? thumbPath;
  String? dirPath;
  String? realName;
  String? imgName;
  String? thumbName;
  String? fileType;
  String? mimeType;
  String? fileSize;
  String? vidUrl;
  String? vidTitle;
  String? uploadBy;
  String? createdAt;
  String? staffName;
  String? surname;
  String? employeeId;
  String? contentType;

  Content(
      {this.id,
        this.contentTypeId,
        this.image,
        this.thumbPath,
        this.dirPath,
        this.realName,
        this.imgName,
        this.thumbName,
        this.fileType,
        this.mimeType,
        this.fileSize,
        this.vidUrl,
        this.vidTitle,
        this.uploadBy,
        this.createdAt,
        this.staffName,
        this.surname,
        this.employeeId,
        this.contentType});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentTypeId = json['content_type_id'];
    image = json['image'];
    thumbPath = json['thumb_path'];
    dirPath = json['dir_path'];
    realName = json['real_name'];
    imgName = json['img_name'];
    thumbName = json['thumb_name'];
    fileType = json['file_type'];
    mimeType = json['mime_type'];
    fileSize = json['file_size'];
    vidUrl = json['vid_url'];
    vidTitle = json['vid_title'];
    uploadBy = json['upload_by'];
    createdAt = json['created_at'];
    staffName = json['staff_name'];
    surname = json['surname'];
    employeeId = json['employee_id'];
    contentType = json['content_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content_type_id'] = this.contentTypeId;
    data['image'] = this.image;
    data['thumb_path'] = this.thumbPath;
    data['dir_path'] = this.dirPath;
    data['real_name'] = this.realName;
    data['img_name'] = this.imgName;
    data['thumb_name'] = this.thumbName;
    data['file_type'] = this.fileType;
    data['mime_type'] = this.mimeType;
    data['file_size'] = this.fileSize;
    data['vid_url'] = this.vidUrl;
    data['vid_title'] = this.vidTitle;
    data['upload_by'] = this.uploadBy;
    data['created_at'] = this.createdAt;
    data['staff_name'] = this.staffName;
    data['surname'] = this.surname;
    data['employee_id'] = this.employeeId;
    data['content_type'] = this.contentType;
    return data;
  }
}
