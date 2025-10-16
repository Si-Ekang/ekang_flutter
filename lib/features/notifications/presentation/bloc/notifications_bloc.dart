import 'dart:typed_data';

import 'package:ekang_flutter/features/notifications/domain/notifications_use_case.dart';
import 'package:ekang_flutter/features/notifications/presentation/bloc/notifications_state.dart';
import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notifications_event.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {

  final NotificationsUseCases useCases;

  var imageData;

  NotificationsBloc({
    required this.useCases,
  }) : super(NotificationsInitial()) {
    on<NotificationsEvent>(_getNewsFeed);
    on<NotificationsLoadImageEvent>(_getImagesFromFirebaseStorage);
  }

  void _getNewsFeed(
    NotificationsEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    var result = await useCases.getNewsFeed();
    result.fold((failure) {
      emit(state.copyWithState(
          newState: NotificationsError(error: failure.message.toString())));
    }, (whatsNewModel) {
      if (null != whatsNewModel) {
        emit(state.copyWithState(
            newState: NotificationsSuccess(model: whatsNewModel)));
      }
    });
  }

  void _getImagesFromFirebaseStorage(
    NotificationsLoadImageEvent event,
    Emitter<NotificationsState> emit,
  ) async {
    Fimber.d("_getImagesFromFirebaseStorage()");

    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

    // Create a reference with an initial file path and name
    final pathReference = storageRef.child(
        "images/background_los_angeles_california_sunset_palm_trees_portrait.jpg");

    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await pathReference.getData(5 * oneMegabyte);

      if(null == data){
        emit(state.copyWithState(newState: NotificationsLoadingImageError(error: "Error while loading image.")));
        return;
      }

      // Data for "images/island.jpg" is returned, use this as needed.
      imageData = data;

      // emit(state.copyWithState(newState: NotificationsLoadingImageSuccess(imageData: imageData)));
    } on FirebaseException catch (exception, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "_getImagesFromFirebaseStorage() | exception: $exception (stacktrace: ${stacktrace.toString()})");
      }

      // Handle any errors.
      emit(state.copyWithState(
          newState: NotificationsLoadingImageError(
              error: exception.message.toString())));
    }
  }
}
