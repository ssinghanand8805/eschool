class TransportRoute {
  String? id;
  String? routeTitle;
  Null? noOfVehicle;
  Null? note;
  String? isActive;
  String? createdAt;
  Null? updatedAt;
  List<Vehicles>? vehicles;

  TransportRoute(
      {this.id,
        this.routeTitle,
        this.noOfVehicle,
        this.note,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.vehicles});

  TransportRoute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeTitle = json['route_title'];
    noOfVehicle = json['no_of_vehicle'];
    note = json['note'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['vehicles'] != null) {
      vehicles = <Vehicles>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(new Vehicles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['route_title'] = this.routeTitle;
    data['no_of_vehicle'] = this.noOfVehicle;
    data['note'] = this.note;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.vehicles != null) {
      data['vehicles'] = this.vehicles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vehicles {
  String? vecRouteId;
  String? id;
  String? vehicleNo;
  String? vehicleModel;
  Null? vehiclePhoto;
  String? manufactureYear;
  String? registrationNumber;
  String? chasisNumber;
  String? maxSeatingCapacity;
  String? driverName;
  String? driverLicence;
  String? driverContact;
  String? note;
  String? createdAt;

  Vehicles(
      {this.vecRouteId,
        this.id,
        this.vehicleNo,
        this.vehicleModel,
        this.vehiclePhoto,
        this.manufactureYear,
        this.registrationNumber,
        this.chasisNumber,
        this.maxSeatingCapacity,
        this.driverName,
        this.driverLicence,
        this.driverContact,
        this.note,
        this.createdAt});

  Vehicles.fromJson(Map<String, dynamic> json) {
    vecRouteId = json['vec_route_id'];
    id = json['id'];
    vehicleNo = json['vehicle_no'];
    vehicleModel = json['vehicle_model'];
    vehiclePhoto = json['vehicle_photo'];
    manufactureYear = json['manufacture_year'];
    registrationNumber = json['registration_number'];
    chasisNumber = json['chasis_number'];
    maxSeatingCapacity = json['max_seating_capacity'];
    driverName = json['driver_name'];
    driverLicence = json['driver_licence'];
    driverContact = json['driver_contact'];
    note = json['note'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vec_route_id'] = this.vecRouteId;
    data['id'] = this.id;
    data['vehicle_no'] = this.vehicleNo;
    data['vehicle_model'] = this.vehicleModel;
    data['vehicle_photo'] = this.vehiclePhoto;
    data['manufacture_year'] = this.manufactureYear;
    data['registration_number'] = this.registrationNumber;
    data['chasis_number'] = this.chasisNumber;
    data['max_seating_capacity'] = this.maxSeatingCapacity;
    data['driver_name'] = this.driverName;
    data['driver_licence'] = this.driverLicence;
    data['driver_contact'] = this.driverContact;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    return data;
  }
}
