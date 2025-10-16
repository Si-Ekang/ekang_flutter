import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ekang_flutter/core/error/failures.dart';
import 'package:ekang_flutter/features/notifications/data/model/whats_new_model.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

//////////////////////////////////////
// Interface
//////////////////////////////////////
abstract class INotificationsLocalDataSource {
  Future<Either<Failure, WhatsNewModel?>> getNewsFeed();
}

//////////////////////////////////////
// Implementation
//////////////////////////////////////
class NotificationsLocalDataSource extends INotificationsLocalDataSource {
  @override
  Future<Either<Failure, WhatsNewModel?>> getNewsFeed() async {
    Fimber.d("getNewsFeed()");

    try {
      // Sample usage
      final jsonString = await rootBundle.loadString('assets/json/whats_new_v_1_0_2.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final whatsNew = WhatsNewModel.fromJson(jsonData);

      if (kDebugMode) {
        print(whatsNew.version); // "1.2.0"
        print(whatsNew.features.first.title); // "Google Account Login"
      }

      return Right(whatsNew);
    } catch (error, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "getNewsFeed() | exception: $error (stacktrace: ${stacktrace.toString()})");
      }
      return const Left(Failure("Unexpected error please try again later"));
    }
  }
}
