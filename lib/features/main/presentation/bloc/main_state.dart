part of 'main_bloc.dart';

/// This class has the different states that the bloc is going to be able to emit.
/// I’ve created an extension to handle all the possible states in the view in a short and cleaner way.
/// I use the Equatable library to compare objects in Dart, if you don’t know anything about this, I highly recommend you check the docs:
/// https://pub.dev/packages/equatable.
class MainState extends Equatable {
  final int idSelected;

  const MainState({this.idSelected = 0});

  @override
  List<Object?> get props => [idSelected];

  MainState copyWith({required int idSelected}) {
    return MainState(idSelected: idSelected);
  }

  MainState copyWithState({required MainState newState}) {
    return newState;
  }
}

class HomeState extends MainState {
  @override
  List<Object?> get props => [0];
}

class LibraryState extends MainState {
  @override
  List<Object?> get props => [1];
}

class NotificationState extends MainState {
  @override
  List<Object?> get props => [2];
}

class ProfileState extends MainState {
  @override
  List<Object?> get props => [3];
}
