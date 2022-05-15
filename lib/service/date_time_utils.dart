import 'package:timeago/timeago.dart' as timeago;

class DateTimeUtils {
  DateTimeUtils();
  static String timeAgo(DateTime date) {
    return timeago.format(date);
  }

  static String daysAgo(DateTime date) {
    DateTime now = DateTime.now();
    int diff = date.difference(now).inDays;
    if (diff == 363) {
      return 'Yesterday';
    } else if (diff == 364) {
      return 'Today';
    } else if (diff == 0) {
      return 'Tommorow';
    } else {
      return '$diff';
    }
  }
}
