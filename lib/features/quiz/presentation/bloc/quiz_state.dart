part of 'quiz_bloc.dart';

/// This class has the different states that the bloc is going to be able to emit.
/// I’ve created an extension to handle all the possible states in the view in a short and cleaner way.
/// I use the Equatable library to compare objects in Dart, if you don’t know anything about this, I highly recommend you check the docs:
/// https://pub.dev/packages/equatable.
class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];

  QuizState copyWithState({required QuizState newState}) {
    return newState;
  }
}

final class QuizInitialState extends QuizState {}

final class QuizCategoryChooserState extends QuizState {}

final class QuizLoadingState extends QuizState {}

final class QuizLoadingErrorState extends QuizState {
  final String error;

  const QuizLoadingErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}

final class QuizStartedState extends QuizState {
  final List<Quizz> quizzes;

  const QuizStartedState({required this.quizzes});

  @override
  List<Object?> get props => [quizzes];
}

final class QuizEndedState extends QuizState {
  final double score;
  final double successPercentage;

  const QuizEndedState({required this.score, required this.successPercentage});

  @override
  List<Object?> get props => [score, successPercentage];
}
