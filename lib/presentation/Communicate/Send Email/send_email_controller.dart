
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../common_widgets/controller/CommonUserSelectionController.dart';

class SendEmailController extends GetxController {
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<TextEditingController> titleC = TextEditingController().obs;
  Rx<TextEditingController> messageC = TextEditingController().obs;
  Rx<File?> selectedImageName = Rx<File?>(null);
  RxList bookList = [].obs;

  RxMap<String, dynamic> selectedSmsTemplate = <String, dynamic>{}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getEmailTemplate();
  }

  void clearImage() {
    selectedImageName.value = null;
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
  Future<void> getEmailTemplate() async {

    try {
      var body = {};
      var data =
      await apiRespository.postApiCallByJson(Constants.email_template, body);
      bookList.value = data.body['data']['email_template_list'];

      print("all email_template_list${bookList.value}");
      update();
    } catch (e) {
      print("email_template_list${e}");
      update();
    }
  }

  var checkboxStates = List<bool>.filled(8, false).obs;

  void toggleCheckbox(int index, bool value) {
    checkboxStates[index] = value;
  }


  RxBool isChecked = false.obs;

  RxString selectedData = 'Group'.obs;
  String get getSelectedData => selectedData.value;
  set updateSelectedData(String val) {
    selectedData.value = val;
    update();
  }

  var checkBoxSectionState = List<bool>.filled(4, false).obs;
  void toggleSectionCheckbox(int index, bool value) {
    checkBoxSectionState[index] = value;
  }

  Rx<TextEditingController> searchC = TextEditingController().obs;
  Rx<TextEditingController> messageToC = TextEditingController().obs;


  sendEmail()
  async {
   var ctrl = Get.put(CommonUserSelectionController());
   Map<String,String> body = {};
   print("eeeeeeee${ctrl.selectedUserType.value.toString()}");
   if(ctrl.selectedUserType.value.toString() == 'group')
     {
       body['template_id'] = selectedSmsTemplate.value['id'];
       body['group_title'] = titleC.value.text.toString();
       body['group_message'] = messageC.value.text.toString();

       var SelectedGroup = ctrl.selectedGroup.value;

       body['user'] = SelectedGroup.join(',');
       body['group_send_by'] = 'email';
       body['send_type'] = 'send_now';
       List<MultipartFile> files = [];
       if(selectedImageName.value != null && await selectedImageName.value!.exists())
       {

         var f = MultipartFile(selectedImageName.value, filename: selectedImageName.value?.path.split('/').last ?? "");
         files.add(f);
       }
       FormData bodyForm = FormData({
         'files[]': files,
       });
       bodyForm.fields.addAll(body.entries);

       var responsebody = await apiRespository.postApiCallByFormData(Constants.send_group, bodyForm);
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
     body['class_send_by'] = 'email';
     body['class_send_type'] = 'send_now';
     List<MultipartFile> files = [];
     if(selectedImageName.value != null && await selectedImageName.value!.exists())
     {

       var f = MultipartFile(selectedImageName.value, filename: selectedImageName.value?.path.split('/').last ?? "");
       files.add(f);
     }
     FormData bodyForm = FormData({
       'files[]': files,
     });
     bodyForm.fields.addAll(body.entries);

     var responsebody = await apiRespository.postApiCallByFormData(Constants.send_class, bodyForm);
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
         var guardian_email = AllUsers[i].guardianEmail;
         var mob = AllUsers[i].mobileno;
         var d = {
           "category":cateId,"record_id":record_id,"email":email,
           "guardianEmail":guardian_email,"mobileno":mob
         };
         us.add(d);

       }

     body['user_list'] = jsonEncode(us);
     body['individual_send_by'] = 'email';
     body['individual_send_type'] = 'send_now';
     List<MultipartFile> files = [];
     if(selectedImageName.value != null && await selectedImageName.value!.exists())
     {

       var f = MultipartFile(selectedImageName.value, filename: selectedImageName.value?.path.split('/').last ?? "");
       files.add(f);
     }
     FormData bodyForm = FormData({
       'files[]': files,
     });
     bodyForm.fields.addAll(body.entries);

     var responsebody = await apiRespository.postApiCallByFormData(Constants.send_individual, bodyForm);
     print(responsebody.body);

   }
  }


}