import 'dart:convert';
import 'dart:developer';

import 'package:lerno/apiHelper/userData.dart';
import 'package:lerno/presentation/login_screen/models/userDataModal.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../../dashboard/dashboard_screen.dart';
import '../model/CbseExaminations.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class CbseExaminationsController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  RxList<Exams> cbseResultModelObj = <Exams>[].obs;

  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchDataFuture = getCBSEExamResult();
  }

  getCBSEExamResult() async {
    try {
      Map<String, dynamic> body = {
        "student_session_id": userData.getStudent_session_id,
      };

      var response = await apiRespository.postApiCallByJson(
        Constants.getCbseexamresultUrlNew,
        body,
      );

      print("Request Body: $body");
      print("Response Body: ${response.body}");

      if (response.body != null && response.body['exams'] != null) {
        cbseResultModelObj.clear();

        for (var examJson in response.body['exams']) {
          try {
            Exams exams = Exams.fromJson(examJson);
            // Exam examModel = Exam(exams: [exams]);
            cbseResultModelObj.add(exams);
           // print("Parsed Exam: ${examModel.toJson()}");
          } catch (e) {
            log("Error parsing exam JSON: $examJson\nError: $e");
          }
        }

        update();
      } else {
        log("Error: 'exams' data not found in the response.");
      }
    } catch (e) {
      log("Error occurred while fetching CBSE Exam results: ${e.toString()}");
    }
  }


// getCBSEEXamResult() async {
  //   Map<String, dynamic> body = {
  //     "student_session_id": userData.getStudent_session_id
  //   };
  //
  //   var data = await apiRespository.postApiCallByJson(
  //       Constants.getCbseexamresultUrlNew, body);
  //   print("body @@@$body");
  //   for (var i = 0; i < data.body!['exams'].length; i++) {
  //     print("getdailyassignmentUrl ${data.body}");
  //     var d = Exam.fromJson(data.body!['exams'][i]);
  //     cbseResultModelObj.value.add(d);
  //
  //     print("getCBSEEXamResult${d}");
  //   }
  //   update();
  //
  //   log("####### ${cbseResultModelObj.toJson()}");
  // }
}
