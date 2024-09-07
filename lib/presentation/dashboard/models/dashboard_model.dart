import 'package:flutter/cupertino.dart';

/// This class defines the variables used in the [form_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class DashboardModel {
}

class MenuItems{
  String? label;
  Icon?itemIcon;

  MenuItems({
    this.label,
    this.itemIcon
});

}

class ELearningDataModel {
  List<ModuleList>? moduleList;

  ELearningDataModel({this.moduleList});

  ELearningDataModel.fromJson(Map<String, dynamic> json) {
    if (json['module_list'] != null) {
      moduleList = <ModuleList>[];
      json['module_list'].forEach((v) {
        moduleList!.add(new ModuleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.moduleList != null) {
      data['module_list'] = this.moduleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ModuleList {
  String? name;
  String? shortCode;
  dynamic status;

  ModuleList({this.name, this.shortCode, this.status});

  ModuleList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    shortCode = json['short_code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['short_code'] = this.shortCode;
    data['status'] = this.status;
    return data;
  }
}


class AcademicModuleDataModel {
  List<ModuleList>? moduleList;

  AcademicModuleDataModel({this.moduleList});

  AcademicModuleDataModel.fromJson(Map<String, dynamic> json) {
    if (json['module_list'] != null) {
      moduleList = <ModuleList>[];
      json['module_list'].forEach((v) {
        moduleList!.add(new ModuleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.moduleList != null) {
      data['module_list'] = this.moduleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
