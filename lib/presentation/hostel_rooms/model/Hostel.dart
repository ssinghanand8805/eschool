class Hostel {
  List<Hostelarray>? hostelarray;

  Hostel({this.hostelarray});

  Hostel.fromJson(Map<String, dynamic> json) {
    if (json['hostelarray'] != null) {
      hostelarray = <Hostelarray>[];
      json['hostelarray'].forEach((v) {
        hostelarray!.add(new Hostelarray.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hostelarray != null) {
      data['hostelarray'] = this.hostelarray!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hostelarray {
  String? id;
  String? hostelId;
  String? roomTypeId;
  String? roomNo;
  String? noOfBed;
  String? costPerBed;
  String? title;
  String? description;
  String? createdAt;
  String? hostelName;
  String? roomType;
  int? assign;

  Hostelarray(
      {this.id,
        this.hostelId,
        this.roomTypeId,
        this.roomNo,
        this.noOfBed,
        this.costPerBed,
        this.title,
        this.description,
        this.createdAt,
        this.hostelName,
        this.roomType,
        this.assign});

  Hostelarray.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hostelId = json['hostel_id'];
    roomTypeId = json['room_type_id'];
    roomNo = json['room_no'];
    noOfBed = json['no_of_bed'];
    costPerBed = json['cost_per_bed'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    hostelName = json['hostel_name'];
    roomType = json['room_type'];
    assign = json['assign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hostel_id'] = this.hostelId;
    data['room_type_id'] = this.roomTypeId;
    data['room_no'] = this.roomNo;
    data['no_of_bed'] = this.noOfBed;
    data['cost_per_bed'] = this.costPerBed;
    data['title'] = this.title;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['hostel_name'] = this.hostelName;
    data['room_type'] = this.roomType;
    data['assign'] = this.assign;
    return data;
  }
}