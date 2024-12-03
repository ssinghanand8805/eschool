import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';

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
  var checkBoxSendThroughState = List<bool>.filled(4, false).obs;
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
}