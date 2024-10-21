class ContentTypeModal {
  String? status;
  String? error;
  String? message;
  List<Data>? data;

  ContentTypeModal({this.status, this.error, this.message, this.data});

  ContentTypeModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    message = json['message'];

    if (json['data'] != null) {
      // Check if 'data' is a list or a single object
      if (json['data'] is List) {
        // If it's a list, parse each item
        data = <Data>[];
        json['data'].forEach((v) {
          data!.add(Data.fromJson(v));
        });
      } else if (json['data'] is Map) {
        // If it's a single object, convert it to a list with one element
        data = <Data>[];
        data!.add(Data.fromJson(json['data']));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Data {
  String? id;
  String? name;
  String? description;

  Data({this.id, this.name, this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
