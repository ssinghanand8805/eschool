import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../apiHelper/userData.dart';
import '../core/app_export.dart';
import '../presentation/notifications/controller/NotificationController.dart';
import 'NotificationController.dart';



// Top-level function to handle background messages
Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
  showNotification(message.data['title']!, message.data['body']!);
}

// Function to show notification
void showNotification(String title, String body) {
  var random = Random();
  int randomNumber = random.nextInt(100);
  // Assuming NotificationHelperController can be accessed here
  NotificationHelperController.createNewNotificationWithFCm(randomNumber, "alerts", title, body);

  // Ensure GetX is properly initialized to manage Get.put()
  if (Get.isRegistered<NotificationController>()) {
    NotificationController controller = Get.find();
    controller.AddNewNotification(randomNumber, title, body);
  } else {
    Get.put(NotificationController()).AddNewNotification(randomNumber, title, body);
  }
}


class PushNotificationService {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> requestPermission() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User denied or has not accepted permission');
    }
  }

  Future<String?> initialize() async {
    print("Requesting permission...");
    await requestPermission();
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.data['title'] != null && message.data['body'] != null) {
        showNotification(message.data['title']!, message.data['body']!);
      }
    });
    return await getToken();
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    print('FCM Token: $token');
    if (token != null) {
      UserData u = new UserData();
      u.addUserFCMDeviceToken(token);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('currentDeviceToken', token);
    }
    return token;
  }
}


// class PushNotificationService {
//   FirebaseMessaging _fcm = FirebaseMessaging.instance;
//
//   Future<void> requestPermission() async {
//     NotificationSettings settings = await _fcm.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//       // User granted permission
//       // You can now proceed to listen for incoming messages
//     } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//       // User granted provisional permission
//       // You can show some features, and full permission might be required later
//     } else {
//       print('User denied or has not accepted permission');
//       // User denied or has not accepted permission
//       // You might want to inform the user about the functionality limitation
//     }
//     // Additional logic based on permission status can go here
//   }
//
//   Future<String?> initialize() async {
//     print("requesting perm");
//     requestPermission();
//     NotificationHelperController.initializeLocalNotifications();
//
//     return await getToken();
//
//
//   }
//   listen()
//   {
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print('Got a message whilst in the foreground!');
//       var title = message!.data['title']!;
//       var body = message!.data['body']!;
//
//       //print('Got a message whilst in the foreground!${message.sentTime}');
//       print('Message data: ${message.data}');
//       showNotification(message!.data['title']!,message!.data['body']!);
//       // if (message.notification != null) {
//       //
//       //   showNotification(message.notification!.title!,message.notification!.body!);
//       //   print('Message also contained a notification title: ${message.notification!.title}');
//       //   print('Message also contained a notification body: ${message.notification!.body}');
//       // }
//     });
//     FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//   }
//
//   Future<void> backgroundHandler(RemoteMessage message) async {
//     print('Handling a background message ${message.messageId}');
//     showNotification(message!.data['title']!,message!.data['body']!);
//     //showNotification(message.notification!.title!,message.notification!.body!);
//   }
//
//   showNotification(title,body)
//   {
//     var random = Random();
//     int randomNumber = random.nextInt(100);
//     NotificationHelperController.createNewNotificationWithFCm(randomNumber,"alerts",title,body);
//
//     NotificationController controller = Get.put(NotificationController());
//     controller.AddNewNotification(randomNumber,title,body);
//     // Add new notification with an unread status
//
//
//     // Save updated notifications back to storage
//
//   }
//
//
//
//
//   Future<String?> getToken() async {
//     String? token = await _fcm.getToken();
//     UserData u = new UserData();
//     u.addUserFCMDeviceToken(token!);
//     final prefs = await SharedPreferences.getInstance();
//
//     // Write all data to SharedPreferences
//     await prefs.setString('currentDeviceToken', token);
//     print('Token: $token');
//     return token;
//   }
// }