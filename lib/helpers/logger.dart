import 'package:logger/logger.dart';

class SharedLogger {
  static final SharedLogger _singleton = SharedLogger._internal();
  Logger log = Logger(printer: PrettyPrinter());
  Logger noStack = Logger(printer: PrettyPrinter(methodCount: 0));

  factory SharedLogger() {
    return _singleton;
  }

  SharedLogger._internal();
}
