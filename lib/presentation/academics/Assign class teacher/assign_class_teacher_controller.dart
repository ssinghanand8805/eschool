import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import 'assign_class_teacher_modal.dart';
import 'getClassTeacherModal.dart';

class AssignClassTeacherController extends GetxController{


  Rx<TextEditingController> searchC = TextEditingController().obs;
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<AssignClassTeacherModal> assignClassList = AssignClassTeacherModal().obs;
  Rx<GetClassTeacherModal> getClassTeacherList = GetClassTeacherModal().obs;
  late Future<void> fetchDataFuture;


  @override
  void onInit() async {
    super.onInit();
    fetchDataFuture = initializeData();
    getClassTeacherData();
  }

  RxBool isChecked = false.obs;
  RxBool isLoading = false.obs;

  Future<void> initializeData() async {

    try {
      var body = {};
      var data = await apiRespository.postApiCallByJson(
          Constants.assignclassteacherlist, body);
      print("data@@ ${data.body}");
      assignClassList.value = AssignClassTeacherModal.fromJson(data.body);

      update();
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }


  Future<void> getClassTeacherData() async {

    try {
      var body = {};
      var data = await apiRespository.postApiCallByJson(
          Constants.getTeacherList, body);
      print("getClassTeacherData@@ ${data.body}");
      getClassTeacherList.value = GetClassTeacherModal.fromJson(data.body);

      update();
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }


  deleteGallery(context, classId,sectionId) async {
    try {
      var body = {
        "class_id": classId,
        "section_id": sectionId,

      };
      var data = await apiRespository.postApiCallByFormData(
          Constants.deleteGalleryList, body);

      if (data.body['status'] == 1) {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: data.body['msg'].toString()));
        initializeData();
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