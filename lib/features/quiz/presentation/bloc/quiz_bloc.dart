import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:ekang_flutter/core/utils/assets_utils.dart';
import 'package:ekang_flutter/features/quiz/data/models/quizz.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  int currentQuizIndex = -1;
  int totalQuestions = 0;
  bool isLastQuestion = false;
  bool isFirstQuestion = false;

  // bool isFirstQuestion = this.currentQuizIndex  == this.totalQuestions - 1 ;

  QuizBloc() : super(QuizInitial()) {
    on<QuizEvent>((event, emit) {});
    on<LoadQuizEvent>(_loadQuiz);
    on<QuizStartedEvent>(_startQuiz);
    on<QuizFinishEvent>((event, emit) {});
  }

  void _loadQuiz(QuizEvent event, Emitter<QuizState> emit) async {
    Fimber.d("_loadQuiz()");

    final questions = await AssetsUtils.loadCsv(Assets.csvQuizzOiseaux);

    if (null == questions) {
      Fimber.e("Failed to load CSV file");
      emit(state.copyWithState(
          newState: QuizLoadingError(error: "Failed to load CSV file")));
      return;
    }

    // Build quizz list items
    List<Quizz> list = Quizz.toQuizzList(questions);

    emit(state.copyWithState(newState: QuizStarted(quizzes: list)));
  }

  void _startQuiz(QuizEvent event, Emitter<QuizState> emit) async {
    Fimber.d("_startQuiz()");
  }
}
