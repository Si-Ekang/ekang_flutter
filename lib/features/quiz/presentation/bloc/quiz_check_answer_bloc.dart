import 'package:ekang_flutter/core/utils/log.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quiz_check_answer_state.dart';

class QuizCheckAnswerBloc extends Bloc<QuizEvent, QuizCheckAnswerState> {
  QuizCheckAnswerBloc() : super(QuizCheckAnswerInitialState()) {
    on<QuizEvent>((event, emit) {});
    on<CheckAnswerEvent>(_checkAnswer);
    on<ResetCheckAnswerEvent>(_resetState);
  }

  void _checkAnswer(
    CheckAnswerEvent event,
    Emitter<QuizCheckAnswerState> emit,
  ) async {
    Fimber.d(
        "_checkAnswer() | choice : ${event.choice}, correctAnswer : ${event.correctAnswer}");

    emit(
      state.copyWithState(
        newState: event.choice != event.correctAnswer
            ? QuizCheckAnswerErrorState(
                errorMessage:
                    "Wrong Answer!. The correct answer is ${event.correctAnswer}")
            : QuizCheckAnswerSuccessState(
                encouragementMessage: "Great! Continue like this!"),
      ),
    );
  }

  void _resetState(
    ResetCheckAnswerEvent event,
    Emitter<QuizCheckAnswerState> emit,
  ) {
    Log.d("_resetState", "Resetting state...");
    emit(state.copyWithState(newState: QuizCheckAnswerInitialState()));
  }
}
