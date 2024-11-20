
import 'package:get_storage/get_storage.dart';
import 'package:learnladderfaculity/apiHelper/popular_product_repo.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/apiHelper/userData.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../presentation/login_screen/models/ChatUser.dart';
import 'ChatNotificationService.dart';
import 'SocketService.dart';
import 'api.dart';
import 'chatApi.dart';
import 'chat_api_repo.dart';


Future<void> init()async {
  //apiClient

  final prefs = await SharedPreferences.getInstance();

  bool isBaseUrlFound = prefs.containsKey("schoolBaseUrl");
  bool isChatBaseUrlFound = prefs.containsKey("schoolChatBaseUrl");
  String? baseUrlP ;
  String? chatBaseUrlP ;
  if(isBaseUrlFound == true)
    {
      baseUrlP =  prefs.getString("schoolBaseUrl");
      chatBaseUrlP =  prefs.getString("schoolChatBaseUrl");
    }
  else
    {
      // baseUrlP =  "http://172.16.19.96/school3";
//return to main url enter page
    }
  // String? baseUrlP =  prefs.getString("schoolBaseUrl");
  String baseUrl = baseUrlP != null ? baseUrlP!.endsWith("/") ? baseUrlP.toString() : baseUrlP.toString() + "/" : ""; //"http://172.16.19.96/school3/api/"
  if(chatBaseUrlP != null)
    {
      String chatBaseUrl = chatBaseUrlP!.endsWith("/") ? chatBaseUrlP.toString() : chatBaseUrlP.toString() + "/"; //"http://172.16.19.96/school3/api/"
      Get.lazyPut(()=>chatApiClient(appBaseUrl: "${chatBaseUrl}api/"),tag: 'chatApi',fenix: true);
      Get.lazyPut(()=>ChatApiRespository(apiClient: Get.find(tag: 'chatApi')));
    }

  await GetStorage.init();
  Get.lazyPut(()=>ApiClient(appBaseUrl: "${baseUrl}api/"),fenix: true);
  //repose
  Get.lazyPut(()=>ApiRespository(apiClient: Get.find()));






  // Get.lazyPut(()=>ApiClient(appBaseUrl: "${baseUrl}api/"),tag: 'generalApi', fenix: true);
  // Get.lazyPut(()=>ApiRespository(apiClient: Get.find(tag: 'generalApi')));


 // Get.lazyPut(()=>LoginController(popularProductRepo: Get.find()));


}
