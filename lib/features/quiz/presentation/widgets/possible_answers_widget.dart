import 'package:ekang_flutter/core/utils/log.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_check_answer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef OnAnswerChangedCallback = Function(String newChosenAnswer);

class PossibleAnswersWidget extends StatefulWidget {
  final bool quizHasImage;
  final String chosenAnswer;
  final OnAnswerChangedCallback onAnswerChanged;
  final List<String> possibleAnswers;

  const PossibleAnswersWidget({
    super.key,
    required this.quizHasImage,
    required this.chosenAnswer,
    required this.possibleAnswers,
    required this.onAnswerChanged,
  });

  @override
  State<PossibleAnswersWidget> createState() => _PossibleAnswersState();
}

class _PossibleAnswersState extends State<PossibleAnswersWidget> {
  @override
  void initState() {
    super.initState();

    Log.d('initState', 'init method', this.runtimeType.toString());
  }

  @override
  void didUpdateWidget(covariant PossibleAnswersWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    Log.d(
      'didUpdateWidget',
      'oldWidget : $oldWidget',
      this.runtimeType.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCheckAnswerBloc, QuizCheckAnswerState>(
        listener: (context, state) {
      Log.d(
        'listener',
        'state: $state',
        runtimeType.toString(),
      );
    }, builder: (context, state) {
      Log.d(
        'builder',
        'state: $state',
        runtimeType.toString(),
      );

      bool isAnswerChecked = context.read<QuizCheckAnswerBloc>().state
          is! QuizCheckAnswerInitialState;
      Log.d(
        'build',
        'isAnswerChecked: $isAnswerChecked',
        runtimeType.toString(),
      );

      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: widget.quizHasImage
            ? const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 8.0,
                mainAxisExtent: 96.0,
              )
            : const SliverGridDelegateWithFixedCrossAxisCount(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
        itemCount: widget.possibleAnswers.length,
        itemBuilder: (context, index) {
          Color selectedCardColor = SiEkangColors.quizItemSelectedTextColor;
          double cardBorderWidth =
              widget.chosenAnswer == widget.possibleAnswers[index] ? 2.0 : 0.0;

          return _buildAnswerCardContent(
            cardBorderWidth,
            selectedCardColor,
            isAnswerChecked,
            index,
          );
        },
      );
    });
  }

  Widget _buildAnswerCardContent(
    double cardBorderWidth,
    Color selectedCardColor,
    bool isAnswerChecked,
    int index,
  ) {
    Log.d("_buildAnswerCardContent", "has image: ${widget.quizHasImage}");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: isAnswerChecked
            ? null
            : () => widget.onAnswerChanged(widget.possibleAnswers[index]),
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
                color: (widget.chosenAnswer == widget.possibleAnswers[index])
                    ? selectedCardColor
                    : Colors.black,
              ),
              softWrap: true,
            ),
          ),
        ),
      ),
    );
  }
}