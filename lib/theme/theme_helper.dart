import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lerno/theme/theme_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_export.dart';
import 'package:http/http.dart' as http;

PrimaryColors get appTheme => ThemeHelper().themeColor();

ThemeData get theme => Get.find<ThemeController>().currentTheme;

/// Helper class for managing themes and colors.
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ThemeHelper {

  // The current app theme
  var _appTheme = PrefUtils().getThemeData();

// A map of custom color themes supported by the app
  Map<String, PrimaryColors> _supportedCustomColor = {
    'primary': PrimaryColors()
  };

// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    PrefUtils().setThemeData(_newTheme);
    Get.forceAppUpdate();
  }

  Future<dynamic> downloadAndSaveImage(String url, String fileName) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    File file = File('$tempPath/$fileName');
    if (await file.exists()) {
      await file.delete();
    }

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Write the bytes of the downloaded image.
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      return null;
    }
  }



  setAndChangeThemeThroughSharedPref(data) async {
    isNanheMunhe =  data.body["school_details"]["themeStyle"] == "1"?true:false;
    final themeController = Get.find<ThemeController>();
    themeController.toggleTheme(isNanheMunhe);
    print("school name ${data.body["school_details"]["name"]}");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("schoolName", data.body["school_details"]["name"] ?? "");
    await prefs.setString("schoolAddress", data.body["school_details"]["address"] ?? "");
    await prefs.setString("schoolPhone", data.body["school_details"]["phone"] ?? "");
    await prefs.setString("schoolEmail", data.body["school_details"]["email"] ?? "");
    await prefs.setString("schoolImage", data.body["school_details"]["image"] ?? "");
    await prefs.setString("themeStyle", data.body["school_details"]["themeStyle"] ?? "");
    String spImage = "assets/projectImages/friendship.png";
    if (data.body["school_details"].containsKey("app_splash_screen_file")) {
      var spUrl = data.body["school_details"]["app_splash_screen_file"];
      String fileName = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString() +
          "splashScreen.png";

      downloadAndSaveImage(spUrl, fileName).then((spfile) {
        if (spfile != null) {
          spImage = spfile.path;

          // Save the path in SharedPreferences
          prefs.setString("app_splash_screen_file", spImage);
        }
      }).catchError((error) {
        // Handle any errors that might occur during the download
        print("Error downloading image: $error");
        // prefs.setString("app_splash_screen_file", spImage);
        prefs.remove("app_splash_screen_file");
      });


      await prefs.setString("app_icon",
          data.body["school_details"]["app_icon"] ?? "assets/projectImages/student.png");
      await prefs.setString("app_name", data.body["app_name"] ?? "Lerno");

    }
  }
  /// Returns the primary colors for the current theme.
  PrimaryColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? PrimaryColors();
  }
   getValueFromPrefs(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);
    print("GET VALUE !!! $value" );
    return value;
  }
bool isNanheMunhe = false;
  /// Returns the current theme data.
  ///
  ///

  ThemeData getThemeData()  {

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      // canvasColor: Colors.indigo,
      appBarTheme: AppBarTheme(color: Colors.green.shade100),
      primaryIconTheme: IconThemeData(color: Colors.green),
      scaffoldBackgroundColor: Colors.white,
      primaryColor:Colors.green.shade100,
      primaryColorLight: Colors.green.shade50,
      primaryColorDark: Colors.green.shade900,
      iconTheme: IconThemeData(color: Colors.green),
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }


  ThemeData getThemeData2()  {

    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
    return ThemeData(
      // canvasColor: Colors.indigo,
      appBarTheme: AppBarTheme(color: Colors.blue.shade100),
      primaryIconTheme: IconThemeData(color: Colors.green),
      scaffoldBackgroundColor: Colors.white,
      primaryColor:Colors.blue.shade100,
      primaryColorLight: Colors.blue.shade50,
      primaryColorDark: Colors.blue.shade900,
      iconTheme: IconThemeData(color: Colors.green),
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appTheme.indigo400,
          fontSize: 16.fSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: appTheme.black900,
          fontSize: 15.fSize,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: appTheme.black900,
          fontSize: 10.fSize,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          //color: colorScheme.onPrimary,
          fontSize: 18.fSize,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          fontSize: 10.fSize,
          fontFamily: 'Open Sans',
          fontWeight: FontWeight.w800,
        ),
       titleMedium: TextStyle(
         // color: colorScheme.onPrimary,
          fontSize: 13.fSize,
          fontFamily: 'Open Sans',
         // fontWeight: FontWeight.w500,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    primary: Color(0XFF0C46C4),
    primaryContainer: Color(0XE5E6E6E6),
    onPrimary: Color(0XFFFFFFFF),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {

  // Black
  Color get black900 => Color(0XFF000000);

// BlueGray
  Color get blueGray400 => Color(0XFF888888);

// Gray
  Color get gray400 => Color(0XFFC4C4C4);
  Color get gray40001 => Color(0XFFB3B3B3);

// Indigo
  Color get indigo400 => Color(0XFF5B58AD);

// Teal
  Color get teal400 => Color(0XFF28C2A0);
}
