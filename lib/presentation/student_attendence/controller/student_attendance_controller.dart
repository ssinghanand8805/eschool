import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../apiHelper/Constants.dart';
import '../../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/userData.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import '../model/Student_Attendance.dart';
import '../../../apiHelper/toastMessage.dart';

class StudentAttendanceController extends GetxController {
  Rx<TextEditingController> attendanceDate = TextEditingController().obs;
  final Rx<DateTime> applyDate = DateTime.now().obs;
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<String> year = "".obs;
  Rx<String> month = "".obs;
  Rx<String> selectedStatus = "1".obs;
  Rx<bool> isLoadingStudentList = false.obs;
  Rx<bool> isSearchExpand = true.obs;
  RxList<Resultlist> studentListModel = <Resultlist>[].obs;
  RxList<StudentAttendenceModel> studentAttendenceModel =
      <StudentAttendenceModel>[].obs;
  RxList<Attendencetypeslist> attendencetypestListModel =
      <Attendencetypeslist>[].obs;
  var remarks = <String, TextEditingController>{}.obs;
  List<String> attendanceStatus = List.filled(8, 'P');
  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();

    DateTime now = DateTime.now();
    setDateOnInit();

    //getDataFromApi( now);// Initialize the future when the controller is created
  }
setDateOnInit()
async {
  DateTime now = DateTime.now();
 var d =  await GlobalData().ConvertToSchoolDateTimeFormat(now);
  attendanceDate.value.text = d;
  getData();
}
  void addOrUpdateRemarkController(String studentId,{bool remarkFound = false,String? remark = ""}) {
    if (!remarks.containsKey(studentId)) {
      remarks[studentId] = TextEditingController();
      if(remarkFound)
        {
          remarks[studentId]!.text = remark ?? "";
        }
    }
    // update();
  }

  // Method to get a TextEditingController for a specific student ID
  TextEditingController? getRemarkController(String studentId) {
    return remarks[studentId];
  }

  Future<void> getData() async {
    CommonApiController controller3 = Get.put(CommonApiController());
  //  controller3.getClassList();
    update();
  }

  Future<void> getFilterData() async {
    CommonApiController commonApiController = Get.put(CommonApiController());
    DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(attendanceDate.value.text.toString());
    String formattedDate = DateFormat("MM/dd/yyyy").format(parsedDate);
    var body = {
      "class_id": commonApiController.selectedClassId.value,
      "section_id": commonApiController.selectedSectionId.value,
      "date": formattedDate,
      "holiday": "",
      "search": "search"
    };
    print("Body @@@@ ${body}");
    var data = await apiRespository.postApiCallByJson(
        Constants.getstudentAttendenceUrl, body);
    print("DATA @@@@ ${data.body}");
    StudentAttendence ss = StudentAttendence.fromJson(data.body);
    studentListModel.value = ss.resultlist!;
    print("TTTTTTTT");
    var t =  ss.resultlist!
        .map((student) => student.toJson())
        .toList();
    print( t);
    attendencetypestListModel.value = ss.attendencetypeslist!;
    studentAttendenceModel.value.clear();
    remarks.clear();
    for (var i = 0; i < studentListModel.value.length; i++) {
      Resultlist e = studentListModel.value[i];
      StudentAttendenceModel ss = new StudentAttendenceModel();
      ss.attendendenceId = e.attendenceId;
      ss.attendencetype = e.attendenceTypeId;
      ss.studentSession = e.studentSessionId;
      ss.remark = e.remark;
      studentAttendenceModel.value.add(ss);
    }

    update();
  }

  updateForAll(attendenceTypeId) {
    for (var i = 0; i < studentAttendenceModel.value.length; i++) {
      var studentSessionId = studentAttendenceModel.value[i].studentSession;
      int idx = studentAttendenceModel.value
          .indexWhere((element) => element.studentSession == studentSessionId);
      if (idx != -1) {
        studentAttendenceModel.value[idx].attendencetype = attendenceTypeId;
        update();
      }
    }
  }

  updateStudentAttendence(studentSessionId, attendenceTypeId) {
    int idx = studentAttendenceModel.value
        .indexWhere((element) => element.studentSession == studentSessionId);
    if (idx != -1) {
      studentAttendenceModel.value[idx].attendencetype = attendenceTypeId;

      update();
    }
  }

  updateStudentAttendenceRemark(studentSessionId) {
    String remark = getRemarkController(studentSessionId)!.text;
    int idx = studentAttendenceModel.value
        .indexWhere((element) => element.studentSession == studentSessionId);
    if (idx != -1) {
      studentAttendenceModel.value[idx].remark = remark;
      update();
    }
  }

  saveAttendance() async {
    for (var i = 0; i < studentAttendenceModel.value.length; i++) {
      String st = attendanceStatus[i];
      int attID = 0;
      if(st == 'P')
        {
          attID  = 1;
        }
      else if(st == 'A')
      {
        attID  =4;
      }
      else if(st == 'L')
      {
        attID  = 5;
      }
      studentAttendenceModel.value[i].attendencetype = attID.toString();//getRemarkController( studentAttendenceModel.value[i].studentSession!)!.text;
    }
    List<Map<String, dynamic>> students = studentAttendenceModel.value
        .map((student) => student.toJson())
        .toList();
  print(students);
    CommonApiController commonApiController = Get.put(CommonApiController());
    DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(attendanceDate.value.text.toString());
    String formattedDate = DateFormat("MM/dd/yyyy").format(parsedDate);
    var body = {
      "class_id": commonApiController.selectedClassId.value,
      "section_id": commonApiController.selectedSectionId.value,
      "date": formattedDate,
      "holiday": "",
      "search": "saveattendence",
      "students":students
    };
    var data  = await apiRespository.postApiCallByJson(Constants.getstudentAttendenceUrl,body);
    print("DATA @@@@ ${data.body}");
    if(data.statusCode==200){
      Get.showSnackbar(Ui.SuccessSnackBar(message: data.body['message'].toString()));
    }else{
      Get.showSnackbar(Ui.ErrorSnackBar(message: data.body['message'].toString()));
    }
    // SuccessSnackBar();
  }
}
