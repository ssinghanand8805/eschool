import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lerno/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../../daily_assignment/model/student_Subject.dart';
import '../model/classWork.dart';



class ClassWorkController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRepository = ApiRespository(apiClient:Get.find());
  RxList<ClassWorkList> classWorkModelObj = <ClassWorkList>[].obs;
  late Future<void> fetchDataFuture;
  late Future<void> fetchDataFutureForSubjects;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString currentSelectedSubejectId = "0".obs;
  Rx<Subjectlist> currentSelectedSubject = Subjectlist().obs;
  Rx<StudentSubjects> studentSubjectsModelObj = StudentSubjects().obs;
  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
    fetchDataFuture = getData();
    fetchDataFutureForSubjects = getSubjects();
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)

      selectedDate.value = picked;
    getData(selectedDate: selectedDate.value);
    update();
  }

  String get formattedDate {
    return DateFormat('yyyy-MM-dd').format(selectedDate.value);
  }

  Future<void> getSubjects()async{
    Map<String,dynamic> body = await {
      "student_id" : userData.getUserStudentId };

    var data  = await apiRepository.postApiCallByJson(Constants.getstudentsubjectUrl, body);
    //
    //
    print("DATA @@@@ ${data.body}");
    studentSubjectsModelObj.value = StudentSubjects.fromJson(data.body);
    var newSubjet = await  Subjectlist(
      subjectGroupSubjectsId: "0",
      subjectGroupClassSectionsId: "0",
      name: "All",
      code: "",
      subjectId: "0",
    );
    studentSubjectsModelObj.value.subjectlist!.insert(0, newSubjet);
    print("*****${studentSubjectsModelObj.value.toJson()}");
    // Map<dynamic, dynamic> jsonData = data.body;//json.decode(data.body);


  }



  Future<void> getData({DateTime? selectedDate}) async {
    String formattedDate = selectedDate != null
        ? "${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.year}"
        : "";
    Map<String, dynamic> body = {
      "student_id": 1,
      "subject_group_subject_id": currentSelectedSubejectId.value == "0"
          ? ""
          : currentSelectedSubejectId.value,
      "date": formattedDate
    };

    var data = await apiRepository.postApiCallByJson(Constants.getClasswork, body);
    print("DATA @@@@ ${data.body}");

    List<ClassWorkList> d = [];
    for(var i =0;i <data.body['classworklist'].length; i++)
    {
      print("nmjvkjjgkjnnj");
      d.add(ClassWorkList.fromJson(data.body['classworklist'][i]));
      print("nhbhbhhhbbhhb");
    }
    classWorkModelObj.value = d;
    print("fvffhghnhnhnhnhnhn$d");
    update();
  }

}
