import 'package:intl/intl.dart';

class AppController {
  static String changeDateFormat({
    required String dateValue,
    required String oldDateFormat,
    required String newDateFormat,
  }) {
    if (dateValue.isNotEmpty) {
      DateTime dateTime = DateFormat(oldDateFormat).parse(dateValue);
      return DateFormat(newDateFormat).format(dateTime);
    }
    return "";
  }
}
