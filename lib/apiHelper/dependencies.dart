
import 'package:get_storage/get_storage.dart';
import 'package:learnladder/apiHelper/popular_product_repo.dart';
import 'package:get/get.dart';



import 'api.dart';


Future<void> init()async {
  //apiClient
  await GetStorage.init();
  Get.lazyPut(()=>ApiClient(appBaseUrl: "http://172.16.19.96/school3/api/"),fenix: true);
  //repose
  Get.lazyPut(()=>ApiRespository(apiClient: Get.find()));

 // Get.lazyPut(()=>LoginController(popularProductRepo: Get.find()));


}
