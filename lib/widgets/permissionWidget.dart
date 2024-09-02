import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionWidget extends StatefulWidget {
  final String routeName;
  final String permissionType;
  final Widget childWidget;
  const PermissionWidget({
    Key? key,
    required this.routeName,
    required this.permissionType,
    required this.childWidget,
  }) : super(key: key);

  @override
  State<PermissionWidget> createState() => _PermissionWidgetState();
}

class _PermissionWidgetState extends State<PermissionWidget> {
  late Future<bool> _permissionFuture;

  @override
  void initState() {
    super.initState();
    _permissionFuture = chekPermssion();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _permissionFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink(); // You can show a loader or placeholder here
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data == true) {
          print("######");
          return widget.childWidget;
        } else {
          return SizedBox.shrink(); // Hide the widget if no permission
        }
      },
    );
  }

  Future<bool> chekPermssion() async {
    final prefs = await SharedPreferences.getInstance();
    var per = prefs.getString('pagePermission');
    if (per != null) {

      List permArr = jsonDecode(per);
      var perm = permArr.firstWhere((element) => element['route_name'] == widget.routeName);

      if (perm[widget.permissionType] == true) {
        return true;
      }
    }
    return false;
  }
}
