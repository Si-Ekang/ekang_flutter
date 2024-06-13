part of 'library_bloc.dart';

/// This class has the different states that the bloc is going to be able to emit.
/// I’ve created an extension to handle all the possible states in the view in a short and cleaner way.
/// I use the Equatable library to compare objects in Dart, if you don’t know anything about this, I highly recommend you check the docs:
/// https://pub.dev/packages/equatable.
class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object?> get props => [];

  LibraryState copyWithState({required LibraryState newState}) {
    return newState;
  }
}

class Idle extends LibraryState {
  @override
  List<Object?> get props => [];
}

class Loaded extends LibraryState {
  final bool loaded;

  final List<List<dynamic>> fields;

  final List<List<dynamic>> data;

  const Loaded({
    required this.loaded,
    required this.fields,
    required this.data,
  });

  @override
  List<Object?> get props => [loaded, fields, data];
}

class Found extends LibraryState {
  final List<List<dynamic>> words;

  const Found(this.words);

  @override
  List<Object?> get props => [words];
}

class NotFound extends LibraryState {}
