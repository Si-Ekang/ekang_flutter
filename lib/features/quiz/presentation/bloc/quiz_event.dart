part of 'quiz_bloc.dart';

class QuizEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadQuizEvent extends QuizEvent {
  @override
  List<Object?> get props => [];
}

class QuizStartedEvent extends QuizEvent {
  final List<Quizz> quizzes;
  final int currentQuizIndex;
  final int totalQuestions;
  final bool isLastQuestion;
  final bool isFirstQuestion;

  QuizStartedEvent(this.quizzes, this.currentQuizIndex, this.totalQuestions,
      {this.isLastQuestion = false, this.isFirstQuestion = false});

  @override
  List<Object?> get props => [
        quizzes,
        currentQuizIndex,
        totalQuestions,
        isLastQuestion,
        isFirstQuestion
      ];
}

class QuizFinishEvent extends QuizEvent {
  final Double score;
  final Int successPercentage;

  QuizFinishEvent(this.score, this.successPercentage);

  @override
  List<Object?> get props => [score, successPercentage];
}
