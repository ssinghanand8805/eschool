
import 'package:get_storage/get_storage.dart';
import 'package:learnladder/apiHelper/popular_product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'api.dart';


Future<void> init()async {
  //apiClient
  final prefs = await SharedPreferences.getInstance();

  bool isBaseUrlFound = prefs.containsKey("schoolBaseUrl");
  String? baseUrlP ;
  if(isBaseUrlFound == true)
    {
      baseUrlP =  prefs.getString("schoolBaseUrl");
    }
  else
    {
      // baseUrlP =  "http://172.16.19.96/school3";
//return to main url enter page
    }
  // String? baseUrlP =  prefs.getString("schoolBaseUrl");
  String baseUrl = baseUrlP!.endsWith("/") ? baseUrlP.toString() : baseUrlP.toString() + "/"; //"http://172.16.19.96/school3/api/"
  await GetStorage.init();
  Get.lazyPut(()=>ApiClient(appBaseUrl: "${baseUrl}api/"),fenix: true);
  //repose
  Get.lazyPut(()=>ApiRespository(apiClient: Get.find()));

 // Get.lazyPut(()=>LoginController(popularProductRepo: Get.find()));


}
