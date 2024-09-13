import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lerno/apiHelper/userData.dart';
import 'package:lerno/presentation/common_widgets/custom_loader.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/complaintModal.dart';
import '../model/teacherComplaint.dart';

class ComplaintController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  RxList<ComplaintType> complaintModelObj = <ComplaintType>[].obs;
  var selectedComplaint = Rx<ComplaintType?>(null);
  late Future<void> fetchDataFuture;

  final Rx<DateTime> applyDate = DateTime.now().obs;
  Rx<DateTime?> fromDate = Rx<DateTime?>(null);
  Rx<DateTime?> toDate = Rx<DateTime?>(null);
  Rx<TextEditingController> reasonController = TextEditingController().obs;

  Rx<File?> image = Rx<File?>(null);

  @override
  void onClose() {
    super.onClose();
    Get.delete<ComplaintController>();
  }

  clearController() {
    reasonController.value.clear();
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> saveData() async {
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
      print("nhbhbhhhbbhhb");
    }
    complaintModelObj.value = d;
    print("111111111111111111111 ${complaintModelObj.value}");
    update();
  }
}
