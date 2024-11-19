import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Subject/subject_modal.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';

class SubjectController extends GetxController{

  Rx<TextEditingController> subjectNameC = TextEditingController().obs;
  Rx<TextEditingController> subjectCodeC = TextEditingController().obs;
  Rx<TextEditingController> searchC = TextEditingController().obs;
  Rx<TextEditingController> newSectionC = TextEditingController().obs;
  Rx<TextEditingController> codeC = TextEditingController().obs;
  Rx<TextEditingController> editSectionC = TextEditingController().obs;
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());

  Rx<SubjectListModal> subjectList = SubjectListModal().obs;
  RxBool isTheory = true.obs;
  RxBool isPractical = false.obs;
  RxString selectedSubjectId = ''.obs;

  List<Map<String, dynamic>> data = [
    {
      'studentId': 18001,
      'class': 'Class 4',
      'section': 'A',
      'subjectGroup': 'Class 1st Subject Group',
      'subject': 'Hindi (230)',
      'homeworkDate': DateTime(2024, 4, 5),
      'submissionDate': DateTime(2024, 4, 9),
      'evaluationDate': DateTime(2024, 4, 9),
      'createdBy': 'Joe Black',
      'approvedId': 9000,
    },
    {
      'studentId': 18002,
      'class': 'Class 4',
      'section': 'A',
      'subjectGroup': 'Class 1st Subject Group',
      'subject': 'Hindi (230)',
      'homeworkDate': DateTime(2024, 4, 5),
      'submissionDate': DateTime(2024, 4, 9),
      'evaluationDate': DateTime(2024, 4, 9),
      'createdBy': 'Kirti Singh',
      'approvedId': 9000,
    },
    // Add more data as needed
  ];


  late Future<void> fetchDataFuture;
  void onInit() {
    super.onInit();
    fetchDataFuture = subjectListData();
  }




subjectListData() async {
    try {
      var body = {};
      var data = await apiRespository.postApiCallByJson(
          Constants.getSubjectList, body);
      print("Subject List: ${data.body}");

      subjectList.value = SubjectListModal.fromJson(data.body);
      print(subjectList.value.toJson());
      update();
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }
  viewData(id) async {
    try {
      resetData();
      selectedSubjectId.value =id;
      var body = {

        "id":selectedSubjectId.value,
      };
      var data = await apiRespository.postApiCallByFormData(
          Constants.viewSubject, body);
      print("Subject viewSubject : ${data.body}");
      if(data.body['status'] == 1){
      Subjectlist subject = Subjectlist.fromJson(data.body['data']['subject']);
      print(subject.toJson());
      subjectNameC.value.text = subject.name!;
      subjectCodeC.value.text = subject.code!;
      isTheory.value = subject.type == 'theory'?true:false;
      isPractical.value = subject.type == 'practical'?true:false;
      update();
      }
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }


resetData(){
  selectedSubjectId.value = '';
  subjectNameC.value.text = '';
  subjectCodeC.value.text = '';
  isTheory.value = true;
  isPractical.value = false;
  update();
}



  Future<void> addSubject() async {
    try {

      var body = {
        "name":subjectNameC.value.text,
        "type": isPractical.value ? 'practical':'theory',
        "code": subjectCodeC.value.text,
      };
      String url = Constants.addSubjectList;
      if(selectedSubjectId.value == '')
        {

        }
      else
        {
          body['id'] = selectedSubjectId.value;
          url = Constants.editSubjectList;
        }
      var data = await apiRespository.postApiCallByFormData(
          url, body);

      if (data.body['status'] == 1) {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: data.body['msg'].toString()));
        subjectListData();
        resetData();
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: data.body['msg'].toString()));
      }
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

  deleteSubject(context, id) async {
    try {
      var body = {"id": id};
      var data = await apiRespository.postApiCallByFormData(
          Constants.deleteSubjectList, body);

      if (data.body['status'] == 1) {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: data.body['msg'].toString()));
        subjectListData();
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: data.body['msg'].toString()));
      }
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

}