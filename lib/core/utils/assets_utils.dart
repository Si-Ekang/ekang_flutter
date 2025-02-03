import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
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

    // Add custom detector to handle csv parsing on multiple platforms,
    // because file systems are not the same on Windows OS and Linux-based OS
    var occurrenceSettingDetector = FirstOccurrenceSettingsDetector(
      eols: ['\r\n', '\n'],
      textEndDelimiters: ["'",'"']
    );

    try {
      final input = await rootBundle.loadString(filename);
      final fields = CsvToListConverter(
               csvSettingsDetector: occurrenceSettingDetector,
               fieldDelimiter: ';',
           ).convert(input);
      Fimber.d("fields : $fields");
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
