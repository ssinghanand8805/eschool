import 'package:get/get.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/userData.dart';
import 'notice_board_modal.dart';

class NoticeBoardController extends GetxController{
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<NoticeBoard> nodeiceBoardModel = NoticeBoard().obs;
  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
    fetchDataFuture = getData();
  }

  Future<void> getData() async
  {


    print(Constants.getNoticeBoardUrl);
    var data  = await apiRespository.postApiCallByJson(Constants.getNoticeBoardUrl,{});
    print(data.body);
    nodeiceBoardModel.value = NoticeBoard.fromJson(data.body);

    update();
  }
}