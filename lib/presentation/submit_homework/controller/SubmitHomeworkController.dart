import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lerno/apiHelper/toastMessage.dart';
import 'package:lerno/apiHelper/userData.dart';
import 'package:lerno/core/utils/common_utilities.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import 'package:http/http.dart' as http;

class SubmitHomeworkController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  TextEditingController homeWorkMessageC = TextEditingController();
  TextEditingController assignmentMessageC = TextEditingController();
  TextEditingController assignmentTitleC = TextEditingController();
  // Rx<NotiiceBoard> noticeBoardModelObj = NotiiceBoard().obs;
  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();

    // fetchDataFuture = getData(); // Initialize the future when the controller is created
  }

  File? selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      update();
    }
    update();
  }

  Future<void> submitHomework(String id,BuildContext context,) async {
    try {
      Map<String, dynamic> body = {
        'student_id': userData.getUserStudentId,
        'homework_id': id,
        'message': homeWorkMessageC.value.text,
      };

      if (selectedImage != null) {
        body['file'] = selectedImage!.path;
      } else {
        print('No image selected, submitting without image...');
      }
      var data = await apiRespository.postApiCallByFormData(
          Constants.submitHomeWorkByStudent, body);

      if (data.statusCode == 200) {

        homeWorkMessageC.clear();
        Ui.SuccessSnackBar(message: "Assignment submitted successfully");
        Navigator.pop(context);

        print('Homework submitted successfully');
      } else {
        print('Failed to submit homework: ${data.body.toString()}');
      }
    } catch (e) {
      print('Error submitting homework: $e');
    }
  }

  Future<void> submitAssignment(BuildContext context,String id, String subjectGroupSubjectId) async {
    try {
      Map<String, dynamic> body = {
        'student_id': userData.getUserStudentId,
        'homework_id': id,
        'subject_id': subjectGroupSubjectId,
        'description': assignmentMessageC.value.text,
        'title': assignmentTitleC.value.text,
      };

      if (selectedImage != null) {
        body['file'] = selectedImage!.path;
      } else {
        print('No image selected, submitting without image...');
      }
      var data = await apiRespository.postApiCallByFormData(
          Constants.adddailyassignment, body);

      if (data.statusCode == 200) {
        assignmentTitleC.clear();
        assignmentMessageC.clear();
        selectedImage = null;
        Ui.SuccessSnackBar(message: "Assignment submitted successfully");
        Navigator.pop(context);
        print('Homework submitted successfully');
      } else {
        print('Failed to submit homework: ${data.body.toString()}');
      }
    } catch (e) {
      print('Error submitting homework: $e');
    }
  }
}
