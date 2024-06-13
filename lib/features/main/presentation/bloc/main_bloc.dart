import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<GetCategories>(_mapGetMainEventToState);
    on<SelectCategory>(_mapSelectMainEventToState);
  }

  void _mapGetMainEventToState(
    GetCategories event,
    Emitter<MainState> emit,
  ) async {
    if (kDebugMode) {
      Fimber.d('_mapGetMainEventToState()');
    }
    emit(state.copyWith(idSelected: 0));
    // emit(state.copyWithState(newState: HomeState()));
  }

  void _mapSelectMainEventToState(
    SelectCategory event,
    Emitter<MainState> emit,
  ) async {
    if (kDebugMode) {
      Fimber.d(
          '_mapSelectMainEventToState() | idSelected: ${event.idSelected}');
    }
    emit(state.copyWith(idSelected: event.idSelected));
    /*switch (event.idSelected) {
      case 0: emit(state.copyWithState(newState: HomeState()));
    break;
      case 1: emit(state.copyWithState(newState: LibraryState()));
    break;
      case 2: emit(state.copyWithState(newState: NotificationState()));
    break;
      case 3: emit(state.copyWithState(newState: ProfileState()));
    break;
      default:
        {
          if (kDebugMode) {
            Fimber.e('_MainPage | BlocBuilder | default case | $state');
          }
        }
        break;
    }*/
  }
}
