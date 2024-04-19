class Menus {
  List<MenuResponse>? response;

  Menus({this.response});

  Menus.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <MenuResponse>[];
      json['response'].forEach((v) {
        response!.add(new MenuResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<MenuResponse> getResponsesWhereCanView() {
    List<MenuResponse> filteredResponses = [];
    if (this.response != null) {
      for (MenuResponse res in this.response!) {
        for (PermissionCategory perm in res.permissionCategory ?? []) {
          if (perm.canView == "1") {
            filteredResponses.add(res);
            break; // Add each Response only once and break after the first match
          }
        }
      }
    }
    return filteredResponses;
  }
}

class MenuResponse {
  String? id;
  String? name;
  String? shortCode;
  String? isActive;
  String? system;
  String? createdAt;
  List<PermissionCategory>? permissionCategory;

  MenuResponse(
      {this.id,
        this.name,
        this.shortCode,
        this.isActive,
        this.system,
        this.createdAt,
        this.permissionCategory});

  MenuResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortCode = json['short_code'];
    isActive = json['is_active'];
    system = json['system'];
    createdAt = json['created_at'];
    if (json['permission_category'] != null) {
      permissionCategory = <PermissionCategory>[];
      json['permission_category'].forEach((v) {
        permissionCategory!.add(new PermissionCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['short_code'] = this.shortCode;
    data['is_active'] = this.isActive;
    data['system'] = this.system;
    data['created_at'] = this.createdAt;
    if (this.permissionCategory != null) {
      data['permission_category'] =
          this.permissionCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }


}

class PermissionCategory {
  String? id;
  String? permGroupId;
  String? name;
  String? shortCode;
  String? enableView;
  String? enableAdd;
  String? enableEdit;
  String? enableDelete;
  String? createdAt;
  String? rolesPermissionsId;
  String? canView;
  String? canAdd;
  String? canEdit;
  String? canDelete;

  PermissionCategory(
      {this.id,
        this.permGroupId,
        this.name,
        this.shortCode,
        this.enableView,
        this.enableAdd,
        this.enableEdit,
        this.enableDelete,
        this.createdAt,
        this.rolesPermissionsId,
        this.canView,
        this.canAdd,
        this.canEdit,
        this.canDelete});

  PermissionCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    permGroupId = json['perm_group_id'];
    name = json['name'];
    shortCode = json['short_code'];
    enableView = json['enable_view'];
    enableAdd = json['enable_add'];
    enableEdit = json['enable_edit'];
    enableDelete = json['enable_delete'];
    createdAt = json['created_at'];
    rolesPermissionsId = json['roles_permissions_id'];
    canView = json['can_view'];
    canAdd = json['can_add'];
    canEdit = json['can_edit'];
    canDelete = json['can_delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['perm_group_id'] = this.permGroupId;
    data['name'] = this.name;
    data['short_code'] = this.shortCode;
    data['enable_view'] = this.enableView;
    data['enable_add'] = this.enableAdd;
    data['enable_edit'] = this.enableEdit;
    data['enable_delete'] = this.enableDelete;
    data['created_at'] = this.createdAt;
    data['roles_permissions_id'] = this.rolesPermissionsId;
    data['can_view'] = this.canView;
    data['can_add'] = this.canAdd;
    data['can_edit'] = this.canEdit;
    data['can_delete'] = this.canDelete;
    return data;
  }


}