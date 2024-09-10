import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lerno/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import 'package:http/http.dart' as http;


class SubmitHomeworkController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  TextEditingController textController = TextEditingController();
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


  Future<void> submitHomework(String id) async {
    try {


      Map<String, dynamic> body = {
        'student_id': userData.getUserStudentId,
        'homework_id': id,
        'message': textController.value.text,
      };


      if (selectedImage != null) {

        body['file'] = selectedImage!.path;
      } else {
        print('No image selected, submitting without image...');
      }
      var data =
      await apiRespository.postApiCallByFormData(Constants.getsubmitHomeWorkByStudent, body);

      if (data.statusCode == 200) {
        print('Homework submitted successfully');

      } else {
        print('Failed to submit homework: ${data.body.toString()}');
      }
    } catch (e) {
      print('Error submitting homework: $e');
    }
  }
}
