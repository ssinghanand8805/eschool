class MediaManagerModal {
  int? status;
  String? error;
  List<Data>? data;

  MediaManagerModal({this.status, this.error, this.data});

  MediaManagerModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? image;
  String? thumbPath;
  String? dirPath;
  String? imgName;
  String? thumbName;
  String? createdAt;
  String? fileType;
  String? fileSize;
  String? vidUrl;
  String? vidTitle;

  Data(
      {this.id,
        this.image,
        this.thumbPath,
        this.dirPath,
        this.imgName,
        this.thumbName,
        this.createdAt,
        this.fileType,
        this.fileSize,
        this.vidUrl,
        this.vidTitle});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    thumbPath = json['thumb_path'];
    dirPath = json['dir_path'];
    imgName = json['img_name'];
    thumbName = json['thumb_name'];
    createdAt = json['created_at'];
    fileType = json['file_type'];
    fileSize = json['file_size'];
    vidUrl = json['vid_url'];
    vidTitle = json['vid_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['thumb_path'] = this.thumbPath;
    data['dir_path'] = this.dirPath;
    data['img_name'] = this.imgName;
    data['thumb_name'] = this.thumbName;
    data['created_at'] = this.createdAt;
    data['file_type'] = this.fileType;
    data['file_size'] = this.fileSize;
    data['vid_url'] = this.vidUrl;
    data['vid_title'] = this.vidTitle;
    return data;
  }
}
