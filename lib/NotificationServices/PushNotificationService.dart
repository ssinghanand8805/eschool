import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_storage/get_storage.dart';

import '../apiHelper/userData.dart';
import '../core/app_export.dart';
import '../presentation/notifications/controller/NotificationController.dart';
import 'NotificationController.dart';


class PushNotificationService {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> requestPermission() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // User granted permission
      // You can now proceed to listen for incoming messages
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
      // User granted provisional permission
      // You can show some features, and full permission might be required later
    } else {
      print('User denied or has not accepted permission');
      // User denied or has not accepted permission
      // You might want to inform the user about the functionality limitation
    }
    // Additional logic based on permission status can go here
  }

  Future initialize() async {

    requestPermission();
    NotificationHelperController.initializeLocalNotifications();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      var title = message!.data['title']!;
      var body = message!.data['body']!;

      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      showNotification(message!.data['title']!,message!.data['body']!);
      // if (message.notification != null) {
      //
      //   showNotification(message.notification!.title!,message.notification!.body!);
      //   print('Message also contained a notification title: ${message.notification!.title}');
      //   print('Message also contained a notification body: ${message.notification!.body}');
      // }
    });
    await getToken();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  }
  Future<void> backgroundHandler(RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');
    showNotification(message!.data['title']!,message!.data['body']!);
    //showNotification(message.notification!.title!,message.notification!.body!);
  }

  showNotification(title,body)
  {
    var random = Random();
    int randomNumber = random.nextInt(100);
    NotificationHelperController.createNewNotificationWithFCm(randomNumber,"alerts",title,body);

    NotificationController controller = Get.put(NotificationController());
    controller.AddNewNotification(randomNumber,title,body);
    // Add new notification with an unread status


    // Save updated notifications back to storage

  }




  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    UserData u = new UserData();
    u.addUserFCMDeviceToken(token!);
    print('Token: $token');
    return token;
  }
}