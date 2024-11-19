import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Section/section_modal.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import 'class_modal.dart';

class ClassController extends GetxController {
  Rx<TextEditingController> classC = TextEditingController().obs;
  Rx<TextEditingController> searchC = TextEditingController().obs;

  Rx<SectionListDataModal> sectionListClass = SectionListDataModal().obs;
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());

  Rx<ClassModal> classList = ClassModal().obs;

  RxString selectedId = ''.obs;
  final List<String> selectedSections = [];

  late Future<void> fetchDataFuture;
  void onInit() {
    super.onInit();
    fetchDataFuture = subjectListData();
    sectionListData();
  }

  sectionListData() async {
    try {
      var body = {};
      var data = await apiRespository.postApiCallByJson(
          Constants.getSectionList, body);
      print("Section List: ${data.body}");

      sectionListClass.value = SectionListDataModal.fromJson(data.body);
      print(sectionListClass.value.toJson());
      update();
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

  subjectListData() async {
    try {
      var body = {};
      var data =
          await apiRespository.postApiCallByJson(Constants.getClassList, body);
      print("Class List: ${data.body}");

      classList.value = ClassModal.fromJson(data.body);
      print(classList.value.toJson());
      update();
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

  viewData(id) async {
    try {
      resetData();
      selectedId.value = id;
      var body = {
        "id": selectedId.value,
      };
      var data =
          await apiRespository.postApiCallByFormData(Constants.viewClass, body);
      print("Subject viewSubject : ${data.body}");
      if (data.body['status'] == 1) {
        ClassList subject = ClassList.fromJson(data.body['data']['subject']);
        print(subject.toJson());
        classC.value.text = subject.classN!;

        update();
      }
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

  resetData() {
    selectedId.value = '';
    update();
  }

  Future<void> addSubject() async {
    try {

      List<Map<String, String>> sections = [];



      var body = {
        "name": classC.value.text,
        "sections": selectedSections.join(','),
      };

      // for (String sectionId in selectedSections) {
      //   body['sections[]'] = sectionId;
      // }

      print("ttttttttttt$body");
      String url = Constants.addClass;
      if (selectedId.value == '') {
      } else {
        body['id'] = selectedId.value;
        url = Constants.editClass;
      }
      var data = await apiRespository.postApiCallByFormData(url, body);

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
          Constants.deleteClass, body);

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
