import 'dart:math';
import 'dart:typed_data';

import 'package:ekang_flutter/core/utils/log.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekang_flutter/core/utils/assets_utils.dart';
import 'package:ekang_flutter/features/quiz/data/models/quizz.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';

import '../../data/models/quiz_category.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  String quizCategoryChosen = "".trim();

  int totalCorrectAnswersInARow = 0;
  int totalCorrectAnswers = 0;
  int currentQuizIndex = 1;
  int totalQuestions = 0;
  String quizChoice = "".trim();

  // bool isFirstQuestion = this.currentQuizIndex  == this.totalQuestions - 1 ;

  QuizBloc() : super(QuizInitialState()) {
    on<QuizEvent>((event, emit) {});
    on<LoadQuizChooserEvent>(_loadQuizChooser);
    on<NavigateToQuizEvent>(_navigateToQuiz);
    on<LoadQuizEvent>(_loadQuiz);
    on<QuizStartedEvent>(_startQuiz);
    on<QuizFinishEvent>(_quizEnded);
  }

  void _loadQuizChooser(
    LoadQuizChooserEvent event,
    Emitter<QuizState> emit,
  ) async {
    Fimber.d("_loadQuizChooser()");

    emit(state.copyWithState(newState: QuizCategoryChooserState()));
  }

  void _navigateToQuiz(
    NavigateToQuizEvent event,
    Emitter<QuizState> emit,
  ) async {
    Fimber.d("_navigateToQuiz()");
    quizCategoryChosen = event.quizCategoryChosen;
  }

  void _loadQuiz(LoadQuizEvent event, Emitter<QuizState> emit) async {
    Fimber.d("_loadQuiz()");

    // Load csv based on quiz category chosen
    List<String>? csvQuizList = getQuizCategories(
      quizCategoryChosen.toQuizCategory(),
    );

    if (null == csvQuizList) {
      Fimber.e("Failed to load CSV file");
      emit(
        state.copyWithState(
            newState: QuizLoadingErrorState(error: "Failed to load CSV file")),
      );
      return;
    }

    Fimber.d("_loadQuiz() | csvQuizList : $csvQuizList");

    // List<String> csvQuizList = List.of([Assets.csvQuizzAnimaux1, Assets.csvQuizzOiseaux]);

    final csvQuiz = 1 == csvQuizList.length
        ? csvQuizList.first
        : csvQuizList[Random().nextInt(csvQuizList.length - 1)];
    final questions = await AssetsUtils.loadCsv(csvQuiz);

    if (null == questions) {
      Fimber.e("Failed to load CSV file");
      emit(
        state.copyWithState(
            newState: QuizLoadingErrorState(error: "Failed to load CSV file")),
      );
      return;
    }

    // Build quizz list items
    List<Quizz> list = Quizz.toQuizzList(questions);

    updateTotalQuestions(list.length);

    emit(state.copyWithState(newState: QuizStartedState(quizzes: list)));
  }

  void _startQuiz(QuizStartedEvent event, Emitter<QuizState> emit) async {
    Fimber.d("_startQuiz()");
  }

  void _quizEnded(QuizFinishEvent event, Emitter<QuizState> emit) async {
    Fimber.d("_quizEnded()");
    emit(state.copyWithState(
      newState: QuizEndedState(
        score: totalCorrectAnswers.toDouble(),
        successPercentage: getSuccessPercentage(),
      ),
    ));
  }

  static List<String>? getQuizCategories(QuizCategory category) {
    Fimber.d("getQuizCategories() | category : $category");
    switch (category) {
      case QuizCategory.animals:
        return List.of([Assets.csvQuizzAnimaux1]);
      case QuizCategory.birds:
        return List.of([Assets.csvQuizzOiseaux]);
      case QuizCategory.clothes:
        return null;
      case QuizCategory.home:
        return null;
      default:
        return null;
    }
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

  bool canGoNext() {
    if(state is! QuizStartedState){
      return false;
    }
    Log.d("canGoNext","currentQuizIndex : $currentQuizIndex, quiz length : ${(state as QuizStartedState).quizzes.length}");

    return currentQuizIndex + 1 < (state as QuizStartedState).quizzes.length;
  }


  void updateQuizIndex(int newIndex) {
    currentQuizIndex = newIndex;
  }

  void updateTotalQuestions(int count) {
    totalQuestions = count;
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


  Future<Uint8List?> getQuizImage(String imageName) async {
    if (imageName.isEmpty) {
      Log.e("getQuizImage", "url is empty");
      return null;
    }

    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

    // Create a reference with an initial file path and name
    final pathReference = storageRef.child("images/$imageName");

    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await pathReference.getData(5 * oneMegabyte);

      if (null == data) {
        Log.d(
          "getQuizImage",
          "Error while loading image.",
          runtimeType.toString(),
        );
        return null;
      }

      // Data for "images/island.jpg" is returned, use this as needed.
      return data;

      // emit(state.copyWithState(newState: NotificationsLoadingImageSuccess(imageData: imageData)));
    } on FirebaseException catch (exception, stacktrace) {
      // Handle any errors.
      Log.e(
        "getQuizImage",
        "exception: $exception (stacktrace: ${stacktrace.toString()})",
        runtimeType.toString(),
      );
      return null;
    }
  }
}
