import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class NewMessageController extends GetxController{

  Rx<TextEditingController> titleC = TextEditingController().obs;
  Rx<TextEditingController> noticeDateC = TextEditingController().obs;
  Rx<TextEditingController> publishOnC = TextEditingController().obs;
  Rx<HtmlEditorController> messageC = HtmlEditorController().obs;

  final roles = [
    'Student',
    'Parent',
    'Admin',
    'Teacher',
    'Accountant',
    'Librarian',
    'Receptionist',
    'Super Admin',
  ];

  var checkboxStates = List<bool>.filled(8, false).obs;

  void toggleCheckbox(int index, bool value) {
    checkboxStates[index] = value;
  }


}