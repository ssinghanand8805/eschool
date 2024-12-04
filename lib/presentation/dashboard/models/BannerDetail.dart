class BannerDetails {
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
  String? inAppDisplayEnable;
  String? inAppDisplayFrequency;
  String? inAppDisplayFrom;
  String? inAppDisplayTo;

  BannerDetails(
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
        this.inAppDisplayEnable,
        this.inAppDisplayFrequency,
        this.inAppDisplayFrom,
        this.inAppDisplayTo});

  BannerDetails.fromJson(Map<String, dynamic> json) {
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
    inAppDisplayEnable = json['in_app_display_enable'];
    inAppDisplayFrequency = json['in_app_display_frequency'];
    inAppDisplayFrom = json['in_app_display_from'];
    inAppDisplayTo = json['in_app_display_to'];
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
    data['in_app_display_enable'] = this.inAppDisplayEnable;
    data['in_app_display_frequency'] = this.inAppDisplayFrequency;
    data['in_app_display_from'] = this.inAppDisplayFrom;
    data['in_app_display_to'] = this.inAppDisplayTo;
    return data;
  }
}
