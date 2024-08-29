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

  Future<void> getClassList() async
  {


    // var data  = await apiRespository.getApiCallByJson(Constants.getClassListUrl);
    // print("DATA @@@@ ${data.body}");
    //
    // for(var i=0;i<data.body.length;i++)
    //   {
    //     Classes s = Classes.fromJson(data.body[i]);
    //     classListModel.value.add(s);
    //   }

    Classes ct = new Classes();
    ct.id = "0";
    ct.className = "Select";
    classListModelMap.value = [ct.toJson()];
    // classListModelMap.value = classListModel.value.map((item) {
    //   return item.toJson();
    // }).toList();
    print("#######${classListModelMap.value}");
    update();
  }

  Future<void> getSectionList() async
  {
    Map<String,dynamic> body = {
      "class_id" : selectedClassId.value
    };
    print("********************${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getSectionListUrl, body);
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