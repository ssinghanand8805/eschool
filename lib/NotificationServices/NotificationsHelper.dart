import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationsHelper {
  // prevent making instance
  NotificationsHelper._();

  // Notification lib
  static AwesomeNotifications awesomeNotifications = AwesomeNotifications();

  static int _createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  static init() async {
    await _initNotification();
    await awesomeNotifications.requestPermissionToSendNotifications();
  }

  ///init notifications channels
  static _initNotification() async {
    await awesomeNotifications.initialize(
      null, // null mean it will show app icon on the notification (status bar)
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,)
      ],
    );

  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    Map<String, String?>? payload = receivedAction.payload;
  }
}