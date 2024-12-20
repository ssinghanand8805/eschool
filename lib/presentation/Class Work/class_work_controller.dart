import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';

import '../../apiHelper/Constants.dart';
import '../../apiHelper/GlobalData.dart';
import '../../apiHelper/popular_product_repo.dart';
import '../../apiHelper/toastMessage.dart';
import '../../apiHelper/userData.dart';
import '../add_homework/model/addHomework.dart';
import '../common_widgets/controller/CommonApiController.dart';
import '../teacher_daily_assignment/model/DailyAssgnment.dart';
import '../teacher_daily_assignment/model/SubjectGroup.dart';
import '../teacher_daily_assignment/model/SubjectListBySubjectGroup.dart';

class ClassWorkController extends GetxController {
  CommonApiController commonApiController = Get.put(CommonApiController());
  Rx<TextEditingController> dateC = TextEditingController().obs;
  final Rx<DateTime> applyDate = DateTime.now().obs;
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<String> year = "".obs;
  Rx<String> month = "".obs;
  Rx<Attendance> attendanceModelObj = Attendance().obs;
  RxMap<DateTime, List<Event>> _kEventSource = <DateTime, List<Event>>{}.obs;
  final Rx<LinkedHashMap<DateTime, List<Event>>> kEvents =
      Rx<LinkedHashMap<DateTime, List<Event>>>(LinkedHashMap());
  late Future<void> fetchDataFuture;
  RxString updateSubjectGroupId = "".obs;
  RxString updateSubjectId = "".obs;
  RxList<SubjectGroupByClassAndSection> subjectGroupList =
      <SubjectGroupByClassAndSection>[].obs;
  RxList<SubjectListBySubjectGroup> subjectList =
      <SubjectListBySubjectGroup>[].obs;
  Rx<File?> pickedFile = Rx<File?>(null);

  Rx<TextEditingController> homeWorkDate = TextEditingController().obs;
  Rx<TextEditingController> submissionDate = TextEditingController().obs;
  Rx<TextEditingController> maxMark = TextEditingController().obs;
  Rx<HtmlEditorController> HtmlController = HtmlEditorController().obs;
  Rx<DailyAssignment> assignmentList = DailyAssignment().obs;
  @override
  void onClose() {
    super.onClose();
  }

  List<Event>? getEvents(DateTime date) {
    return kEvents.value[date];
  }

  // Retrieve events by date

  @override
  void onInit() {
    super.onInit();
    setDateOnInit();
  }

  setDateOnInit() async {
    DateTime now = DateTime.now();
    var d = await GlobalData().ConvertToSchoolDateTimeFormat(now);
    dateC.value.text = d;

    homeWorkDate.value.text = d;
    submissionDate.value.text = d;
  }

  addAssignment(context) async {
    var ff = await HtmlController.value.getText();

    Map<String, String> body = {
      "modal_class_id": commonApiController.selectedClassId.value,
      "modal_section_id": commonApiController.selectedSectionId.value,
      "homework_date": homeWorkDate.value.text,
      "submit_date": submissionDate.value.text,
      "modal_subject_id": updateSubjectId.value,
      "description": ff.isEmpty ? "" : ff,
      "record_id": "0",
      "homework_marks": "0",
    };

    FormData bodyForm = FormData({});
    bodyForm.fields.addAll(body.entries);
    if (pickedFile.value != null && await pickedFile.value!.exists()) {
      bodyForm.files.add(MapEntry(
          'userfile',
          MultipartFile(pickedFile.value,
              filename: pickedFile.value?.path.split('/').last ?? "")));
    }
    print("AddHomeWorkBody ${bodyForm.files}");
    var data = await apiRespository.postApiCallByFormData(
        Constants.addDailyAssignment, bodyForm);

    print("dddd " + data.body['status']);

    if (data.body != null && data.body['status'] == 'success') {
      print("Cherck");
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Homework added successfully"));
      Navigator.pop(context);
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Something went wrong"));
    }
  }

  getDataFromApi(DateTime now) {
    String year = DateFormat('yyyy').format(now); // Extracts the year as "2024"
    String month = DateFormat('MM').format(now);
    // fetchDataFuture = getData(year,month);
  }

  setMonthAndYear() {
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

  Future<void> getData() async {
    Map<String, dynamic> body = {
      "class_id": commonApiController.selectedClassId.value,
      "section_id": commonApiController.selectedSectionId.value,
      "subject_group_id": updateSubjectGroupId.value,
      "subject_id": updateSubjectId.value,
      "date": dateC.value.text,
    };
    print("Body @@@@ ${body}");
    var data = await apiRespository.postApiCallByJson(
        Constants.getdailyassignmentUrl, body);
    print("DATA @@@@ ${data.body}");
    if (data.statusCode == 200) {
      assignmentList.value = DailyAssignment.fromJson(data.body);
      update();
    }
  }

  subjectGroup() async {
    Map<String, dynamic> body = {
      "class_id": commonApiController.selectedClassId.value,
      "section_id": commonApiController.selectedSectionId.value,
    };
    print("EEEEEEEE${body}");
    var data =
        await apiRespository.postApiCallByJson(Constants.subjectGroup, body);
    print("DATA @@@@ ${data.body}");
    data.body.forEach((item) {
      subjectGroupList.value.add(SubjectGroupByClassAndSection.fromJson(item));
    });
    update();
    // controller.updateSubjectGroup = data.body;
  }

  subject() async {
    Map<String, dynamic> body = {
      "subject_group_id": updateSubjectGroupId.value
    };

    var data = await apiRespository.postApiCallByJson(Constants.subject, body);
    print("DATA @@@@ ${data.body}");
    data.body.forEach((item) {
      subjectList.value.add(SubjectListBySubjectGroup.fromJson(item));
    });

    update();
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
