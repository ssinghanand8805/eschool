import 'package:get/get.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import '../model/CommonModel.dart';

class CommonApiController extends GetxController {
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  RxList<Classes> classListModel = <Classes>[].obs;
  RxList<dynamic> classListModelMap = <dynamic>[].obs;
  RxList<Sections> sectionListModel = <Sections>[].obs;
  RxList<dynamic> sectionListModelMap = <dynamic>[].obs;
  Rx<String> selectedClassId = "".obs;
  RxBool isClassLoading = false.obs;
  RxBool isSectionLoading = false.obs;
  Rx<String> selectedSectionId = "".obs;
  Rx<bool> isLoadingStudentList = false.obs;
  Rx<String> selectedClassName = "".obs;
  Rx<String> selectedSectionName = "".obs;


  @override
  void onInit() {
    super.onInit();

    getClassList();
    // Initialize the future when the controller is created
  }
  Future<void> getClassList() async
  {
    isClassLoading.value = true;
    update();
    var data  = await apiRespository.getApiCallByJson(Constants.getClassListUrl);
    print("DATA @@@@ ${data.body}");
    if(data.body != null)
      {
        for(var i=0;i<data.body.length;i++)
        {
          Classes s = Classes.fromJson(data.body[i]);
          classListModel.value.add(s);
        }


        classListModelMap.value = classListModel.value.map((item) {
          return item.toJson();
        }).toList();

        isClassLoading.value = false;
        update();
      }
    else
      {
        Get.showSnackbar(Ui.ErrorSnackBar(message: "Class Loading Failed..Try Again"));
        isClassLoading.value = false;
        update();
      }

  }

  Future<void> getSectionList() async
  {
    isSectionLoading.value = true;
    update();
    sectionListModel.clear();
    sectionListModelMap.clear();
var body = {
  "class_id": selectedClassId.value
};
    var data  = await apiRespository.postApiCallByJson(Constants.getSectionListUrl,body);
    print("DATA @@@@ ${data.body}");

    if(data.body != null)
      {
        for(var i=0;i<data.body.length;i++)
        {
          Sections s = Sections.fromJson(data.body[i]);
          sectionListModel.value.add(s);
        }


        sectionListModelMap.value = sectionListModel.value.map((item) {
          return item.toJson();
        }).toList();

        isSectionLoading.value = false;
        update();
      }
    else
      {
        Get.showSnackbar(Ui.ErrorSnackBar(message: "Section Loading Failed..Try Again"));
        isSectionLoading.value = false;
        update();
      }

  }
}