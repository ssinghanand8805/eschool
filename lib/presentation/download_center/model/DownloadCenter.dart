class DownloadCenter {
  String? id;
  String? sendTo;
  String? title;
  String? shareDate;
  String? validUpto;
  String? description;
  String? createdBy;
  String? createdAt;
  String? name;
  String? surname;
  String? employeeId;
  List<UploadContents>? uploadContents;

  DownloadCenter(
      {this.id,
        this.sendTo,
        this.title,
        this.shareDate,
        this.validUpto,
        this.description,
        this.createdBy,
        this.createdAt,
        this.name,
        this.surname,
        this.employeeId,
        this.uploadContents});

  DownloadCenter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sendTo = json['send_to'];
    title = json['title'];
    shareDate = json['share_date'];
    validUpto = json['valid_upto'];
    description = json['description'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    name = json['name'];
    surname = json['surname'];
    employeeId = json['employee_id'];
    if (json['upload_contents'] != null) {
      uploadContents = <UploadContents>[];
      json['upload_contents'].forEach((v) {
        uploadContents!.add(new UploadContents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['send_to'] = this.sendTo;
    data['title'] = this.title;
    data['share_date'] = this.shareDate;
    data['valid_upto'] = this.validUpto;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['employee_id'] = this.employeeId;
    if (this.uploadContents != null) {
      data['upload_contents'] =
          this.uploadContents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UploadContents {
  String? id;
  String? uploadContentId;
  String? shareContentId;
  String? createdAt;
  String? realName;
  String? thumbPath;
  String? dirPath;
  String? imgName;
  String? thumbName;
  String? fileType;
  String? mimeType;
  String? vidUrl;
  String? vidTitle;

  UploadContents(
      {this.id,
        this.uploadContentId,
        this.shareContentId,
        this.createdAt,
        this.realName,
        this.thumbPath,
        this.dirPath,
        this.imgName,
        this.thumbName,
        this.fileType,
        this.mimeType,
        this.vidUrl,
        this.vidTitle});

  UploadContents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uploadContentId = json['upload_content_id'];
    shareContentId = json['share_content_id'];
    createdAt = json['created_at'];
    realName = json['real_name'];
    thumbPath = json['thumb_path'];
    dirPath = json['dir_path'];
    imgName = json['img_name'];
    thumbName = json['thumb_name'];
    fileType = json['file_type'];
    mimeType = json['mime_type'];
    vidUrl = json['vid_url'];
    vidTitle = json['vid_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['upload_content_id'] = this.uploadContentId;
    data['share_content_id'] = this.shareContentId;
    data['created_at'] = this.createdAt;
    data['real_name'] = this.realName;
    data['thumb_path'] = this.thumbPath;
    data['dir_path'] = this.dirPath;
    data['img_name'] = this.imgName;
    data['thumb_name'] = this.thumbName;
    data['file_type'] = this.fileType;
    data['mime_type'] = this.mimeType;
    data['vid_url'] = this.vidUrl;
    data['vid_title'] = this.vidTitle;
    return data;
  }
}