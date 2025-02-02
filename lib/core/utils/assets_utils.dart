import 'package:csv/csv.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AssetsUtils {
  static AssetsUtils? _instance;

  AssetsUtils._();

  factory AssetsUtils() => AssetsUtils._instance ??= AssetsUtils();

  /*factory AssetsUtils() => _this;
  AssetsUtils._();
  static final AssetsUtils _this = AssetsUtils._();*/

  static Future<List<List<dynamic>>?> loadCsv(String filename) async {
    Fimber.d("loadCsv()");

    try {
      final input = await rootBundle.loadString(filename);
      final fields =
          const CsvToListConverter(fieldDelimiter: ';').convert(input);
      if (null != fields) {
        Fimber.d("fields : $fields");
      }
      return fields;
    } catch (exception, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "loadCsv() | exception: $exception (stacktrace: ${stacktrace.toString()})");
      }
      return null;
    }
  }
}
