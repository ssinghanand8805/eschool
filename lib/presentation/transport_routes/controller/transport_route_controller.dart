import 'package:learnladder/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/transport_route_modal.dart';



class TransportRoutesController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  // Rx<NotiiceBoard> noticeBoardModelObj = NotiiceBoard().obs;
  RxList<TransportRoute>  transportRouteModal = <TransportRoute>[].obs;
  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
    // fetchDataFuture = getData(); // Initialize the future when the controller is created
  }
  Future<void> getData() async
  {
    Map<String,dynamic> body = {
      "student_id" : userData.getUserStudentId
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.gettransportUrl, body);
    print("DATA TransportRoute ${data.body}");
    List<TransportRoute> d = [];
    for(var i =0;i<data.body.length; i++)
    {
      d.add(TransportRoute.fromJson(data.body[i]));
    }

   transportRouteModal.value = d;
     print("111111111111111111111 ${transportRouteModal.value[0].toJson()}");
    update();
  }
}
