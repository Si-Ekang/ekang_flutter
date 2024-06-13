part of 'library_bloc.dart';

class LibraryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCsvLibrary extends LibraryEvent {}

class SearchWord extends LibraryEvent {
  final String wordToSearch;

  SearchWord({required this.wordToSearch});

  @override
  List<Object?> get props => [wordToSearch];
}
