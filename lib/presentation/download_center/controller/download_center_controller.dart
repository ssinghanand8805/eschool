import 'package:learnladder/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/DownloadCenter.dart';
import '../model/videoModal.dart';

class DownloadCenterController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  // Rx<DownloadCenter> downloadModelObj = DownloadCenter().obs;
  RxList<DownloadCenter> downloadModelObj = <DownloadCenter>[].obs;
  Rx<VideoDataModal> videoDataModalObj = VideoDataModal().obs;
  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchDataFuture = getDownloadImageData();
    fetchDataFuture = getShowVideoData();
  }

  Future<void> getDownloadImageData() async {
    Map<String, dynamic> body = {
      "student_id": userData.getUserStudentId,
      "role": userData.getRole,
      "classId": 1,
      "sectionId": 1,
    };
    print("Body @@@@ ${body}");
    var data = await apiRespository.postApiCallByJson(
        Constants.getdownloadcontent, body);
    print("DATA @@@@ ${data.body}");

    List<DownloadCenter> d = [];
    for (var i = 0; i < data.body.length; i++) {
      d.add(DownloadCenter.fromJson(data.body[i]));
    }
    downloadModelObj.value = d;
    print("111111111111111111111 ${downloadModelObj.value}");
    update();
  }

  Future<void> getShowVideoData() async {
    Map<String, dynamic> body = {
      "class_id" : 1,
      "section_id" : 1
    };
    print("Body @@@@ ${body}");
    var data =
        await apiRespository.postApiCallByJson(Constants.getVideocontent, body);
    print("DATA @@@@ ${data.body}");
    videoDataModalObj.value = VideoDataModal.fromJson(data.body);
    print("111111111111111111111 ${videoDataModalObj.value.toJson()}");
    update();
  }
}
