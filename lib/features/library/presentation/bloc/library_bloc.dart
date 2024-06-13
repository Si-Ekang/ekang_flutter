import 'package:csv/csv.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc() : super(const LibraryState()) {
    on<GetCsvLibrary>(_loadLibrary);
    on<SearchWord>(_searchWord);
  }

  void _loadLibrary(GetCsvLibrary event, Emitter<LibraryState> emit) async {
    Fimber.d("loadLibrary()");

    final input = await rootBundle.loadString(Assets.csvVocabulary);
    final fields = const CsvToListConverter(fieldDelimiter: ';').convert(input);

    emit(state.copyWithState(
        newState: Loaded(
      loaded: fields.isNotEmpty,
      fields: fields,
      data: fields,
    )));
  }

  void _searchWord(SearchWord event, Emitter<LibraryState> emit) {
    Fimber.d("searchWord()");

    var words = (event, emit) => (eventStream, mapper) => eventStream
        .debounceTime(const Duration(milliseconds: 550))
        .distinct()
        .switchMap(mapper);

    emit(state.copyWithState(newState: Found(List.empty())));
  }
}
