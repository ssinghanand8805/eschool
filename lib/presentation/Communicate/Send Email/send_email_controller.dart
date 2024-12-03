
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';

class SendEmailController extends GetxController{
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<TextEditingController> titleC = TextEditingController().obs;
  Rx<HtmlEditorController> messageC = HtmlEditorController().obs;
  Rx<File?> selectedImageName = Rx<File?>(null);
  RxList bookList = [].obs;


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



}