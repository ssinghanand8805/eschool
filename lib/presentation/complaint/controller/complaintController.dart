import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lerno/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import '../../../core/app_export.dart';
import '../model/getComplaintData.dart';
import '../model/teacherComplaint.dart';

class ComplaintController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  RxList<ComplaintType> complaintModelObj = <ComplaintType>[].obs;
  RxList<ComplaintData> complaintDataList = <ComplaintData>[].obs;
  var selectedComplaint = Rx<ComplaintType?>(null);
  late Future<void> fetchDataFuture;

  final Rx<DateTime> applyDate = DateTime.now().obs;
  Rx<DateTime?> fromDate = Rx<DateTime?>(null);
  Rx<DateTime?> toDate = Rx<DateTime?>(null);
  Rx<TextEditingController> reasonController = TextEditingController().obs;

  Rx<XFile?> image = Rx<XFile?>(null);


  clearController() {
    reasonController.value.clear();
  }

  @override
  void onInit() {
    super.onInit();
    fetchDataFuture = getComplaintData();
  }

  void updateImage(XFile? newImage) {
    image.value = newImage;
  }

  Future<void> saveData(BuildContext context) async {


    if (selectedComplaint.value?.complaintType == null || selectedComplaint.value!.complaintType!.isEmpty) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Please select a complaint type."));
      return;
    }

    if (reasonController.value.text.isEmpty) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Please provide a complaint description."));
      return;
    }

    Map<String, dynamic> body = {
      "student_id": userData.getUserStudentId,
      "complaint_type": selectedComplaint.value?.complaintType,
      "complaint_description": reasonController.value.text,
    };

    if (image.value != null) {
      body["file"] = image.value!.path;
    }

    print("############${body}");

    try {
      var data = await apiRespository.postApiCallByFormData(
          Constants.addComplaintByStudent, body);
      print("############${data.body}");

      if (data.statusCode == 200) {
        Get.showSnackbar( Ui.SuccessSnackBar(message: "Complaint Applied successfully"));
        reasonController.value.clear();
        getComplaintData();
        Navigator.pop(context);
        print("Data saved successfully.");
      } else {
        print("Failed to save data. Status code: ${data.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }

  }

  Future<void> getData() async {
    Map<String, dynamic> body = {};
    print("Body @@@@ ${body}");
    var data = await apiRespository.postApiCallByFormData(
        Constants.getComplainType, body);
    print("DATA @@@@ ${data.body}");
    List<ComplaintType> d = [];

    for (var i = 0; i < data.body['listResult'].length; i++) {
      print("nmjvkjjgkjnnj");
      d.add(ComplaintType.fromJson(data.body['listResult'][i]));
      print("nhbhbhhhbbhhb   $d");
    }
    complaintModelObj.value = d;
    print("111111111111111111111 ${complaintModelObj.length}");

    update();
  }


  Future<void> getComplaintData() async {
    Map<String, dynamic> body = {
      "student_id": userData.getUserStudentId,
    };
    print("Body @@@@ ${body}");

    var response = await apiRespository.postApiCallByJson(Constants.getComplaintByStudent, body);
    print("Response @@@@ ${response.body}");
    if (response.body != null && response.body['data'] != null) {
      List<dynamic> complaintsJson = response.body['data'];
      complaintDataList.value = complaintsJson.map((complaint) => ComplaintData.fromJson(complaint)).toList();
      print("Updated complaints: ${complaintDataList.map((c) => c.toJson()).toList()}");
    } else {
      print("No complaints found or invalid response.");
    }

    update();
  }
}


