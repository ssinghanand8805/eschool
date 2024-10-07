
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lerno/apiHelper/popular_product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'api.dart';


Future<void> init()async {
  //apiClient
  checkConnectivity();
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
late StreamSubscription<ConnectivityResult> subscription;
bool hasShownToast = false;

void checkConnectivity() {
  subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    print("bfddbhfbdhfhbdfdb");
    if (result == ConnectivityResult.none ) {
      showToast("No internet connection", Colors.red, 5);
      hasShownToast = true;
    } else if (result != ConnectivityResult.none) {
      if (hasShownToast) {
        showToast("Internet connected", Colors.green, 5);
        hasShownToast = false;
      }
    }
  });
}

  void showToast(String message, Color backgroundColor, int seconds) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 12.0,
    );
    Timer(Duration(seconds: seconds), () {
      Fluttertoast.cancel();
    });
  }

