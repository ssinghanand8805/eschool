
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class SendEmailController extends GetxController{

  List demo = [
    {
      "name":"Faheem"
    },
    {
      "name":"Faheem"
    },
    {
      "name":"Faheem"
    },
    {
      "name":"Faheem"
    },
  ];
  Rx<TextEditingController> titleC = TextEditingController().obs;
  Rx<HtmlEditorController> messageC = HtmlEditorController().obs;

  RxString selectedOption = 'Send Now'.obs;
  Rx<TimeOfDay>? selectedTime;

  void selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
        selectedTime!.value = picked;
    }
  }


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

  List groups = [

       "Group",
    "individual",
     "class",
      "Today's Birthday"
  ];

  RxBool isChecked = false.obs;

  RxString selectedData = 'Group'.obs;
  String get getSelectedData => selectedData.value;
  set updateSelectedData(String val) {
    selectedData.value = val;
    update();
  }

  final section = [
    "A",
    "B",
    "C",
    "D",
  ];
  var checkBoxSectionState = List<bool>.filled(4, false).obs;
  void toggleSectionCheckbox(int index, bool value) {
    checkBoxSectionState[index] = value;
  }

  Rx<TextEditingController> searchC = TextEditingController().obs;



}