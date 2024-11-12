class VideoTutorial {
  int? status;
  String? error;
  Data? data;

  VideoTutorial({this.status, this.error, this.data});

  VideoTutorial.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<VideoTutorialList>? videoTutorialList;

  Data({this.videoTutorialList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['Video_tutorial_list'] != null) {
      videoTutorialList = <VideoTutorialList>[];
      json['Video_tutorial_list'].forEach((v) { videoTutorialList!.add(new VideoTutorialList.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.videoTutorialList != null) {
      data['Video_tutorial_list'] = this.videoTutorialList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoTutorialList {
  String? id;
  String? title;
  String? vidTitle;
  String? description;
  String? thumbPath;
  String? dirPath;
  String? imgName;
  String? thumbName;
  String? videoLink;
  String? createdBy;
  String? createdAt;
  String? classId;
  String? sectionId;
  String? className;
  String? section;

  VideoTutorialList({this.id, this.title, this.vidTitle, this.description, this.thumbPath, this.dirPath, this.imgName, this.thumbName, this.videoLink, this.createdBy, this.createdAt, this.classId, this.sectionId, this.className, this.section});

  VideoTutorialList.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  title = json['title'];
  vidTitle = json['vid_title'];
  description = json['description'];
  thumbPath = json['thumb_path'];
  dirPath = json['dir_path'];
  imgName = json['img_name'];
  thumbName = json['thumb_name'];
  videoLink = json['video_link'];
  createdBy = json['created_by'];
  createdAt = json['created_at'];
  classId = json['class_id'];
  sectionId = json['section_id'];
  className = json['class'];
  section = json['section'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['title'] = this.title;
  data['vid_title'] = this.vidTitle;
  data['description'] = this.description;
  data['thumb_path'] = this.thumbPath;
  data['dir_path'] = this.dirPath;
  data['img_name'] = this.imgName;
  data['thumb_name'] = this.thumbName;
  data['video_link'] = this.videoLink;
  data['created_by'] = this.createdBy;
  data['created_at'] = this.createdAt;
  data['class_id'] = this.classId;
  data['section_id'] = this.sectionId;
  data['class'] = this.className;
  data['section'] = this.section;
  return data;
  }
}
