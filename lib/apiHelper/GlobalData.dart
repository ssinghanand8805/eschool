import 'package:shared_preferences/shared_preferences.dart';

class GlobalData {
  static final GlobalData _instance = GlobalData._internal();
  factory GlobalData() {
    return _instance;
  }
  GlobalData._internal();

  String baseUrlValueFromPref = '';

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String ur = prefs.getString('schoolBaseUrl') ?? 'http://aatreya.avadhconnect.com/';
    String baseUrl = ur.toString().endsWith("/") ? ur.toString() :ur.toString().toString() + "/";
    baseUrlValueFromPref = baseUrl;
  }
}
