import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';

class ConnectivityController {
  ValueNotifier<bool> isConnected = ValueNotifier(false);

  Future<void> init() async {
    if (kDebugMode) {
      Fimber.d('init | await Connectivity().checkConnectivity()');
    }

    List<ConnectivityResult> result = (await Connectivity().checkConnectivity());
    isInternetConnected(result.first);
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
          if (kDebugMode) {
            Fimber.d('onConnectivityChanged | listen | $result');
          }
          isInternetConnected(result);
        // } as ((ConnectivityResult event)?);
        } as void Function(List<ConnectivityResult> event)?);
  }

  bool isInternetConnected(ConnectivityResult? result) {
    if (kDebugMode) {
      Fimber.d('isInternetConnected() | isInternetConnected: $result');
    }

    if (result == ConnectivityResult.none) {
      isConnected.value = false;
      return false;
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      isConnected.value = true;
      return true;
    }
    return false;
  }
}
