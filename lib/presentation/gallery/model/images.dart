class ImagesModal {
  ListResult? listResult;

  ImagesModal({this.listResult});

  ImagesModal.fromJson(Map<String, dynamic> json) {
    listResult = json['listResult'] != null
        ? new ListResult.fromJson(json['listResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listResult != null) {
      data['listResult'] = this.listResult!.toJson();
    }
    return data;
  }
}

class ListResult {
  String? id;
  String? type;
  String? slug;
  String? url;
  String? title;
  String? date;
  String? eventStart;
  String? eventEnd;
  String? eventVenue;
  String? description;
  String? isActive;
  String? createdAt;
  String? metaTitle;
  String? metaDescription;
  String? metaKeyword;
  String? featureImage;
  String? publishDate;
  String? publish;
  String? sidebar;
  List<PageContents>? pageContents;

  ListResult(
      {this.id,
        this.type,
        this.slug,
        this.url,
        this.title,
        this.date,
        this.eventStart,
        this.eventEnd,
        this.eventVenue,
        this.description,
        this.isActive,
        this.createdAt,
        this.metaTitle,
        this.metaDescription,
        this.metaKeyword,
        this.featureImage,
        this.publishDate,
        this.publish,
        this.sidebar,
        this.pageContents});

  ListResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    slug = json['slug'];
    url = json['url'];
    title = json['title'];
    date = json['date'];
    eventStart = json['event_start'];
    eventEnd = json['event_end'];
    eventVenue = json['event_venue'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaKeyword = json['meta_keyword'];
    featureImage = json['feature_image'];
    publishDate = json['publish_date'];
    publish = json['publish'];
    sidebar = json['sidebar'];
    if (json['page_contents'] != null) {
      pageContents = <PageContents>[];
      json['page_contents'].forEach((v) {
        pageContents!.add(new PageContents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['slug'] = this.slug;
    data['url'] = this.url;
    data['title'] = this.title;
    data['date'] = this.date;
    data['event_start'] = this.eventStart;
    data['event_end'] = this.eventEnd;
    data['event_venue'] = this.eventVenue;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['meta_keyword'] = this.metaKeyword;
    data['feature_image'] = this.featureImage;
    data['publish_date'] = this.publishDate;
    data['publish'] = this.publish;
    data['sidebar'] = this.sidebar;
    if (this.pageContents != null) {
      data['page_contents'] =
          this.pageContents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PageContents {
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

  PageContents(
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

  PageContents.fromJson(Map<String, dynamic> json) {
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
