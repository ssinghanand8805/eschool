import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';

import '../../../../apiHelper/Constants.dart';
import '../../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/toastMessage.dart';
import '../../../apiHelper/userData.dart';
import '../../academics/Subject Group/subject_group_modal.dart';
import '../../academics/Subject/subject_modal.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import '../model/DailyAssgnment.dart';
import '../model/Student_Attendance.dart';
import '../model/SubjectGroup.dart';
import '../model/SubjectListBySubjectGroup.dart';



class TeacherDailyAssignmentController extends GetxController {
  CommonApiController commonApiController = Get.put(CommonApiController());
  Rx<TextEditingController> dateC = TextEditingController().obs;
  final Rx<DateTime> applyDate = DateTime.now().obs;
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<String> year = "".obs;
  Rx<String> month = "".obs;
   Rx<Attendance> attendanceModelObj = Attendance().obs;
  RxMap<DateTime, List<Event>> _kEventSource = <DateTime, List<Event>>{}.obs;
  final Rx<LinkedHashMap<DateTime, List<Event>>> kEvents = Rx<LinkedHashMap<DateTime, List<Event>>>(LinkedHashMap());
  late Future<void> fetchDataFuture;
  RxString updateSubjectGroupId = "".obs;
  RxString updateSubjectId = "".obs;
  RxList<SubjectGroupByClassAndSection> subjectGroupList = <SubjectGroupByClassAndSection>[].obs;
  RxList<SubjectListBySubjectGroup> subjectList = <SubjectListBySubjectGroup>[].obs;
  Rx<File?> pickedFile = Rx<File?>(null);
  RxBool isSubjectGroupLoading = false.obs;
  RxBool isSubjectLoading = false.obs;
  Rx<TextEditingController> homeWorkDate = TextEditingController().obs;
  Rx<TextEditingController> submissionDate = TextEditingController().obs;
  Rx<TextEditingController> maxMark = TextEditingController().obs;
  Rx<HtmlEditorController> HtmlController = HtmlEditorController().obs;
  Rx<DailyAssignment> assignmentList = DailyAssignment().obs;
  @override
  void onClose() {
    super.onClose();

  }



  final List students = [
    {"id": 1001, "classId": "0202", "name": "Hudson1"},
    {"id": 1002, "classId": "0203", "name": "Hudson2"},
    {"id": 1003, "classId": "0204", "name": "Hudson2"},
  ];
  List<Map<String, dynamic>> data = [
    {
      'studentName': 'Edward Thomas',
      'studentId': 18001,
      'class': 'Class 4',
      'section': 'A',
      'applyDate': DateTime(2024, 4, 5),
      'fromDate': DateTime(2024, 4, 9),
      'toDate': DateTime(2024, 4, 9),
      'status': 'Approved (04/05/2024)',
      'approvedBy': 'Joe Black',
      'approvedId': 9000,
    },  {
      'studentName': 'Edward Thomas',
      'studentId': 18001,
      'class': 'Class 4',
      'section': 'A',
      'applyDate': DateTime(2024, 4, 5),
      'fromDate': DateTime(2024, 4, 9),
      'toDate': DateTime(2024, 4, 9),
      'status': 'Approved (04/05/2024)',
      'approvedBy': 'Joe Black',
      'approvedId': 9000,
    },
    {
      'studentName': 'Kriti Singh',
      'studentId': 18010,
      'class': 'Class 4',
      'section': 'B',
      'applyDate': DateTime(2024, 4, 4),
      'fromDate': DateTime(2024, 4, 22),
      'toDate': DateTime(2024, 4, 26),
      'status': 'Pending',
      'approvedBy': 'Joe Black',
      'approvedId': 9001,
    },
    // Add more data as needed
  ];
  // Retrieve events by date
  List<Event>? getEvents(DateTime date) {
    // print("##################${date}");
    return kEvents.value[date];
  }

  // Retrieve events by date

  @override
  void onInit() {
    super.onInit();
    setDateOnInit();

   // getDataFromApi( now);// Initialize the future when the controller is created
  }
  setDateOnInit()
  async {
    DateTime now = DateTime.now();
    var d =  await GlobalData().ConvertToSchoolDateTimeFormat(now);
    dateC.value.text = d;

    homeWorkDate.value.text = d;
    submissionDate.value.text = d;

  }

  addAssignment(context) async {

    var ff = await HtmlController.value.getText();

    Map<String, String> body = {
      "modal_class_id":commonApiController.selectedClassId.value,
      "modal_section_id":commonApiController.selectedSectionId.value,
      "homework_date":homeWorkDate.value.text,
      "submit_date":submissionDate.value.text,
      "modal_subject_id":updateSubjectId.value,
      "description": ff.isEmpty?"":ff,
      "record_id":"0",
      "homework_marks":"0",

    };

    FormData bodyForm = FormData({});
    bodyForm.fields.addAll(body.entries);
    if(pickedFile.value != null && await pickedFile.value!.exists())
    {
      bodyForm.files.add( MapEntry('userfile', MultipartFile(pickedFile.value, filename: pickedFile.value?.path.split('/').last ?? "")));
    }
    print("AddHomeWorkBody ${bodyForm.files}");
    var data = await apiRespository.postApiCallByFormData(Constants.addDailyAssignment, bodyForm);

    print("dddd "+data.body['status']);

    if(data.body != null && data.body['status']=='success'){
      print("Cherck");
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Homework added successfully"));
      Navigator.pop(context);
    }else{
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Something went wrong"));
    }

  }
  getDataFromApi(DateTime now)
  {
    String year = DateFormat('yyyy').format(now);  // Extracts the year as "2024"
    String month = DateFormat('MM').format(now);
    // fetchDataFuture = getData(year,month);
  }
  setMonthAndYear()
  {
    year.value = "";
    month.value = "";
    update();
  }
  getDate(context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: applyDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    return date;
  }
  Future<void> getData() async
  {

    Map<String,dynamic> body = {
      "class_id" : commonApiController.selectedClassId.value,
      "section_id":commonApiController.selectedSectionId.value,
      "subject_group_id":updateSubjectGroupId.value,
      "subject_id":updateSubjectId.value,
      "date":dateC.value.text,
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getdailyassignmentUrl, body);
    print("DATA @@@@ ${data.body}");
    if(data.statusCode == 200)
      {
        assignmentList.value = DailyAssignment.fromJson(data.body);
        update();
      }

  }

  subjectGroup() async {
    try
    {
      isSubjectGroupLoading.value = true;
      subjectGroupList.clear();
      Map<String, dynamic> body = {
        "class_id":commonApiController.selectedClassId.value,
        "section_id":commonApiController.selectedSectionId.value,
      };
      print("EEEEEEEE${body}");
      var data = await apiRespository.postApiCallByJson(Constants.subjectGroup, body);
      print("DATA @@@@ ${data.body}");
      data.body.forEach((item) {

        subjectGroupList.value.add( SubjectGroupByClassAndSection.fromJson(item));
      });
      isSubjectGroupLoading.value = false;
      update();
    }
    catch(e)
    {
      isSubjectGroupLoading.value = false;

    }

    // controller.updateSubjectGroup = data.body;
  }

  subject() async {
    try
    {
      isSubjectLoading.value = true;
      subjectList.clear();
      Map<String, dynamic> body = {
        "subject_group_id": updateSubjectGroupId.value
      };

      var data = await apiRespository.postApiCallByJson(Constants.subject, body);
      print("DATA @@@@ ${data.body}");
      data.body.forEach((item) {

        subjectList.value.add( SubjectListBySubjectGroup.fromJson(item));
      });
      isSubjectLoading.value = false;
      update();
    }
    catch(e)
    {
      isSubjectLoading.value = false;
    }


  }
  // final kEvents = LinkedHashMap<DateTime, List<Event>>(
  //   equals: isSameDay,
  //   hashCode: getHashCode,
  // )..addAll(_kEventSource);
  // Map<DateTime, List<Event>> _kEventSource = {};

  // final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
  //     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
  //     value: (item) => List.generate(
  //         item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  //   ..addAll({
  //     kToday: [
  //       Event('Today\'s Event 1'),
  //       Event('Today\'s Event 2'),
  //     ],
  //   });
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
