import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learnladderfaculity/presentation/academics/Section/section_modal.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import 'class_modal.dart';

class ClassController extends GetxController {
  Rx<TextEditingController> classC = TextEditingController().obs;
  String privousClass = "";
  List<String> previousSectionList = [];
  Rx<TextEditingController> searchC = TextEditingController().obs;

  Rx<SectionListDataModal> sectionListClass = SectionListDataModal().obs;
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());

  Rx<ClassModal> classList = ClassModal().obs;

  RxString selectedId = ''.obs;
  final RxList<String> selectedSections = <String>[].obs;

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
        print("ggggggggg${data.body['data']['classlist']}");
        ClassList class1 = ClassList.fromJson(data.body['data']['classlist'][0]);
        print(class1.toJson());
        classC.value.text = class1.classN!;
        privousClass = class1.id!;
        for(var section in class1.sections!)
          {
            selectedSections.value.add(section.id!);
            previousSectionList.add(section.id!);
          }
        update();
      }
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

  resetData() {
    classC.value.clear();
    selectedSections.clear();
    selectedId.value = '';
    update();
  }

  Future<void> addSubject() async {
    try {

      List<Map<String, String>> sections = [];



      var body = {
        "class": classC.value.text,
        "sections": selectedSections.join(','),
      };

      // for (String sectionId in selectedSections) {
      //   body['sections[]'] = sectionId;
      // }

      print("ttttttttttt$body");
      String url = Constants.addClass;
      if (selectedId.value == '') {
      } else {
        body['pre_class_id'] = privousClass;
        body['prev_sections'] =(previousSectionList!.length > 0 ?  previousSectionList!.join(',') : null) ?? "";
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
