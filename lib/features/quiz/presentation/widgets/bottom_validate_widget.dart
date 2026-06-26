import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomValidateWidget extends StatelessWidget {
  final String correctAnswer;

  const BottomValidateWidget({
    super.key,
    required this.correctAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        final hasSelected = state.quizChoice.trim().isNotEmpty;
        final isChecking = state.checkStatus == QuizCheckStatus.initial;

        Color buttonColor = Theme.of(context).colorScheme.primaryContainer;
        if (state.checkStatus == QuizCheckStatus.success) {
          buttonColor = SiEkangColors.green;
        } else if (state.checkStatus == QuizCheckStatus.error) {
          buttonColor = SiEkangColors.red;
        }

        String buttonText = "Verify";
        if (!isChecking) {
          final isLastPage = state.currentQuizIndex + 1 == state.quizzes.length;
          buttonText = isLastPage ? "Finish" : "Next";
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Status Feedback Card
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: isChecking
                  ? const SizedBox(width: 0, height: 0)
                  : Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      color: state.checkStatus == QuizCheckStatus.success
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          state.checkAnswerMessage,
                          style: TextStyle(
                            color: state.checkStatus == QuizCheckStatus.success
                                ? Colors.green.shade900
                                : Colors.red.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
            
            // Action Button
            SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(buttonColor),
                  fixedSize: WidgetStateProperty.all<Size>(
                    const Size(72.0, 36.0),
                  ),
                ),
                onPressed: !hasSelected
                    ? null
                    : () {
                        if (isChecking) {
                          context.read<QuizBloc>().add(
                                CheckAnswerEvent(
                                  choice: state.quizChoice,
                                  correctAnswer: correctAnswer,
                                ),
                              );
                        } else {
                          context.read<QuizBloc>().add(NextQuestionRequestedEvent());
                        }
                      },
                child: Text(
                  buttonText,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isChecking ? Colors.black87 : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
