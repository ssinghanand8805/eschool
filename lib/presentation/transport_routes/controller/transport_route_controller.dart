import 'package:lerno/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/transport_route_modal.dart';



class TransportRoutesController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  // Rx<NotiiceBoard> noticeBoardModelObj = NotiiceBoard().obs;
  Rx<TransportRoutesModal>  transportRouteModal = TransportRoutesModal().obs;
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
    transportRouteModal.value = TransportRoutesModal.fromJson(data.body);

     print("111111111111111111111 ${transportRouteModal.value.toJson()}");
    update();
  }
}
