import 'package:learnladder/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/Books.dart';
import '../model/IssuedBook.dart';



class LibraryController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  Rx<Books>booksModelObj = Books().obs;
  // Rx<IssuedBook>issuedBookModelObj = IssuedBook().obs;
  RxList<IssuedBook> issuedBookModelObj = <IssuedBook>[].obs;
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
      "studentId" : userData.getUserStudentId
    };
    // print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getLibraryBookIssuedsUrl, body);
    // var data  = await apiRespository.getPopularProduct(Constants.getLibraryBookIssuedsUrl);
    print("DATA @@@@ ${data.body}");
    // if(data.body['success'] == 1)
    //   {
    //     issuedBookModelObj.value = IssuedBook.fromJson(data.body);
    //   }
    List<IssuedBook> d = [];
    for(var i =0;i<data.body.length; i++)
    {
      d.add(IssuedBook.fromJson(data.body[i]));
    }
    issuedBookModelObj.value = d;
    print("111111111111111111111 ${issuedBookModelObj.value[0].toJson()}");
    update();
  }
}
