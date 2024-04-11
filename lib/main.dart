import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'NotificationServices/PushNotificationService.dart';
import 'apiHelper/dependencies.dart';
import 'core/app_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  final PushNotificationService _notificationService = PushNotificationService();
  @override
  Widget build(BuildContext context) {
    _notificationService.initialize();
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        translations: AppLocalization(),
        locale: Get.deviceLocale,
        fallbackLocale: Locale('en', 'US'),
        title: 'anand_s_application1',
        initialRoute: AppRoutes.initialRoute,
        // onLaunch: (Map<String, dynamic> message) async {
        //   print('onLaunch: $message');
        //   // Handle the notification
        // },
        // onResume: (Map<String, dynamic> message) async {
        //   print('onResume: $message');
        //   // Handle the notification
        // },
        getPages: AppRoutes.pages,
      );
    });
  }
}
