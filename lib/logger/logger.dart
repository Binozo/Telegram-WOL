import 'package:intl/intl.dart';

class Logger {
  static void log(String message) {
    final dateFormat = DateFormat("HH:mm:ss");
    final time = dateFormat.format(DateTime.now());
    print("[$time] $message");
  }
}