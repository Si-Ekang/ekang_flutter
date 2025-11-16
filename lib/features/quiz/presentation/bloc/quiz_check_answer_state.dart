part of 'quiz_check_answer_bloc.dart';

/// This class has the different states that the bloc is going to be able to emit.
/// I’ve created an extension to handle all the possible states in the view in a short and cleaner way.
/// I use the Equatable library to compare objects in Dart, if you don’t know anything about this, I highly recommend you check the docs:
/// https://pub.dev/packages/equatable.
class QuizCheckAnswerState extends Equatable {
  const QuizCheckAnswerState();

  @override
  List<Object?> get props => [];

  QuizCheckAnswerState copyWithState({required QuizCheckAnswerState newState}) {
    return newState;
  }
}


final class QuizCheckAnswerInitialState extends QuizCheckAnswerState {
  @override
  List<Object?> get props => [];
}

final class QuizCheckAnswerErrorState extends QuizCheckAnswerState {
  final String errorMessage;

  const QuizCheckAnswerErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

final class QuizCheckAnswerSuccessState extends QuizCheckAnswerState {
  final String encouragementMessage;

  const QuizCheckAnswerSuccessState({required this.encouragementMessage});

  @override
  List<Object?> get props => [encouragementMessage];
}