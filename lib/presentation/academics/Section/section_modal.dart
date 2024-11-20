class SectionListDataModal {
  int? status;
  String? error;
  Data? data;

  SectionListDataModal({this.status, this.error, this.data});

  SectionListDataModal.fromJson(Map<String, dynamic> json) {
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
  List<Sectionlist>? sectionlist;

  Data({this.sectionlist});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sectionlist'] != null) {
      sectionlist = <Sectionlist>[];
      json['sectionlist'].forEach((v) {
        sectionlist!.add(new Sectionlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sectionlist != null) {
      data['sectionlist'] = this.sectionlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sectionlist {
  String? id;
  String? section;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  Sectionlist(
      {this.id, this.section, this.isActive, this.createdAt, this.updatedAt});

  Sectionlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    section = json['section'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['section'] = this.section;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
