import 'package:get/get.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../model/CommonModel.dart';

class CommonApiController extends GetxController {
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  RxList<Classes> classListModel = <Classes>[].obs;
  RxList<dynamic> classListModelMap = <dynamic>[].obs;
  RxList<Sections> sectionListModel = <Sections>[].obs;
  RxList<dynamic> sectionListModelMap = <dynamic>[].obs;
  Rx<String> selectedClassId = "".obs;

  Rx<String> selectedSectionId = "".obs;
  Rx<bool> isLoadingStudentList = false.obs;
  Rx<String> selectedClassName = "".obs;
  Rx<String> selectedSectionName = "".obs;


  @override
  void onInit() {
    super.onInit();
    // searchController.value.addListener(() {
    //   filterStudentList();
    // });
    // kEvents.value = LinkedHashMap<DateTime, List<Event>>(
    //   equals: isSameDay,
    //   hashCode: getHashCode,
    // )..addAll(_kEventSource.value);
    // DateTime now = DateTime.now();
    getClassList();
    // Initialize the future when the controller is created
  }
  Future<void> getClassList() async
  {

    var data  = await apiRespository.getApiCallByJson(Constants.getClassListUrl);
    print("DATA @@@@ ${data.body}");

    for(var i=0;i<data.body.length;i++)
      {
        Classes s = Classes.fromJson(data.body[i]);
        classListModel.value.add(s);
      }


    classListModelMap.value = classListModel.value.map((item) {
      return item.toJson();
    }).toList();

    update();
  }

  Future<void> getSectionList() async
  {
var body = {
  "class_id": selectedClassId.value
};
    var data  = await apiRespository.postApiCallByJson(Constants.getSectionListUrl,body);
    print("DATA @@@@ ${data.body}");

    for(var i=0;i<data.body.length;i++)
    {
      Sections s = Sections.fromJson(data.body[i]);
      sectionListModel.value.add(s);
    }


    sectionListModelMap.value = sectionListModel.value.map((item) {
      return item.toJson();
    }).toList();

    update();
  }
}