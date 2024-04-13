import 'package:learnladder/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/fees_modal.dart';



class FeesController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<FeesDataModal> feesDataModal = FeesDataModal().obs;
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
    var data  = await apiRespository.postApiCallByJson(Constants.gettransportroutesUrl, body);
    print("DATA TransportRoute ${data.body}");


    feesDataModal.value = FeesDataModal.fromJson(data.body);


     print("111111111111111111111 ${feesDataModal.value.toJson()}");
    update();
  }
}
