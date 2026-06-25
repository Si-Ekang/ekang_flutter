import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ekang_flutter/core/utils/log.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class PossibleAnswersWidget extends StatefulWidget {
  final String chosenAnswer;
  final List<String> possibleAnswers;
  final Function(String) onAnswerChanged;

  const PossibleAnswersWidget({
    super.key,
    required this.chosenAnswer,
    required this.possibleAnswers,
    required this.onAnswerChanged,
  });

  @override
  State<PossibleAnswersWidget> createState() => _PossibleAnswersWidgetState();
}

class _PossibleAnswersWidgetState extends State<PossibleAnswersWidget> {
  @override
  void initState() {
    super.initState();

    Log.d('initState', 'init method', this.runtimeType.toString());
  }

  @override
  void didUpdateWidget(covariant PossibleAnswersWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    Log.d('didUpdateWidget', 'oldWidget : $oldWidget',
      this.runtimeType.toString(),);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        Log.d('builder', 'state: $state', runtimeType.toString(),);

        bool isAnswerChecked = state.checkStatus != QuizCheckStatus.initial;
        Log.d('build', 'isAnswerChecked: $isAnswerChecked', runtimeType.toString(),);

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 1.0,
          ),
          itemCount: widget.possibleAnswers.length,
          itemBuilder: (context, index) {
            Color selectedCardColor = SiEkangColors.quizItemSelectedTextColor;
            double cardBorderWidth =
            widget.chosenAnswer == widget.possibleAnswers[index]
                ? 2.0
                : 0.0;

            return SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: isAnswerChecked
                      ? null
                      : () {
                    widget.onAnswerChanged(widget.possibleAnswers[index]);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: selectedCardColor,
                        width: cardBorderWidth,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Center(
                      child: Text(
                        widget.possibleAnswers[index],
                        style: TextStyle(
                          color: (widget.chosenAnswer ==
                              widget.possibleAnswers[index])
                              ? selectedCardColor
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          shrinkWrap: true,
        );
      },
    );
  }
}
