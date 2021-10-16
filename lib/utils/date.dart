import 'package:intl/intl.dart';
import 'package:servio/utils/date_time.dart';

String formatForInputField(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatForShadowDate(DateTime date) {
  final d = date.copyWith(day: date.day - 7);
  return DateFormat('yyyy-MM-dd').format(d);
}

String formatForApiRequest(DateTime date) {
  return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date);
}
