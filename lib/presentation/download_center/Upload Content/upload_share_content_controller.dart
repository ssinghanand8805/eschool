import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UploadShareContentController extends GetxController{

  TextEditingController searchC = TextEditingController();
  TextEditingController videoLinkC = TextEditingController();

  Rx<File?> image = Rx<File?>(null);

  List aaa = [
    {
      'name':"Faheem"
    },
    {
      'name':"Faheem"
    },
    {
      'name':"Faheem"
    },
  ];

  bool isChecked = false;
  bool get getIsChecked => isChecked;
  set updateIsChecked(bool val){
    isChecked = val;
    update();
  }

}