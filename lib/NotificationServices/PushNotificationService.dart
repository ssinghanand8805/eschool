import 'package:firebase_messaging/firebase_messaging.dart';

import '../apiHelper/userData.dart';

class PushNotificationService {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialize() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    await getToken();
    //FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  }
  Future<void> backgroundHandler(RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');
  }
  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    UserData u = new UserData();
    u.addUserFCMDeviceToken(token!);
    print('Token: $token');
    return token;
  }
}