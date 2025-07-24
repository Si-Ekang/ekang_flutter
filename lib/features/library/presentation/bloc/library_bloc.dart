import 'package:ekang_flutter/core/utils/assets_utils.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  List<List<dynamic>>? filteredVocabulary;
  bool hasBeenLoadedOnce = false;

  LibraryBloc() : super(const LibraryState()) {
    on<GetCsvLibrary>(_loadLibrary);
    on<SearchWord>(_searchWord);
  }

  void _loadLibrary(GetCsvLibrary event, Emitter<LibraryState> emit) async {
    Fimber.d("loadLibrary()");

    final vocabulary = await AssetsUtils.loadCsv(Assets.csvVocabulary);

    if (null == vocabulary) {
      Fimber.e("loadLibrary() | Failed to load vocabulary");
      emit(state.copyWithState(newState: ErrorLoadingLibrary()));
      return;
    }

    List<List<dynamic>> filteredVocabulary = vocabulary
        .map((words) {
          if ("francais" != words[0]) {
            return words;
          }
        })
        .where((word) => null != word)
        .cast<List>()
        .toList();

    Fimber.d("loadLibrary() | filtered list : $filteredVocabulary");

    if (null == this.filteredVocabulary) {
      Fimber.d("loadLibrary() | Save loaded library to local variable");
      this.filteredVocabulary = filteredVocabulary;
      hasBeenLoadedOnce = true;
    }

    if (hasBeenLoadedOnce) {
      Fimber.w(
          "loadLibrary() | Library already loaded once. Reuse the local variable");
      emit(
        state.copyWithState(
          newState: Loaded(
            loaded: this.filteredVocabulary!.isNotEmpty,
            fields: this.filteredVocabulary!,
            data: this.filteredVocabulary!,
          ),
        ),
      );
    } else {
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
  }

  void _searchWord(SearchWord event, Emitter<LibraryState> emit) {
    Fimber.d("searchWord()");

    if (true == filteredVocabulary?.isEmpty) {
      Fimber.e(
          "searchWord() | Unable to search the word : ${event.wordToSearch} list is empty");
    }

    try {
      Fimber.e("searchWord() | Found : ${event.wordToSearch}");
      var wordsFound = filteredVocabulary
          ?.map((words) {
            if (words[0]
                .toString()
                .toLowerCase()
                .startsWith(event.wordToSearch.toLowerCase())) {
              return words;
            }
          })
          .where((word) => null != word)
          .cast<List>()
          .toList();
      Fimber.i("searchWord() | words found : ${wordsFound?.first.toString()}");

      if (null == wordsFound || true == wordsFound.isEmpty) {
        Fimber.e(
            "searchWord() | Unable to search the word : ${event.wordToSearch} list is empty");
        return;
      }

      emit(state.copyWithState(newState: Found(wordsFound)));
    } catch (error, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "searchWord() | exception: $error (stacktrace: ${stacktrace.toString()})");
      }
    }
    /*words(event, emit) => (eventStream, mapper) => eventStream
            .debounceTime(const Duration(milliseconds: 550))
            .distinct()
            .switchMap((mapper) async* {
          if (mapper.isEmpty) {
            Fimber.e("searchWord() | result is empty");
            yield emit(NotFound()); // Yielding the emit call
            return;
          }
          try {
            Fimber.e("searchWord() | Found : $mapper");
            yield Found(mapper);
            emit(state.copyWithState(newState: Found(mapper)));
          } catch (error, stacktrace) {
            if (kDebugMode) {
              Fimber.e(
                  "searchWord() | exception: $error (stacktrace: ${stacktrace.toString()})");
            }
          }
        });*/
  }
}
