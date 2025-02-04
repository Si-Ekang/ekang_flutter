import 'package:csv/csv.dart';
import 'package:ekang_flutter/core/utils/assets_utils.dart';
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

    final vocabulary = await AssetsUtils.loadCsv(Assets.csvVocabulary);

    if(null == vocabulary) {
      Fimber.e("loadLibrary() | Failed to load vocabulary");
      emit(state.copyWithState(newState: ErrorLoadingLibrary()));
      return;
    }

    List<List<dynamic>> filteredVocabulary = vocabulary
        .map((words) {
      if("francais" != words[0]){
        return words;
      }
    })
        .where((word) => null != word)
        .cast<List>()
        .toList();

    Fimber.d("loadLibrary() | filtered list : $filteredVocabulary");

    emit(
      state.copyWithState(
        newState: Loaded(
          loaded: filteredVocabulary.isNotEmpty,
          fields: filteredVocabulary,
          data: filteredVocabulary,
        ),
      ),
    );
  }

  void _searchWord(SearchWord event, Emitter<LibraryState> emit) {
    Fimber.d("searchWord()");

    words(event, emit) => (eventStream, mapper) => eventStream
        .debounceTime(const Duration(milliseconds: 550))
        .distinct()
        .switchMap(mapper);

    emit(state.copyWithState(newState: Found(List.empty())));
  }
}
