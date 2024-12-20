import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Subject%20Group/subject_group_modal.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import '../Subject/subject_modal.dart';

class SubjectGroupController extends GetxController{

  Rx<TextEditingController> nameC = TextEditingController().obs;
  Rx<TextEditingController> searchC = TextEditingController().obs;
  Rx<TextEditingController> descriptionC = TextEditingController().obs;
  RxBool isChecked = false.obs;
  Rx<SubjectListModal> subjectList = SubjectListModal().obs;
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  List<String> selectedSubjectIdList = [];
  List<String> selectedSelectionId = [];
   String selectedClassId = "";
  Rx<SubjectGroupModal> subjectGroupList = SubjectGroupModal().obs;
  RxBool isTheory = true.obs;
  RxBool isPractical = false.obs;
  RxString selectedSubjectId = ''.obs;

  late Future<void> fetchDataFuture;
  void onInit() {
    super.onInit();
    fetchDataFuture = subjectListData();
  }




  subjectListData() async {
    try {
      var body = {};
      var data = await apiRespository.postApiCallByJson(
          Constants.getSubjectGroupList, body);
      print("Subject List: ${data.body}");

      subjectGroupList.value = SubjectGroupModal.fromJson(data.body);
      print(subjectGroupList.value.toJson());
      update();
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
    var body = {};
    var data = await apiRespository.postApiCallByJson(
        Constants.getSubjectList, body);
    print("Subject List: ${data.body}");

    subjectList.value = SubjectListModal.fromJson(data.body);
  }
  viewData(id) async {
    try {
      resetData();
      selectedSubjectId.value =id;
      var body = {

        "id":selectedSubjectId.value,
      };
      var data = await apiRespository.postApiCallByFormData(
          Constants.viewSubjectGroup, body);
      print("Subject viewSubject : ${data.body}");
      if(data.body['status'] == 1){
        SubjectgroupList subject = SubjectgroupList.fromJson(data.body['data']['subject']);
        print(subject.toJson());
        nameC.value.text = subject.name!;
        descriptionC.value.text = subject.description!;

        update();
      }
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }


  resetData(){
    selectedSubjectId.value = '';
    isTheory.value = true;
    isPractical.value = false;
    update();
  }



  Future<void> addSubjectSubjectGroup() async {
    try {

      var body = {
        "name":nameC.value.text.toString(),
        "class_id": selectedClassId,
        "sections": selectedSelectionId.join(","),
        "subject": selectedSubjectIdList.join(","),

      };
      String url = Constants.addSubjectGroupList;
      if(selectedSubjectId.value == '')
      {

      }
      else
      {
        body['id'] = selectedSubjectId.value;
        url = Constants.editSubjectGroupList;
      }
      print("eeeeee${body}");
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
          Constants.deleteSubjectGroupList, body);

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