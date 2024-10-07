import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:async';

class ConnectivityController extends GetxController {
  late StreamSubscription<ConnectivityResult> _subscription;
  var isConnected = true.obs;
  bool hasShownToast = false;

  @override
  void onInit() {
    super.onInit();
    checkConnectivity();
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }

  void checkConnectivity() {
    _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        isConnected.value = false;
        if (!hasShownToast) {
          showToast("No internet connection", Colors.red, 5);
          hasShownToast = true;
        }
      } else {
        isConnected.value = true;
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
      fontSize: 16.0,
    );
    Timer(Duration(seconds: seconds), () {
      Fluttertoast.cancel();
    });
  }
}
