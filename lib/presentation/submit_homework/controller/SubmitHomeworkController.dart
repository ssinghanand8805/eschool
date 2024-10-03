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

  Rx<XFile?> image = Rx<XFile?>(null);



  void updateImage(XFile? newImage) {
    image.value = newImage;
  }

  Future<void> submitHomework(String id, BuildContext context) async {
    try {
      if (homeWorkMessageC.value.text.isEmpty) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: "Message is required"));
        return;
      }

      Map<String, dynamic> body = {
        'student_id': userData.getUserStudentId,
        'homework_id': id,
        'message': homeWorkMessageC.value.text,
      };

      if (image != null) {
        body['file'] = image!.value;
      } else {
        print('No image selected, submitting without image...');
      }

      var data = await apiRespository.postApiCallByFormData(
          Constants.submitHomeWorkByStudent, body);

      if (data.statusCode == 200) {
        Get.showSnackbar( Ui.SuccessSnackBar(message: "Homework submitted successfully"));
        homeWorkMessageC.clear();

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
      if ( assignmentTitleC.value.text.isEmpty) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: "Tittle is required"));
        return;
      }

      Map<String, dynamic> body = {
        'student_id': userData.getUserStudentId,
        'homework_id': id,
        'subject_id': subjectGroupSubjectId,
        'description': assignmentMessageC.value.text,
        'title': assignmentTitleC.value.text,
      };

      if (image != null) {
        body['file'] = image!.value;
      } else {
        print('No image selected, submitting without image...');
      }
      var data = await apiRespository.postApiCallByFormData(
          Constants.adddailyassignment, body);

      if (data.statusCode == 200) {
        Get.showSnackbar(Ui.SuccessSnackBar(message: "Assignment submitted successfully"));
        assignmentTitleC.clear();
        assignmentMessageC.clear();

        Navigator.pop(context);
        print('Assignment submitted successfully');
      } else {
        print('Failed to submit Assignment: ${data.body.toString()}');
      }
    } catch (e) {
      print('Error submitting Assignment: $e');
    }
  }
}
