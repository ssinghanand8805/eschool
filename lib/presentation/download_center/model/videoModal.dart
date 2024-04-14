class VideoDataModal {
  List<Result>? result;

  VideoDataModal({this.result});

  VideoDataModal.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
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
  String? name;
  String? surname;
  String? employeeId;

  Result(
      {this.id,
        this.title,
        this.vidTitle,
        this.description,
        this.thumbPath,
        this.dirPath,
        this.imgName,
        this.thumbName,
        this.videoLink,
        this.createdBy,
        this.createdAt,
        this.classId,
        this.sectionId,
        this.className,
        this.section,
        this.name,
        this.surname,
        this.employeeId});

  Result.fromJson(Map<String, dynamic> json) {
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
    className = json['className'];
    section = json['section'];
    name = json['name'];
    surname = json['surname'];
    employeeId = json['employee_id'];
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
    data['className'] = this.className;
    data['section'] = this.section;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['employee_id'] = this.employeeId;
    return data;
  }
}
