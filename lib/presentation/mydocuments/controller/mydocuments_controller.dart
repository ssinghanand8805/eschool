import 'package:learnladder/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/MyDocuments.dart';



class MyDocumentsController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());

  RxList<Documents> documentsModelObj = <Documents>[].obs;
  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
    fetchDataFuture = getData(); // Initialize the future when the controller is created
  }
  Future<void> getData() async
  {
    Map<String,dynamic> body = {
      "student_id" : userData.getUserStudentId
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getDocumentUrl, body);
    print("DATA @@@@ ${data.body}");
    if(data.body.length > 0)
      {
        data.body.forEach((v) {
          documentsModelObj!.add(new Documents.fromJson(v));
        });
      }
    // documentsModelObj.value = Documents.fromJson(data.body);
    print("111111111111111111111 ${documentsModelObj.value}");
    update();
  }
}
