import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FollowUpEnquiryController extends GetxController{

  Rx<TextEditingController> followUpDateC = TextEditingController().obs;
  Rx<TextEditingController> nextFollowUpDateC = TextEditingController().obs;
  Rx<TextEditingController> responseC = TextEditingController().obs;
  Rx<TextEditingController> noteC = TextEditingController().obs;

  List demo = [
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
  ];
}

