part of 'quiz_bloc.dart';

/// Describes the overall progress status of the quiz experience.
enum QuizStatus {
  /// Initial state before setup.
  initial,
  /// Choosing the vocabulary category.
  categoryChooser,
  /// Loading questions from assets.
  loading,
  /// Active quiz session in progress.
  started,
  /// Final results display after ending the quiz.
  ended,
  /// Error occurred during quiz setup or loading.
  error
}

/// Describes the verification status of the currently selected answer.
enum QuizCheckStatus {
  /// No answer submitted yet for verification.
  initial,
  /// The submitted answer is correct.
  success,
  /// The submitted answer is incorrect.
  error
}

/// Represents the immutable state of the quiz flow.
class QuizState extends Equatable {
  /// The current state status of the quiz lifecycle.
  final QuizStatus status;
  /// The list of questions loaded for the quiz session.
  final List<Quizz> quizzes;
  /// The category selected by the user.
  final String quizCategoryChosen;
  /// The current active question index (0-based PageView index).
  final int currentQuizIndex;
  /// Total number of correct answers in the current session.
  final int totalCorrectAnswers;
  /// Current consecutive correct answers streak.
  final int totalCorrectAnswersInARow;
  /// The text choice selected by the user for the current question.
  final String quizChoice;
  /// The final score (number of correct answers).
  final double score;
  /// The success rate percentage computed on completion.
  final double successPercentage;
  /// The error message if [status] is [QuizStatus.error].
  final String errorMessage;
  /// The correct answer validation encouragement/error message.
  final String checkAnswerMessage;
  /// The current validation state of the chosen answer.
  final QuizCheckStatus checkStatus;

  const QuizState({
    this.status = QuizStatus.initial,
    this.quizzes = const [],
    this.quizCategoryChosen = '',
    this.currentQuizIndex = 1,
    this.totalCorrectAnswers = 0,
    this.totalCorrectAnswersInARow = 0,
    this.quizChoice = '',
    this.score = 0.0,
    this.successPercentage = 0.0,
    this.errorMessage = '',
    this.checkAnswerMessage = '',
    this.checkStatus = QuizCheckStatus.initial,
  });

  QuizState copyWith({
    QuizStatus? status,
    List<Quizz>? quizzes,
    String? quizCategoryChosen,
    int? currentQuizIndex,
    int? totalCorrectAnswers,
    int? totalCorrectAnswersInARow,
    String? quizChoice,
    double? score,
    double? successPercentage,
    String? errorMessage,
    String? checkAnswerMessage,
    QuizCheckStatus? checkStatus,
  }) {
    return QuizState(
      status: status ?? this.status,
      quizzes: quizzes ?? this.quizzes,
      quizCategoryChosen: quizCategoryChosen ?? this.quizCategoryChosen,
      currentQuizIndex: currentQuizIndex ?? this.currentQuizIndex,
      totalCorrectAnswers: totalCorrectAnswers ?? this.totalCorrectAnswers,
      totalCorrectAnswersInARow: totalCorrectAnswersInARow ?? this.totalCorrectAnswersInARow,
      quizChoice: quizChoice ?? this.quizChoice,
      score: score ?? this.score,
      successPercentage: successPercentage ?? this.successPercentage,
      errorMessage: errorMessage ?? this.errorMessage,
      checkAnswerMessage: checkAnswerMessage ?? this.checkAnswerMessage,
      checkStatus: checkStatus ?? this.checkStatus,
    );
  }

  @override
  List<Object?> get props => [
        status,
        quizzes,
        quizCategoryChosen,
        currentQuizIndex,
        totalCorrectAnswers,
        totalCorrectAnswersInARow,
        quizChoice,
        score,
        successPercentage,
        errorMessage,
        checkAnswerMessage,
        checkStatus,
      ];
}
