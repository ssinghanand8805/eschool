import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../common_widgets/controller/CommonUserSelectionController.dart';

class SendSmsController extends GetxController{

  RxList bookList = [].obs;
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<TextEditingController> titleC = TextEditingController().obs;
  Rx<TextEditingController> messageC = TextEditingController().obs;
  Rx<TextEditingController> messageToC = TextEditingController().obs;
  Rx<TextEditingController> templateId = TextEditingController().obs;
  Rx<TextEditingController> searchC = TextEditingController().obs;

  RxMap<String, dynamic> selectedSmsTemplate = <String, dynamic>{}.obs;

  final SendThrough = [
    "SMS",
    "Mobile App",
  ];
  var checkBoxSendThroughState = List<bool>.filled(2, false).obs;
  void toggleSendThroughCheckbox(int index, bool value) {
    checkBoxSendThroughState[index] = value;
  }

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getEmailTemplate();
}
  var checkboxStates = List<bool>.filled(8, false).obs;

  void toggleCheckbox(int index, bool value) {
    checkboxStates[index] = value;
  }

  Future<void> getEmailTemplate() async {

    try {
      var body = {};
      var data =
      await apiRespository.postApiCallByJson(Constants.sms_template, body);
      bookList.value = data.body['data']['sms_template_list'];
      print("all sms_template_list${bookList.value}");
      update();
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

  RxBool isChecked = false.obs;

  RxString selectedData = 'Group'.obs;
  String get getSelectedData => selectedData.value;
  set updateSelectedData(String val) {
    selectedData.value = val;
    update();
  }

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

  sendMessage()
  async {
    var ctrl = Get.put(CommonUserSelectionController());
    Map<String,String> body = {};
    print("eeeeeeee${ctrl.selectedUserType.value.toString()}");
    if(ctrl.selectedUserType.value.toString() == 'group')
    {
      body['group_template_id'] = selectedSmsTemplate.value['id'];
      body['group_title'] = titleC.value.text.toString();
      body['group_message'] = messageC.value.text.toString();

      var SelectedGroup = ctrl.selectedGroup.value;

      body['user'] = SelectedGroup.join(',');
      body['send_type'] = 'send_now';
     String group_send_by = SendThrough
          .asMap()
          .entries
          .where((entry) => checkBoxSendThroughState[entry.key])  // Filter where checkbox is true
          .map((entry) {
        // Replace "Mobile App" with "push", and convert to lowercase
        if (entry.value == "Mobile App") {
          return "push";
        }
        return entry.value.toLowerCase();  // Convert other values to lowercase
      })
          .join(', ');
      body['group_send_by'] = group_send_by;
      // List<MultipartFile> files = [];
      // if(selectedImageName.value != null && await selectedImageName.value!.exists())
      // {
      //
      //   var f = MultipartFile(selectedImageName.value, filename: selectedImageName.value?.path.split('/').last ?? "");
      //   files.add(f);
      // }
      FormData bodyForm = FormData({
      });
      bodyForm.fields.addAll(body.entries);

      var responsebody = await apiRespository.postApiCallByFormData(Constants.send_group_sms, bodyForm);
      print(responsebody.body);
    }
    else if(ctrl.selectedUserType.value.toString() == 'class')
    {
      body['template_id'] = selectedSmsTemplate.value['id'];
      body['class_title'] = titleC.value.text.toString();
      body['class_message'] = messageC.value.text.toString();

      var SelectedClassId = ctrl.selectedClassId.value;
      var selectedSectionId = ctrl.selectedClassSectionId.value;
      body['class_id'] = SelectedClassId;
      body['user'] = selectedSectionId.join(',');
      String class_send_by = SendThrough
          .asMap()
          .entries
          .where((entry) => checkBoxSendThroughState[entry.key])  // Filter where checkbox is true
          .map((entry) {
        // Replace "Mobile App" with "push", and convert to lowercase
        if (entry.value == "Mobile App") {
          return "push";
        }
        return entry.value.toLowerCase();  // Convert other values to lowercase
      })
          .join(', ');
      body['class_send_by'] = class_send_by;
      body['class_send_type'] = 'send_now';

      FormData bodyForm = FormData({});
      bodyForm.fields.addAll(body.entries);

      var responsebody = await apiRespository.postApiCallByFormData(Constants.send_class_sms, bodyForm);
      print(responsebody.body);
    }
    else if(ctrl.selectedUserType.value.toString() == 'individual')
    {
      body['template_id'] = selectedSmsTemplate.value['id'];
      body['individual_title'] = titleC.value.text.toString();
      body['individual_message'] = messageC.value.text.toString();

      var AllUsers = ctrl.selectedUserList.value;
      List us = [];
      for(var i=0;i<AllUsers.length;i++)
      {
        var cateId = ctrl.selectedCategory.value;
        var record_id = AllUsers[i].id;
        var email = AllUsers[i].email;
        var gaurdian_email = AllUsers[i].guardianEmail;
        var mob = AllUsers[i].mobileno;
        var d = {"category":cateId,"record_id":record_id,"email":email,
          "guardianEmail":gaurdian_email,"mobileno":mob};
        us.add(d);

      }
      body['user_list'] = jsonEncode(us);
      String individual_send_by = SendThrough
          .asMap()
          .entries
          .where((entry) => checkBoxSendThroughState[entry.key])  // Filter where checkbox is true
          .map((entry) {
        // Replace "Mobile App" with "push", and convert to lowercase
        if (entry.value == "Mobile App") {
          return "push";
        }
        return entry.value.toLowerCase();  // Convert other values to lowercase
      })
          .join(', ');
      body['individual_send_by'] = individual_send_by;
      body['individual_send_type'] = 'send_now';
      List<MultipartFile> files = [];

      FormData bodyForm = FormData({});
      bodyForm.fields.addAll(body.entries);

      var responsebody = await apiRespository.postApiCallByFormData(Constants.send_individual_sms, bodyForm);
      print(responsebody.body);

    }
  }


}