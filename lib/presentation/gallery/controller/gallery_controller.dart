import 'package:lerno/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/gallery.dart';

class GalleryController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  RxList<GalleryModal> galleryModalObj = <GalleryModal>[].obs;
  late Future<void> fetchDataFuture;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    Map<String, dynamic> body = {};

    var data =
        await apiRespository.postApiCallByJson(Constants.getGalleryList, body);
    print("DATA @@@@ ${data.body}");

    List<GalleryModal> d = [];
    for (var i = 0; i < data.body['listResult'].length; i++) {
      d.add(GalleryModal.fromJson(data.body['listResult'][i]));

    }
    galleryModalObj.value = d;

    update();
  }
}
