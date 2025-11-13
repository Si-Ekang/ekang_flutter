import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef OnCheckAnswerCallback = Function(bool newState);
typedef OnNavigateToNextPageCallback = Function();

class BottomValidateWidget extends StatefulWidget {
  final bool enabled;
  final String correctAnswer;

  // Navigate to next page and update progress bar
  final OnNavigateToNextPageCallback onNavigateToNextPage;
  final OnCheckAnswerCallback onCheckAnswer;

  const BottomValidateWidget({
    super.key,
    required this.enabled,
    required this.correctAnswer,
    required this.onNavigateToNextPage,
    required this.onCheckAnswer,
  });

  @override
  State<BottomValidateWidget> createState() => _BottomValidateWidgetState();
}

class _BottomValidateWidgetState extends State<BottomValidateWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCheckAnswerBloc, QuizCheckAnswerState>(
      listener: (BuildContext context, QuizCheckAnswerState state) {
        Fimber.i(
            "_BottomValidateWidgetState | BlocConsumer.listener | state : $state");

        // The switch statement evaluates the 'state' variable.
        switch (state) {
          // This is the first case pattern.
          case QuizCheckAnswerSuccessState _:
            // This code block runs ONLY IF the 'state' object is an instance of
            // the QuizCheckAnswerSuccessState class.

            // The underscore `_` is a wildcard pattern. It means "we know this is a
            // QuizCheckAnswerSuccessState, but we don't need to use the object itself
            // in a new variable, so we'll just ignore it."

            // Action 1: Access the QuizBloc from the widget tree.
            context
                .read<QuizBloc>()
                // Action 2: Call the incrementCorrectAnswers method on the bloc.
                .incrementCorrectAnswers();

            // Action 3: Access the QuizBloc again.
            context
                .read<QuizBloc>()
                // Action 4: Call the incrementCorrectAnswerInARow method.
                .incrementCorrectAnswerInARow();

            // The break statement exits the switch.
            break;

          case QuizCheckAnswerErrorState _ :
            context.read<QuizBloc>().resetCorrectAnswerInARow();
            break;
        }
      },
      builder: (BuildContext context, QuizCheckAnswerState state) {
        return Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 550),
              child: state is QuizCheckAnswerInitialState
                  //context.read<QuizBloc>().showAnswerCheckResult
                  ? SizedBox(width: 0, height: 0)
                  : Card(
                      child: Text(switch (state) {
                      QuizCheckAnswerSuccessState() =>
                        state.encouragementMessage,
                      QuizCheckAnswerErrorState() => state.errorMessage,
                      QuizCheckAnswerInitialState() => "",
                      QuizCheckAnswerState() => "",
                    })),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(switch (state) {
                    QuizCheckAnswerSuccessState() => SiEkangColors.green,
                    QuizCheckAnswerErrorState() => SiEkangColors.red,
                    QuizCheckAnswerState() =>
                      Theme.of(context).colorScheme.primaryContainer
                  }),
                  fixedSize: WidgetStateProperty.all<Size>(
                    const Size(72.0, 36.0),
                  ),
                ),
                onPressed: !widget.enabled
                    ? null
                    : () {
                        if (state is QuizCheckAnswerInitialState) {
                          widget.onCheckAnswer(true);

                          context.read<QuizCheckAnswerBloc>().add(
                                CheckAnswerEvent(
                                  choice: context.read<QuizBloc>().quizChoice,
                                  correctAnswer: widget.correctAnswer,
                                ),
                              );
                        } else {
                          widget.onCheckAnswer(false);

                          context
                              .read<QuizCheckAnswerBloc>()
                              .add(ResetCheckAnswerEvent());

                          // perform navigate to new page
                          // if (widget.canGoNext) {
                          // _navigateToPage(pageViewIndex);
                          widget.onNavigateToNextPage();

                          // update progressbar
                          // progressIndicatorController.value = progressIndicatorController.value + 0.1;
                          /*} else {
                           */ /* if (kDebugMode) log("end quizz reached last page");
                            Navigator.of(context).pop();*/ /*
                          }*/
                        }
                      },
                child: Text(
                  switch (state) {
                    QuizCheckAnswerSuccessState() => true ==
                            context.read<QuizBloc>().state is! QuizStartedState
                        ? "N/A"
                        : context.read<QuizBloc>().currentQuizIndex + 1 ==
                                (context.read<QuizBloc>().state as QuizStartedState)
                                    .quizzes
                                    .length
                            ? "Next"
                            : 'Finish',
                    QuizCheckAnswerErrorState() => true ==
                            context.read<QuizBloc>().state is! QuizStartedState
                        ? "N/A"
                        : context.read<QuizBloc>().currentQuizIndex + 1 ==
                                (context.read<QuizBloc>().state as QuizStartedState)
                                    .quizzes
                                    .length
                            ? "Next"
                            : 'Finish',
                    QuizCheckAnswerInitialState() => "Verify",
                    QuizCheckAnswerState() => "Verify",
                  },
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
