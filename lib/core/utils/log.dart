import 'dart:developer';
import 'dart:io';

import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';

class Log {
  // Single instantiation only
  static final Log _singleton = Log._();

  // Returns value of the instantiation
  factory Log() => _singleton;

  // Private constructor
  Log._();

  static void d(String method, String message, [String? tag]) {
    if (kDebugMode) {
      if (kIsWeb) {
        log("${tag != null ? '[$tag] ' : ''}$method() | $message");
        return;
      }
      if (Platform.isAndroid) {
        if (null == tag) {
          Fimber.d("$method() | $message");
        } else {
          Fimber.withTag(tag, (fimberLog) {
            fimberLog.d("$method() | $message");
          });
        }
      } else if (Platform.isIOS) {
        if (null == tag) {
          Fimber.d("$method() | $message");
        } else {
          log("[$tag] $method() | $message");
        }
      } else {
        log("${tag != null ? '[$tag] ' : ''}$method() | $message");
      }
    }
  }

  static void e(String method, String message, [String? tag]) {
    if (kDebugMode) {
      if (kIsWeb) {
        log("[ERROR] ${tag != null ? '[$tag] ' : ''}$method() | $message");
        return;
      }
      if (Platform.isAndroid) {
        if (null == tag) {
          Fimber.e("$method() | $message");
        } else {
          Fimber.withTag(tag, (fimberLog) {
            fimberLog.e("$method() | $message");
          });
        }
      } else if (Platform.isIOS) {
        if (null == tag) {
          Fimber.d("$method() | $message");
        } else {
          log("[$tag] $method() | $message");
        }
      } else {
        log("[ERROR] ${tag != null ? '[$tag] ' : ''}$method() | $message");
      }
    }
  }

  static void i(String method, String message, [String? tag]) {
    if (kDebugMode) {
      if (kIsWeb) {
        log("[INFO] ${tag != null ? '[$tag] ' : ''}$method() | $message");
        return;
      }
      if (Platform.isAndroid) {
        if (null == tag) {
          Fimber.i("$method() | $message");
        } else {
          Fimber.withTag(tag, (fimberLog) {
            fimberLog.i("$method() | $message");
          });
        }
      } else if (Platform.isIOS) {
        if (null == tag) {
          Fimber.d("$method() | $message");
        } else {
          log("[$tag] $method() | $message");
        }
      } else {
        log("[INFO] ${tag != null ? '[$tag] ' : ''}$method() | $message");
      }
    }
  }

  static void w(String method, String message, [String? tag]) {
    if (kDebugMode) {
      if (kIsWeb) {
        log("[WARN] ${tag != null ? '[$tag] ' : ''}$method() | $message");
        return;
      }
      if (Platform.isAndroid) {
        if (null == tag) {
          Fimber.w("$method() | $message");
        } else {
          Fimber.withTag(tag, (fimberLog) {
            fimberLog.w("$method() | $message");
          });
        }
      } else if (Platform.isIOS) {
        if (null == tag) {
          Fimber.d("$method() | $message");
        } else {
          log("[$tag] $method() | $message");
        }
      } else {
        log("[WARN] ${tag != null ? '[$tag] ' : ''}$method() | $message");
      }
    }
  }
}

