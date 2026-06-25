import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekang_flutter/core/utils/assets_utils.dart';
import 'package:ekang_flutter/core/utils/log.dart';
import 'package:ekang_flutter/features/quiz/data/models/quizz.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../data/models/quiz_category.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

/// BLoC class responsible for managing the state transitions and core business logic
/// of the Quiz feature.
class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(const QuizState()) {
    on<LoadQuizChooserEvent>(_loadQuizChooser);
    on<NavigateToQuizEvent>(_navigateToQuiz);
    on<LoadQuizEvent>(_loadQuiz);
    on<SelectChoiceEvent>(_selectChoice);
    on<CheckAnswerEvent>(_checkAnswer);
    on<ResetCheckAnswerEvent>(_resetCheckAnswer);
    on<NextQuestionRequestedEvent>(_nextQuestion);
    on<ResetQuizEvent>(_resetQuiz);
    on<QuizFinishEvent>(_quizEnded);
  }

  void _loadQuizChooser(
    LoadQuizChooserEvent event,
    Emitter<QuizState> emit,
  ) {
    Fimber.d("_loadQuizChooser()");
    emit(state.copyWith(status: QuizStatus.categoryChooser));
  }

  void _navigateToQuiz(
    NavigateToQuizEvent event,
    Emitter<QuizState> emit,
  ) {
    Fimber.d("_navigateToQuiz()");
    emit(state.copyWith(quizCategoryChosen: event.quizCategoryChosen));
  }

  void _loadQuiz(LoadQuizEvent event, Emitter<QuizState> emit) async {
    Fimber.d("_loadQuiz()");
    emit(state.copyWith(status: QuizStatus.loading));

    // Load csv based on quiz category chosen
    List<String>? csvQuizList = getQuizCategories(
      state.quizCategoryChosen.toQuizCategory(),
    );

    if (null == csvQuizList) {
      Fimber.e("Failed to load CSV file");
      emit(
        state.copyWith(
          status: QuizStatus.error,
          errorMessage: "Failed to load CSV file",
        ),
      );
      return;
    }

    Fimber.d("_loadQuiz() | csvQuizList : $csvQuizList");

    final csvQuiz = 1 == csvQuizList.length
        ? csvQuizList.first
        : csvQuizList[Random().nextInt(csvQuizList.length)];
    final questions = await AssetsUtils.loadCsv(csvQuiz);

    if (null == questions) {
      Fimber.e("Failed to load CSV file");
      emit(
        state.copyWith(
          status: QuizStatus.error,
          errorMessage: "Failed to load CSV file",
        ),
      );
      return;
    }

    // Build quizz list items
    List<Quizz> list = Quizz.toQuizzList(questions);

    emit(state.copyWith(
      status: QuizStatus.started,
      quizzes: list,
      currentQuizIndex: 0,
      totalCorrectAnswers: 0,
      totalCorrectAnswersInARow: 0,
      quizChoice: '',
      checkStatus: QuizCheckStatus.initial,
      checkAnswerMessage: '',
    ));
  }

  void _selectChoice(SelectChoiceEvent event, Emitter<QuizState> emit) {
    emit(state.copyWith(quizChoice: event.choice));
  }

  void _checkAnswer(CheckAnswerEvent event, Emitter<QuizState> emit) {
    Fimber.d(
        "_checkAnswer() | choice : ${event.choice}, correctAnswer : ${event.correctAnswer}");
    final isCorrect = event.choice == event.correctAnswer;
    final newCorrectAnswers = isCorrect ? state.totalCorrectAnswers + 1 : state.totalCorrectAnswers;
    final newStreak = isCorrect ? state.totalCorrectAnswersInARow + 1 : 0;

    emit(state.copyWith(
      checkStatus: isCorrect ? QuizCheckStatus.success : QuizCheckStatus.error,
      checkAnswerMessage: isCorrect
          ? "Great! Continue like this!"
          : "Wrong Answer!. The correct answer is ${event.correctAnswer}",
      totalCorrectAnswers: newCorrectAnswers,
      totalCorrectAnswersInARow: newStreak,
    ));
  }

  void _resetCheckAnswer(ResetCheckAnswerEvent event, Emitter<QuizState> emit) {
    emit(state.copyWith(
      checkStatus: QuizCheckStatus.initial,
      checkAnswerMessage: '',
    ));
  }

  void _nextQuestion(NextQuestionRequestedEvent event, Emitter<QuizState> emit) {
    final isLastPage = state.currentQuizIndex + 1 == state.quizzes.length;
    if (isLastPage) {
      add(QuizFinishEvent());
    } else {
      emit(state.copyWith(
        currentQuizIndex: state.currentQuizIndex + 1,
        quizChoice: '',
        checkStatus: QuizCheckStatus.initial,
        checkAnswerMessage: '',
      ));
    }
  }

  void _resetQuiz(ResetQuizEvent event, Emitter<QuizState> emit) {
    emit(const QuizState(status: QuizStatus.categoryChooser));
  }

  void _quizEnded(QuizFinishEvent event, Emitter<QuizState> emit) {
    Fimber.d("_quizEnded()");
    final double successPercentage = state.quizzes.isEmpty
        ? 0.0
        : (state.totalCorrectAnswers * 100) / state.quizzes.length;

    emit(state.copyWith(
      status: QuizStatus.ended,
      score: state.totalCorrectAnswers.toDouble(),
      successPercentage: successPercentage,
    ));
  }

  static List<String>? getQuizCategories(QuizCategory category) {
    Fimber.d("getQuizCategories() | category : $category");
    switch (category) {
      case QuizCategory.animals:
        return List.of([Assets.csvQuizzAnimaux1]);
      case QuizCategory.birds:
        return List.of([Assets.csvQuizzOiseaux, Assets.csvQuizzBirds1]);
      case QuizCategory.clothes:
        return null;
      case QuizCategory.home:
        return List.of([Assets.csvQuizzHome, Assets.csvQuizzKitchen]);
      case QuizCategory.food:
        return List.of([Assets.csvQuizVegetables]);
      default:
        return null;
    }
  }

  Future<String?> getQuizImageAsDownloadURL(String imageName) async {
    if (imageName.isEmpty) {
      Log.e("getQuizImageAsDownloadURL", "url is empty");
      return null;
    }

    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

    // Create a reference with an initial file path and name
    return storageRef.child("images/$imageName").getDownloadURL();
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

      return data;
    } on FirebaseException catch (exception, stacktrace) {
      Log.e(
        "getQuizImage",
        "exception: $exception (stacktrace: ${stacktrace.toString()})",
        runtimeType.toString(),
      );
      return null;
    }
  }
}
