class FCMNotifications {
  String? title;
  String? body;
  String? timestamp;
  bool? read;

  FCMNotifications({this.title, this.body, this.timestamp, this.read});

  FCMNotifications.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    timestamp = json['timestamp'];
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['timestamp'] = this.timestamp;
    data['read'] = this.read;
    return data;
  }
}