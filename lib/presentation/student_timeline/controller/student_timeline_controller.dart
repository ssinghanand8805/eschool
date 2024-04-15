import 'package:learnladder/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/TimeLine.dart';




class StudentTimeLineController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  RxList<TimeLine> timeLineModelObj = <TimeLine>[].obs;
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
    var data  = await apiRespository.postApiCallByJson(Constants.getTimelineUrl, body);
    print("DATA @@@@ ${data.body}");
    List<TimeLine> d = [];


    for(var i =0;i<data.body.length; i++)
    {
      d.add(TimeLine.fromJson(data.body[i]));
    }
    timeLineModelObj.value = d;
    // noticeBoardModelObj.value = NotiiceBoard.fromJson(data.body);
    // print("111111111111111111111 ${noticeBoardModelObj.value.toJson()}");
    update();
  }
}
