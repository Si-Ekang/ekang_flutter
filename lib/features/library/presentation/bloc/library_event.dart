part of 'library_bloc.dart';

class LibraryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCsvLibrary extends LibraryEvent {}

class SearchWord extends LibraryEvent {
  final String word;

  SearchWord(this.word);

  @override
  List<Object?> get props => [word];
}