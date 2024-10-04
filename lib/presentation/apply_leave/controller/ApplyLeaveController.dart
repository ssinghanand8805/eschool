import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lerno/apiHelper/userData.dart';
import 'package:lerno/presentation/common_widgets/custom_loader.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import '../../../core/app_export.dart';
import '../model/ApplyLeave.dart';

class ApplyLeaveController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<ApplyLeave> applyLeaveModelObj = ApplyLeave().obs;
  late Future<void> fetchDataFuture;

  final Rx<DateTime> applyDate = DateTime.now().obs;
  Rx<DateTime?> fromDate = Rx<DateTime?>(null);
  Rx<DateTime?> toDate = Rx<DateTime?>(null);
  Rx<TextEditingController> reasonController = TextEditingController().obs;
  Rx<TextEditingController> applyDateController = TextEditingController().obs;
  Rx<TextEditingController> fromDateController = TextEditingController().obs;
  Rx<TextEditingController> toDateController = TextEditingController().obs;

  Rx<XFile?> image = Rx<XFile?>(null);



  void updateImage(XFile? newImage) {
    image.value = newImage;
  }


  @override
  void onClose() {
    super.onClose();
    Get.delete<ApplyLeaveController>();
  }

  clearController() {
    reasonController.value.clear();
    applyDateController.value.clear();
    fromDateController.value.clear();
    toDateController.value.clear();
    image.value = null;
  }

  @override
  void onInit() {
    super.onInit();
    fetchDataFuture =
        getData();
    clearController();

  }

  saveData() async {
    if (applyDateController.value.value.text.isEmpty) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Please select an apply date."));
      return;
    }

    if (fromDateController.value.value.text.isEmpty) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Please select a from date."));
      return;
    }

    if (toDateController.value.value.text.isEmpty) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Please select a to date."));
      return;
    }

    if (reasonController.value.value.text.isEmpty) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Please provide a reason."));
      return;
    }

    if (image.value == null || image.value!.path.isEmpty) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Please select an image."));
      return;
    }

    Map<String, dynamic> body = {
      "student_id": userData.getUserStudentId,
      "apply_date": applyDateController.value.value.text,
      "from_date": fromDateController.value.value.text,
      "to_date": toDateController.value.value.text,
      "reason": reasonController.value.value.text,
      "file": image.value!.path
    };

    print("############$body");

    // Make API call
    var data = await apiRespository.postApiCallByFormData(Constants.addleaveUrl, body);
    print("############${data.body}");

    // If the API call is successful, fetch the data and clear the controllers
    if (data.statusCode == 200) {


      Get.back();
      clearController();
      getData();
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Leave Applied successfully"));
    }
    update();
  }


  Future<void> getData() async {
    Map<String, dynamic> body = {"student_id": userData.getUserStudentId};
    print("Body @@@@ ${body}");
    var data = await apiRespository.postApiCallByJson(
        Constants.getApplyLeaveUrl, body);
    print("DATA @@@@ ${data.body}");
    print("111111111111111111111 ${applyLeaveModelObj.value.toJson()}");
    applyLeaveModelObj.value = ApplyLeave.fromJson(data.body);
    print("111111111111111111111 ${applyLeaveModelObj.value.toJson()}");
    update();
  }
}
