import 'package:intl/intl.dart';

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


}