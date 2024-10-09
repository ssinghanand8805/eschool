import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/theme/theme_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  // Default theme
  ThemeData _currentTheme = ThemeHelper().getThemeData(); // or darkTheme based on your requirements

  ThemeData get currentTheme => _currentTheme;
  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPreferences(); // Load the theme when controller initializes
  }

  // Asynchronous method to load the theme from SharedPreferences
  Future<void> _loadThemeFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs.getString('themeStyle'); // Retrieve the saved theme

    if (savedTheme == '1') {
      toggleTheme(true);
    } else {
      toggleTheme(true);
    }

    update(); // Update the UI with the loaded theme
  }
  // Function to toggle theme
  void toggleTheme(isNanhe) {
    _currentTheme = isNanhe ? ThemeHelper().getThemeData() : ThemeHelper().getThemeData2();
    update(); // Update the UI
  }

  // void getThemeBasedOnSharedPref() {
  //
  //   _currentTheme = isNanhe ? ThemeHelper().getThemeData() : ThemeHelper().getThemeData2();
  //   update(); // Update the UI
  // }


}
