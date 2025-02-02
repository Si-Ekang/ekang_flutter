import 'package:ekang_flutter/core/theme/siekangcolors.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';


typedef OnAnswerChangedCallback = Function(String newChosenAnswer);

class PossibleAnswersWidget extends StatelessWidget {
  final String chosenAnswer;
  final OnAnswerChangedCallback onAnswerChanged;
  final List<String> possibleAnswers;

  const PossibleAnswersWidget(
      {super.key,
      required this.chosenAnswer,
      required this.possibleAnswers,
      required this.onAnswerChanged});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
      ),
      itemCount: possibleAnswers.length,
      itemBuilder: (context, index) => Center(
          child: ChoiceChip(
        label: Text(
          possibleAnswers[index],
          style: TextStyle(
              color: (chosenAnswer == possibleAnswers[index])
                  ? Colors.white
                  : Colors.black),
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 64),
        selected: chosenAnswer == possibleAnswers[index],
        onSelected: (bool selected) {
          // setState(() { chosenAnswer = possibleAnswers[index]; });
          onAnswerChanged(possibleAnswers[index]);
        },
        selectedColor: SiEkangColors.quizItemSelectedTextColor,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      )),
    );
  }
}
