import 'package:dartz/dartz.dart';
import 'package:ekang_flutter/core/error/failures.dart';
import 'package:ekang_flutter/features/notifications/data/model/whats_new_model.dart';
import 'package:ekang_flutter/features/notifications/domain/repositories/i_notifications_repository.dart';

/// Use cases related to retrieving and managing notifications/announcements.
class NotificationsUseCases {
  final INotificationsRepository _repository;

  /// Creates a [NotificationsUseCases] instance.
  NotificationsUseCases(this._repository);

  /// Retrieves the current new feature releases list.
  Future<Either<Failure, WhatsNewModel?>> getNewsFeed() => _repository.getNewsFeed();
}