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
import '../teacher_daily_assignment/model/SubjectGroup.dart';
import '../teacher_daily_assignment/model/SubjectListBySubjectGroup.dart';
import 'class_work_modal.dart';

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

  Rx<TextEditingController> classWorkDate = TextEditingController().obs;
  Rx<TextEditingController> submissionDate = TextEditingController().obs;
  Rx<TextEditingController> maxMark = TextEditingController().obs;
  Rx<HtmlEditorController> HtmlController = HtmlEditorController().obs;
  RxList<Classwork> classList = <Classwork>[].obs;
  RxBool isSubjectGroupLoading = false.obs;
  RxBool isSubjectLoading = false.obs;

  RxBool isFetchDataLoading = false.obs;
  RxBool isAdding = false.obs;
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

    classWorkDate.value.text = d;
    submissionDate.value.text = d;
  }

  addClassWork(context) async {

    try{
      var ff = await HtmlController.value.getText();
      isAdding.value = true;
      update();
      Map<String, String> body = {
        "record_id": "0",
        "modal_class_id": commonApiController.selectedClassId.value,
        "modal_section_id": commonApiController.selectedSectionId.value,
        "classwork_date": classWorkDate.value.text,
        "modal_subject_id": updateSubjectId.value,
        "submit_date": submissionDate.value.text,
        "description": ff.isEmpty ? "" : ff,
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
          Constants.createClassWork, bodyForm);

      print("dddd " + data.body['status']);
      isAdding.value = false;
      update();
      if (data.body != null && data.body['status'] == 'success') {
        print("Cherck");
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: "Homework added successfully"));
        Navigator.pop(context);
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(message: "Something went wrong"));
      }
    }
    catch(e)
    {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Something went wrong"));
      isAdding.value = false;
    }

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

    try{
      isFetchDataLoading.value = true;
      update();
      Map<String, dynamic> body = {
        "class_id": commonApiController.selectedClassId.value,
        "section_id": commonApiController.selectedSectionId.value,
        "subject_group_id": updateSubjectGroupId.value,
        "subject_id": updateSubjectId.value,
        "filterdate": dateC.value.text,
      };
      print("Body @@@@ ${body}");
      var data = await apiRespository.postApiCallByJson(
          Constants.getclassworklist, body);
      print("DATA @@@@ ${data.body}");
      if (data.statusCode == 200 && data.body.length > 0) {
        for(var i=0;i<data.body.length;i++)
        {
          classList.value.add(Classwork.fromJson(data.body[i]));

        }
        isFetchDataLoading.value = false;
        update();

      }
    }
    catch(e)
    {
      isFetchDataLoading.value = false;
      update();
    }

  }

  subjectGroup() async {
    try{
      isSubjectGroupLoading.value = true;
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
    try{
      isSubjectLoading.value = true;
      Map<String, dynamic> body = {
        "subject_group_id": updateSubjectGroupId.value
      };

      var data = await apiRespository.postApiCallByJson(Constants.subject, body);
      print("DATA @@@@ ${data.body}");
      data.body.forEach((item) {
        subjectList.value.add(SubjectListBySubjectGroup.fromJson(item));
      });
      isSubjectLoading.value = false;
      update();
    }
    catch(e)
    {
      isSubjectLoading.value = false;
    }

  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
