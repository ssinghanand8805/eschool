import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lerno/theme/theme_controller.dart';
import 'package:lerno/widgets/network_connectivity.dart';
import 'NotificationServices/NotificationController.dart';
import 'apiHelper/dependencies.dart';
import 'core/app_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Get.put(ThemeController());
  init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  // The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    NotificationHelperController.startListeningNotificationEvents();
    Get.put(ThemeController());
    // TODO: implement initState
    Get.put(ConnectionServicess(Connectivity()));
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return GetBuilder(
      init: ThemeController(),
      builder: (context) {
        return Sizer(builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeController().currentTheme,
            translations: AppLocalization(),
            locale: Get.deviceLocale,
            fallbackLocale: Locale('en', 'US'),
            title: 'Lerno',
            initialRoute: AppRoutes.initialRoute,
            getPages: AppRoutes.pages,
          );
        });
      }
    );
  }
}
