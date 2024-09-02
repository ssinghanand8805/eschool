import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../apiHelper/Constants.dart';
import '../../../../apiHelper/popular_product_repo.dart';
import '../../../../apiHelper/userData.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import '../../common_widgets/controller/CommonController.dart';
import '../model/ApproveLeave.dart';



class ApproveLeaveController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  RxList<Resultlist> approveLeaveList = <Resultlist>[].obs;
  RxList<StudentList> students = <StudentList>[].obs;
  Rx<TextEditingController> applyLeaveDateController = TextEditingController().obs;
  Rx<TextEditingController> fromDateController = TextEditingController().obs;
  Rx<TextEditingController> toDateController = TextEditingController().obs;
  Rx<TextEditingController> reasonController = TextEditingController().obs;
  Rx<String> selectedStatus = "Approve".obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<Resultlist> filteredStudentListModel = <Resultlist>[].obs;
  Rx<bool> isLoadingStudentList = false.obs;

  @override
  void onClose() {
    super.onClose();

  }

  // Retrieve events by date

  @override
  void onInit() {
    super.onInit();

    searchController.value.addListener(() {
      filterStudentList();
    });

   //getDataFromApi( now);// Initialize the future when the controller is created
  }
  void filterStudentList() {
    final query = searchController.value.text.toLowerCase();

    if (query.isEmpty) {
      filteredStudentListModel.assignAll(approveLeaveList);
      print("all List Length: ${approveLeaveList.value.length}");
    } else {
      final filteredList = approveLeaveList.where((student) {
        return student.firstname?.toLowerCase().contains(query) ?? false;
      }).toList();

      print("Filtered List Length: ${filteredList.length}"); // Debugging line

      filteredStudentListModel.assignAll(filteredList);
    }

    update();
  }
  filterData() async {

    CommonApiController commonApiController = Get.put(CommonApiController());
    print(commonApiController.selectedClassId.value);
    print(commonApiController.selectedSectionId.value);

    if(commonApiController.selectedClassId.value.isNotEmpty && commonApiController.selectedSectionId.value.isNotEmpty)
    {


      var body = {
        "class_id": commonApiController.selectedClassId.value,
        "section_id": commonApiController.selectedSectionId.value
      };
      print("Body @@@@ ${body}");
      var data = await apiRespository.postApiCallByJson(
          Constants.getApprove_leaveUrl, body);
      print("DATA @@@@ ${data.body}");
      ApproveLeave ss = ApproveLeave.fromJson(data.body);
      approveLeaveList.value.assignAll(ss.resultlist!);
      students.value.assignAll(ss.studentList!);
      filteredStudentListModel.assignAll(ss.resultlist!);

      update();
    }
    else
    {
      print("Filter Data not valid");
    }


  }



}
