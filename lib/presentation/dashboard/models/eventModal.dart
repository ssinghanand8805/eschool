class EventModal {
  String? id;
  String? type;
  String? slug;
  String? url;
  String? title;
  Null? date;
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
  Null? publishDate;
  String? publish;
  Null? sidebar;

  EventModal(
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

  EventModal.fromJson(Map<String, dynamic> json) {
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
