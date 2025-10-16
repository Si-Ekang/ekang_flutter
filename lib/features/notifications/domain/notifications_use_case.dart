import 'package:dartz/dartz.dart';
import 'package:ekang_flutter/core/error/failures.dart';
import 'package:ekang_flutter/features/notifications/data/model/whats_new_model.dart';
import 'package:ekang_flutter/features/notifications/data/repositories/notifications_repository.dart';

class NotificationsUseCases {
  final NotificationsRepositoryImpl _repository;

  NotificationsUseCases(this._repository);

  Future<Either<Failure, WhatsNewModel?>> getNewsFeed() => _repository.getNewsFeed();
}