import 'package:lerno/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/gallery.dart';

class GalleryController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());

  RxList<GalleryImage> issuedBookModelObj = <GalleryImage>[].obs;
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

  Future<void> getData() async {
    Map<String, dynamic> body = {"studentId": userData.getUserStudentId};
    var data = await apiRespository.postApiCallByJson(
        Constants.getLibraryBookIssuedsUrl, body);

    print("DATA @@@@ ${data.body}");

    List<GalleryImage> d = [];
    for (var i = 0; i < data.body.length; i++) {
      d.add(GalleryImage.fromJson(data.body[i]));
    }
    issuedBookModelObj.value = d;
    print("111111111111111111111 ${issuedBookModelObj.value[0].toJson()}");
    update();
  }
}
