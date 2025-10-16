import 'package:dartz/dartz.dart';
import 'package:ekang_flutter/core/error/failures.dart';
import 'package:ekang_flutter/features/notifications/data/data_sources/notifications_local_data_source.dart';
import 'package:ekang_flutter/features/notifications/data/model/whats_new_model.dart';

//////////////////////////////////////
// Interface
//////////////////////////////////////
abstract class INotificationsRepository {
  Future<Either<Failure, WhatsNewModel?>> getNewsFeed();
}

class NotificationsRepositoryImpl extends INotificationsRepository {
  final NotificationsLocalDataSource _localDataSource;

  NotificationsRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, WhatsNewModel?>> getNewsFeed() =>
      _localDataSource.getNewsFeed();
}
