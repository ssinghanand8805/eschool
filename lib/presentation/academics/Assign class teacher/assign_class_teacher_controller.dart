import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import 'assign_class_teacher_modal.dart';

class AssignClassTeacherController extends GetxController{


  Rx<TextEditingController> searchC = TextEditingController().obs;
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<AssignClassTeacherModal> assignClassList = AssignClassTeacherModal().obs;
  late Future<void> fetchDataFuture;


  @override
  void onInit() async {
    super.onInit();
    fetchDataFuture = initializeData();
  }

  RxBool isChecked = false.obs;
  RxBool isLoading = false.obs;

  Future<void> initializeData() async {

    try {
      var body = {};
      var data = await apiRespository.postApiCallByJson(
          Constants.assignclassteacherlist, body);

      assignClassList.value = AssignClassTeacherModal.fromJson(data.body);
      print(assignClassList.value.toJson());
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