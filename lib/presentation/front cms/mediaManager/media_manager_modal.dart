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





class MediaTypeListModal {
  int? status;
  String? error;
  Data2? data;

  MediaTypeListModal({this.status, this.error, this.data});

  MediaTypeListModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    data = json['data'] != null ? new Data2.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data2 {
  MediaTypes? mediaTypes;

  Data2({this.mediaTypes});

  Data2.fromJson(Map<String, dynamic> json) {
    mediaTypes = json['mediaTypes'] != null
        ? new MediaTypes.fromJson(json['mediaTypes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mediaTypes != null) {
      data['mediaTypes'] = this.mediaTypes!.toJson();
    }
    return data;
  }
}

class MediaTypes {
  String? imageJpeg;
  String? video;
  String? textPlain;
  String? applicationZip;
  String? applicationXRar;
  String? applicationPdf;
  String? applicationMsword;
  String? applicationVndMsExcel;
  String? other;

  MediaTypes(
      {this.imageJpeg,
        this.video,
        this.textPlain,
        this.applicationZip,
        this.applicationXRar,
        this.applicationPdf,
        this.applicationMsword,
        this.applicationVndMsExcel,
        this.other});

  MediaTypes.fromJson(Map<String, dynamic> json) {
    imageJpeg = json['image/jpeg'];
    video = json['video'];
    textPlain = json['text/plain'];
    applicationZip = json['application/zip'];
    applicationXRar = json['application/x-rar'];
    applicationPdf = json['application/pdf'];
    applicationMsword = json['application/msword'];
    applicationVndMsExcel = json['application/vnd.ms-excel'];
    other = json['other'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image/jpeg'] = this.imageJpeg;
    data['video'] = this.video;
    data['text/plain'] = this.textPlain;
    data['application/zip'] = this.applicationZip;
    data['application/x-rar'] = this.applicationXRar;
    data['application/pdf'] = this.applicationPdf;
    data['application/msword'] = this.applicationMsword;
    data['application/vnd.ms-excel'] = this.applicationVndMsExcel;
    data['other'] = this.other;
    return data;
  }
}
