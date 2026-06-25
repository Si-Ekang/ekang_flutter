part of 'quiz_bloc.dart';

/// Base event class for all actions dispatched to the [QuizBloc].
abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

/// Dispatched to initialize and open the quiz category choosing screen.
class LoadQuizChooserEvent extends QuizEvent {}

/// Dispatched when the user selects a quiz category.
class NavigateToQuizEvent extends QuizEvent {
  /// The category name selected (e.g. "animals", "birds").
  final String quizCategoryChosen;

  const NavigateToQuizEvent({required this.quizCategoryChosen});

  @override
  List<Object?> get props => [quizCategoryChosen];
}

/// Dispatched to load questions from CSV assets for the selected category.
class LoadQuizEvent extends QuizEvent {}

/// Dispatched when the user taps on one of the possible answers.
class SelectChoiceEvent extends QuizEvent {
  /// The selected answer option text.
  final String choice;

  const SelectChoiceEvent({required this.choice});

  @override
  List<Object?> get props => [choice];
}

/// Dispatched to verify the chosen answer against the correct one.
class CheckAnswerEvent extends QuizEvent {
  /// The selected answer option text.
  final String choice;
  /// The correct answer text.
  final String correctAnswer;

  const CheckAnswerEvent({required this.choice, required this.correctAnswer});

  @override
  List<Object?> get props => [choice, correctAnswer];
}

/// Dispatched to reset validation states when navigating to a new question.
class ResetCheckAnswerEvent extends QuizEvent {}

/// Dispatched to proceed to the next question or complete the quiz if it's the last page.
class NextQuestionRequestedEvent extends QuizEvent {}

/// Dispatched to reset the active quiz session and return to category selection.
class ResetQuizEvent extends QuizEvent {}

/// Dispatched when the quiz ends and final results need to be computed.
class QuizFinishEvent extends QuizEvent {}
