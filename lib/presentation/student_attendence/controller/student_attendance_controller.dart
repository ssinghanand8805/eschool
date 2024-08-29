import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../apiHelper/Constants.dart';
import '../../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/userData.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import '../model/Student_Attendance.dart';



class StudentAttendanceController extends GetxController {

  Rx<TextEditingController> attendanceDate = TextEditingController().obs;
  final Rx<DateTime> applyDate = DateTime.now().obs;
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<String> year = "".obs;
  Rx<String> month = "".obs;
  Rx<bool> isLoadingStudentList = false.obs;
  Rx<bool> isSearchExpand = true.obs;
  RxList<Student> studentListModel = <Student>[].obs;
  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();

  }

  @override
  void onInit() {
    super.onInit();


    DateTime now = DateTime.now();
    getData();
    //getDataFromApi( now);// Initialize the future when the controller is created
  }


  Future<void> getData() async
  {
    CommonApiController controller3 =
    Get.put(CommonApiController());
    controller3.getClassList();
    update();
  }

}
