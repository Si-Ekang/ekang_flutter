import 'dart:typed_data';

import 'package:ekang_flutter/features/notifications/data/model/whats_new_model.dart';
import 'package:equatable/equatable.dart';

/// This class has the different states that the bloc is going to be able to emit.
/// I’ve created an extension to handle all the possible states in the view in a short and cleaner way.
/// I use the Equatable library to compare objects in Dart, if you don’t know anything about this, I highly recommend you check the docs:
/// https://pub.dev/packages/equatable.
class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];

  NotificationsState copyWithState({required NotificationsState newState}) {
    return newState;
  }
}

final class NotificationsInitial extends NotificationsState {}

final class NotificationsLoading extends NotificationsState {}

final class NotificationsSuccess extends NotificationsState {
  final WhatsNewModel model;

  const NotificationsSuccess({required this.model});

  @override
  List<Object?> get props => [model];
}

final class NotificationsError extends NotificationsState {
  final String error;

  const NotificationsError({required this.error});

  @override
  List<Object?> get props => [error];
}


final class NotificationsLoadingImageSuccess extends NotificationsState {
  final Uint8List imageData;

  const NotificationsLoadingImageSuccess({required this.imageData});

  @override
  List<Object?> get props => [imageData];
}

final class NotificationsLoadingImageError extends NotificationsState {
  final String error;

  const NotificationsLoadingImageError({required this.error});

  @override
  List<Object?> get props => [error];
}

