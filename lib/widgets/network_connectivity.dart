
import
'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';





class ConnectionServicess extends GetxController {
  Connectivity? connectivity;
  ConnectionServicess(this.connectivity);
  RxBool isConnected = true.obs;


  @override
  void onInit () {
    connectivity!.onConnectivityChanged.listen(updateConnectionState);
    update();
    super.onInit();
  }

  void updateConnectionState(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      print("not connected");
      isConnected.value = false;

      Get.rawSnackbar(
          messageText: Text
            ("Please Connect To Internet ",
            style:
            TextStyle
              (color: Colors.white, fontSize: 16),),
          isDismissible: true,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red,
          icon: Center
            (
              child: Icon
                (
                Icons.wifi_off,
                color: Colors.white,
                size: 35,
              )),
          snackStyle: SnackStyle.GROUNDED);
      update();
    }
    else
    {
      if
      (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();

        if (connectivityResult != ConnectivityResult.none) {
          print("its connected");

          isConnected.value = true;

          Get.rawSnackbar(
              messageText: Text
                ("Back Online",
                style: TextStyle
                  (color: Colors.white,
                    fontSize: 16),
              ),
              isDismissible: false,
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.green,
              icon: Center(
                  child: Icon(
                    Icons.
                    backup_rounded,
                    color: Colors.white,
                    size: 35,
                  )),
              snackStyle: SnackStyle.GROUNDED);

          update();
        }
      }
      update();
    }
  }

}

