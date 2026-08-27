import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static String currency(double amount) {
    return NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(amount);
  }

  static String date(DateTime? dt) {
    if (dt == null) return 'N/A';
    return DateFormat('MMM dd, yyyy').format(dt);
  }

  static String dateTime(DateTime? dt) {
    if (dt == null) return 'N/A';
    return DateFormat('MMM dd, yyyy h:mm a').format(dt);
  }

  static String duration(int minutes) {
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (hours > 0) {
      return '${hours}h ${mins > 0 ? "${mins}m" : ""}';
    }
    return '${mins}m';
  }
}
