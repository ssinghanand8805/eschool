class GalleryModal {
  int? status;
  String? error;
  Data? data;

  GalleryModal({this.status, this.error, this.data});

  GalleryModal.fromJson(Map<String, dynamic> json) {
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
  List<ListResult>? listResult;

  Data({this.listResult});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['listResult'] != null) {
      listResult = <ListResult>[];
      json['listResult'].forEach((v) {
        listResult!.add(new ListResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listResult != null) {
      data['listResult'] = this.listResult!.map((v) => v.toJson()).toList();
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
  Null? date;
  Null? eventStart;
  Null? eventEnd;
  Null? eventVenue;
  String? description;
  String? isActive;
  String? createdAt;
  String? metaTitle;
  String? metaDescription;
  String? metaKeyword;
  String? featureImage;
  Null? publishDate;
  String? publish;
  Null? sidebar;

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
        this.sidebar});

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
    return data;
  }
}
