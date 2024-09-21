import 'package:intl/intl.dart';

import '../../apiHelper/GlobalData.dart';

class Utils {
  /// Converts a date string in the format 'yyyy-MM-dd' to 'dd/MM/yyyy'.
  static String formatDateString(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(dateTime);
    } catch (e) {
      print('Error parsing date: $e');
      return dateString; // Return the original date string on error
    }
  }
  static String safeFileUrlHandle(String path,bool isProfile) {
    if(isProfile && path.isNotEmpty)
      {
        if(path.startsWith('http'))
        {
          return path;
        }
        else
        {
          String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
          return baseUrlFromPref + path;
        }
      }
    else if(isProfile && path.isEmpty)
      {
        return "default_no_profile_asset_image";
      }
    else
      {
        return "no file found";
      }


  }


}