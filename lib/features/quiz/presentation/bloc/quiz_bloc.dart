import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekang_flutter/core/utils/assets_utils.dart';
import 'package:ekang_flutter/features/quiz/data/models/quizz.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';

part 'quiz_check_answer_state.dart';
part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  int totalCorrectAnswersInARow = 0;
  int totalCorrectAnswers = 0;
  int currentQuizIndex = 1;
  int totalQuestions = 0;
  String quizChoice = "".trim();

  // bool isFirstQuestion = this.currentQuizIndex  == this.totalQuestions - 1 ;

  QuizBloc() : super(QuizInitial()) {
    on<QuizEvent>((event, emit) {});
    on<LoadQuizEvent>(_loadQuiz);
    on<QuizStartedEvent>(_startQuiz);
    on<QuizFinishEvent>(_quizEnded);
  }

  void _loadQuiz(LoadQuizEvent event, Emitter<QuizState> emit) async {
    Fimber.d("_loadQuiz()");

    List<String> csvQuizList = List.of([Assets.csvQuizBibouma, Assets.csvQuizz, Assets.csvQuizzOiseaux]);

    final questions = await AssetsUtils.loadCsv(csvQuizList[Random().nextInt(csvQuizList.length -1)]);

    if (null == questions) {
      Fimber.e("Failed to load CSV file");
      emit(state.copyWithState(
          newState: QuizLoadingError(error: "Failed to load CSV file")));
      return;
    }

    // Build quizz list items
    List<Quizz> list = Quizz.toQuizzList(questions);

    updateTotalQuestions(list.length);

    emit(state.copyWithState(newState: QuizStarted(quizzes: list)));
  }

  void _startQuiz(QuizStartedEvent event, Emitter<QuizState> emit) async {
    Fimber.d("_startQuiz()");
  }

  void _quizEnded(QuizFinishEvent event, Emitter<QuizState> emit) async {
    Fimber.d("_quizEnded()");
    emit(state.copyWithState(
        newState: QuizEnded(
      score: totalCorrectAnswers.toDouble(),
      successPercentage: getSuccessPercentage(),
    )));
  }

  void incrementQuizIndex() {
    currentQuizIndex++;
  }

  void incrementCorrectAnswers() {
    totalCorrectAnswers++;
    Fimber.d(
        "incrementCorrectAnswers() | total correct answers count : $totalCorrectAnswers");
  }

  void incrementCorrectAnswerInARow() {
    totalCorrectAnswersInARow++;
    Fimber.d(
        "incrementCorrectAnswerInARow() | total correct answers in a row count : $totalCorrectAnswersInARow");
  }

  void resetCorrectAnswerInARow() {
    Fimber.w("resetCorrectAnswerInARow()");
    totalCorrectAnswersInARow = 0;
  }

  void updateQuizIndex(int newIndex) {
    currentQuizIndex = newIndex;
  }

  void updateTotalQuestions(int count){
    this.totalQuestions = count;
  }

  void resetChoice() {
    quizChoice = "".trim();
  }

  void setQuizChoice(String newValue) {
    quizChoice = newValue.trim();
  }

  void resetBlocData() {
    resetChoice();
    resetCurrentQuizIndex();
  }

  void resetCurrentQuizIndex() {
    // reset view pager index
    currentQuizIndex = 1;
  }

  double getSuccessPercentage() {
    if (0 == totalQuestions) {
      Fimber.e("getSuccessPercentage() | total questions equals to 0");
      return 0.0;
    }

    return (totalCorrectAnswers * 100) / totalQuestions;
  }
}

class QuizCheckAnswerBloc extends Bloc<QuizEvent, QuizCheckAnswerState> {
  QuizCheckAnswerBloc() : super(QuizCheckAnswerInitialState()) {
    on<QuizEvent>((event, emit) {});
    on<CheckAnswerEvent>(_checkAnswer);
    on<ResetCheckAnswerEvent>(_resetState);
  }

  void _resetState(
      ResetCheckAnswerEvent event, Emitter<QuizCheckAnswerState> emit) {
    emit(state.copyWithState(newState: QuizCheckAnswerInitialState()));
  }

  void _checkAnswer(
      CheckAnswerEvent event, Emitter<QuizCheckAnswerState> emit) async {
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
}
