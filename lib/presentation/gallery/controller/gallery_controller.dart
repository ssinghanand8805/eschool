import 'package:lerno/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/gallery.dart';
import '../model/images.dart';

class GalleryController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());

  RxList<GalleryModal> galleryModalObj = <GalleryModal>[].obs;
  RxList<ListResult> listModalObj = <ListResult>[].obs;
  RxList<PageContents> PageContentsModalObj = <PageContents>[].obs;
  late Future<void> fetchDataFuture;
  @override
  void onInit() {
    super.onInit();
    getGalleryList();
  }

  Future<void> getGalleryList() async {
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


  Future<void> getGalleryDetailById(String id) async {
    Map<String, dynamic> body = {
      "id": id
    };
    var data =
    await apiRespository.postApiCallByJson(Constants.getGalleryDetailById, body);
    print("DATA @@@@ getGalleryDetailById${data.body}");

    List<PageContents> d = [];
    for (var i = 0; i < data.body['listResult']['page_contents'].length; i++) {
      d.add(PageContents.fromJson(data.body['listResult']['page_contents'][i]));

    }

    PageContentsModalObj.value = d;
    update();
  }

}
