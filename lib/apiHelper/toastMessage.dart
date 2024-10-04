import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/theme_helper.dart';

class Ui {
  static GetSnackBar SuccessSnackBar({String title = 'Success', required String message}) {
    Get.log("[$title] $message");
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.bodyLarge?.merge(const TextStyle(color: Colors.white))),
      messageText: Text(message, style: Get.textTheme.bodyMedium?.merge(const TextStyle(color: Colors.white))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: const Color.fromRGBO(0, 128, 0 ,1),
      icon: const Icon(Icons.check_circle_outline, size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 3),
    );
  }

  static GetSnackBar ErrorSnackBar({String title = 'Error', required String message}) {
    Get.log("[$title] $message", isError: true);
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.bodyLarge?.merge(const TextStyle(color: Colors.white))),
      messageText: Text(message.substring(0, min(message.length, 200))
          , style: Get.textTheme.bodyMedium?.merge(const TextStyle(color:   Colors.white))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: const Color.fromRGBO(255, 0, 0 , 1),
      icon: const Icon(Icons.error, size: 32,color:   Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  static GetSnackBar defaultSnackBar({String title = 'Alert', required String message}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      titleText: Text(title.tr, style: Get.textTheme.bodyLarge?.merge(const TextStyle(color:Colors.white))),
      messageText: Text(message, style: Get.textTheme.bodyMedium?.merge(const TextStyle(color:Colors.white))),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
      backgroundColor: const Color.fromRGBO(0, 0, 255 ,1),
      borderColor: Colors.white.withOpacity(0.5),
      icon: const Icon(Icons.warning_amber_rounded, size: 32, color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  static GetSnackBar notificationSnackBar({String title = 'Notification',
    required String message, required OnTap onTap, required Widget mainButton}) {
    Get.log("[$title] $message", isError: false);
    return GetSnackBar(
      onTap: onTap,
      mainButton: mainButton,
      titleText: Text(title.tr, style: Get.textTheme.bodyLarge?.merge(const TextStyle(color: Colors.white))),
      messageText: Text(message, style: Get.textTheme.bodyMedium?.merge(const TextStyle(color:Colors.white))),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      backgroundColor: const Color.fromRGBO(0,0,255,1),
      borderColor: Get.theme.focusColor.withOpacity(0.1),
      icon: const Icon(Icons.notifications_none, size: 32, color:Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
    );
  }

  static NoDataWidget() {
    return Center(
      child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/projectImages/no_data.png",
          ),
          const SizedBox(height: 16),
          Text(
            'No data found!',
            style: theme.textTheme.titleMedium,
          )
        ],
      ),
    );
  }

}