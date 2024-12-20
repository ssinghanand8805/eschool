import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../apiHelper/Constants.dart';
import '../../../../apiHelper/popular_product_repo.dart';
import '../../../../apiHelper/userData.dart';
import '../../../apiHelper/toastMessage.dart';
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
  Rx<String> selectedStatus = "0".obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<Resultlist> filteredStudentListModel = <Resultlist>[].obs;
  Rx<bool> isLoadingStudentList = false.obs;
  Rx<File?> pickedFile = Rx<File?>(null);
  Rx<String> selectedStudent = "".obs;



  Rx<EditApproveLeave> editLeave = EditApproveLeave(studentList: [],resultlist: Resultlist(id: '', studentSessionId: '', fromDate: '',toDate : '',applyDate : '',
      status : '',docs : '',reason : '',approveBy : '',
      approveDate : '',requestType : '',createdAt : '',applyLeaveStatus : '',firstname : '',middlename : '',lastname : '',
      staffId : '',staffName : '',studId : '',admissionNo : '',surname : '',classId : '',sectionId : '',className : '',section : '')).obs;

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
try{
  isLoadingStudentList.value = true;
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

    filteredStudentListModel.assignAll(ss.resultlist!);
    isLoadingStudentList.value = false;
    update();
  }
  else
  {
    isLoadingStudentList.value = false;
    print("Filter Data not valid");
    Get.showSnackbar(Ui.ErrorSnackBar(message: "Filter Data not valid"));
    update();
  }
}
catch(e)
    {
      isLoadingStudentList.value = false;
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      update();
    }




  }


  editData(id) async {

    CommonApiController commonApiController = Get.put(CommonApiController());
    print(commonApiController.selectedClassId.value);
    print(commonApiController.selectedSectionId.value);

    if(commonApiController.selectedClassId.value.isNotEmpty && commonApiController.selectedSectionId.value.isNotEmpty)
    {


      var body = {
        "class_id": commonApiController.selectedClassId.value,
        "section_id": commonApiController.selectedSectionId.value,
        "id":id,
      };
      print("Body @@@@ ${body}");
      var data = await apiRespository.postApiCallByJson(
          Constants.getApprove_leave_byIdUrl, body);
      print("DATA @@@@ ${data.body}");
      EditApproveLeave ss = EditApproveLeave.fromJson(data.body);
      editLeave.value = ss;
      applyLeaveDateController.value.text = DateFormat('dd/MM/yyyy').format(DateTime.parse(ss.resultlist!.applyDate!));
      fromDateController.value.text = DateFormat('dd/MM/yyyy').format(DateTime.parse(ss.resultlist!.fromDate!));
      toDateController.value.text = DateFormat('dd/MM/yyyy').format(DateTime.parse(ss.resultlist!.toDate!));
      reasonController.value.text = ss.resultlist!.reason!;
      selectedStatus.value = ss.resultlist!.status!;
      selectedStudent.value = ss.resultlist!.studentSessionId!;
      students.value.assignAll(ss.studentList!);
      update();
    }
    else
    {
      print("Filter Data not valid");
    }


  }
  getStudentsByClass() async {

    CommonApiController commonApiController = Get.put(CommonApiController());
    print(commonApiController.selectedClassId.value);
    print(commonApiController.selectedSectionId.value);

    if(commonApiController.selectedClassId.value.isNotEmpty && commonApiController.selectedSectionId.value.isNotEmpty)
    {


      var body = {
        "class_id": commonApiController.selectedClassId.value,
        "section_id": commonApiController.selectedSectionId.value,
      };
      print("Body @@@@ ${body}");
      var data = await apiRespository.postApiCallByJson(
          Constants.getStudent_by_class_sectionUrl, body);
      print("DATA @@@@ ${data.body}");
      data.body['studentList'].forEach((v) {
        students.value!.add(new StudentList.fromJson(v));
      });

      update();
    }
    else
    {
      print("Filter Data not valid");
      update();
    }
    update();

  }
  saveApproveLeave({leave_id}) async {

    CommonApiController commonApiController = Get.put(CommonApiController());
    print(commonApiController.selectedClassId.value);
    print(commonApiController.selectedSectionId.value);

    if(commonApiController.selectedClassId.value.isNotEmpty && commonApiController.selectedSectionId.value.isNotEmpty
        && applyLeaveDateController.value.text.isNotEmpty && fromDateController.value.text.isNotEmpty && toDateController.value.text.isNotEmpty &&
        selectedStudent.value.isNotEmpty && selectedStatus.value.isNotEmpty)
    {

      FormData body = FormData({});
      Map<String, String> bodyMap = {
        'apply_date': applyLeaveDateController.value.text.toString(),
        'from_date': fromDateController.value.text.toString(),
        'to_date': toDateController.value.text.toString(),
        'student': selectedStudent.value.toString(),
        'message': reasonController.value.text.toString(),
        'leave_status': selectedStatus.value.toString(),
        'leave_id': leave_id ?? ""
      };

      body.fields.addAll(bodyMap.entries);
      if(pickedFile.value != null && await pickedFile.value!.exists())
        {
          body.files.add( MapEntry('userfile', MultipartFile(pickedFile.value, filename: pickedFile.value?.path.split('/').last ?? "")));
        }

      // var body = {
      //   "class_id": commonApiController.selectedClassId.value,
      //   "section_id": commonApiController.selectedSectionId.value,
      // };
      print("Body @@@@ ${bodyMap}");
      var data = await apiRespository.postApiCallByFormData(
          Constants.getSaveApproveLeaveUrl, body);
      print("DATA @@@@ ${data.body}");
      filterData();

      update();
    }
    else
    {
      print("Filter Data not valid");
      update();
    }
    update();

  }

  deleteApproveLeave(id) async {



    if(id.isNotEmpty)
    {


      var body = {
        "id": id
      };
      print("Body @@@@ ${body}");
      var data = await apiRespository.postApiCallByJson(
          Constants.getRemove_ApproveLeaveUrl, body);
      print("DATA @@@@ ${data.body}");

      filterData();
      update();
    }
    else
    {
      print("Filter Data not valid");
      update();
    }
    update();

  }



}
