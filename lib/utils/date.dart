import 'package:intl/intl.dart';

String formatForInputField(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatForApiRequest(DateTime date) {
  return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date);
}
