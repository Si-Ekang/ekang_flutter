import 'package:dartz/dartz.dart';
import 'package:ekang_flutter/core/error/failures.dart';
import 'package:ekang_flutter/features/notifications/data/data_sources/notifications_local_data_source.dart';
import 'package:ekang_flutter/features/notifications/data/model/whats_new_model.dart';
import 'package:ekang_flutter/features/notifications/domain/repositories/i_notifications_repository.dart';

/// Concrete implementation of [INotificationsRepository] in the Data layer.
///
/// Dispatches work to the local data source to retrieve notification data.
class NotificationsRepositoryImpl extends INotificationsRepository {
  final INotificationsLocalDataSource _localDataSource;

  /// Creates a [NotificationsRepositoryImpl] with the given local data source.
  NotificationsRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, WhatsNewModel?>> getNewsFeed() =>
      _localDataSource.getNewsFeed();
}
