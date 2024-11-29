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




  late Future<void> fetchDataFuture;
  void onInit() {
    super.onInit();
    fetchDataFuture = subjectListData();
  }

  List<Subjectlist> originalContentTypeList = [];
  void initializeOriginalList() {
    originalContentTypeList = List.from(subjectList.value.data!.subjectlist!);  // Make a copy of the original data
  }
  Future<void> searchContentType(String searchKey) async {
    // Check if the searchKey is empty or not
    if (searchKey.isEmpty) {
      // Reset to the original list when searchKey is cleared
      subjectList.update((val) {
        val?.data!.subjectlist = originalContentTypeList;  // Reset to original list
      });
    } else {
      // Filter the list based on the searchKey
      List<Subjectlist> filteredList = originalContentTypeList
          .where((element) => element.name != null &&
          element.name!.toLowerCase().contains(searchKey.toLowerCase().trim()))  // Perform case-insensitive search
          .toList();

      // Update the filtered list
      subjectList.update((val) {
        val?.data!.subjectlist = filteredList;
      });
    }
  }


subjectListData() async {
    try {
      var body = {};
      var data = await apiRespository.postApiCallByJson(
          Constants.getSubjectList, body);
      print("Subject List: ${data.body}");

      subjectList.value = SubjectListModal.fromJson(data.body);
      print(subjectList.value.toJson());
      initializeOriginalList();
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