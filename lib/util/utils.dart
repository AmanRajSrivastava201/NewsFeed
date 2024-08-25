import 'package:intl/intl.dart';

/// This is utils class for various functions of multiple use-cases
class Utils {
  /// Formats a date from one format to another.
  /// [inputFormat] parameter is the format of the input date.
  /// [outputFormat] parameter is the desired output format.
  /// [date] parameter is the date to be formatted.
  /// Returns a string representing the formatted date.
  static String formatDate(
      String inputFormat, String outputFormat, String date) {
    DateTime parseDate = DateFormat(inputFormat).parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var output = DateFormat(outputFormat);
    var outputDate = output.format(inputDate);
    return outputDate;
  }
}
