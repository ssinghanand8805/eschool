import 'package:intl/intl.dart';
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


  Future<String> ConvertToSchoolDateTimeFormat(DateTime dateTobeConvert) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dateFormat = prefs.getString('date_format')  ?? 'dd/mm/yyyy';
    print("Found FOrmat: ${dateFormat}");
    // Mapping available formats to their respective patterns
    Map<String, String> formatPatterns = {
      'd-m-Y': 'dd-MM-yyyy',
      'd-M-Y': 'dd-MMM-yyyy',
      'd/m/Y': 'dd/MM/yyyy',
      'd.m.Y': 'dd.MM.yyyy',
      'm-d-Y': 'MM-dd-yyyy',
      'm/d/Y': 'MM/dd/yyyy',
      'm.d.Y': 'MM.dd.yyyy',
      'Y/m/d': 'yyyy/MM/dd',
    };
    // Get the corresponding pattern for the selected date format
    String pattern = formatPatterns[dateFormat] ?? 'dd/MM/yyyy'; // Default format if not found
    String formattedDate = DateFormat(pattern).format(dateTobeConvert);
    return formattedDate;

    //return converted date format
  }


}
