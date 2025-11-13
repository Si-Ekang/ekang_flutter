import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/quiz/data/models/quiz_category.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const quizChooserKey = GlobalObjectKey<_QuizCategoryChooserState>(3);

class QuizCategoryChooserWidget extends StatefulWidget {
  const QuizCategoryChooserWidget({super.key});

  @override
  State<QuizCategoryChooserWidget> createState() => _QuizCategoryChooserState();
}

class _QuizCategoryChooserState extends State<QuizCategoryChooserWidget> {
  int selectedIndex = -1;

  List<QuizCategory> choices = [
    QuizCategory.animals,
    QuizCategory.birds,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizBloc, QuizState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: SiEkangToolbar.withKey(
            key: quizChooserKey,
            title: "New Quiz",
            leadingIcon: Padding(
              padding: EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.chevron_left,
                  size: 36,
                  color: SiEkangColors.white,
                ),
              ),
            ),
            actions: null,
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox.expand(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // GridView
                    _buildChoiceGrid(context),

                    // Button
                    _buildChoiceButton(context),
                  ]),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChoiceGrid(BuildContext context) => Expanded(
      flex: 1,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
        ),
        itemCount: choices.length,
        itemBuilder: (context, index) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: ChoiceChip(
                    avatar: null,
                    label: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: Center(
                        child: Text(
                          choices[index].name,
                          style: TextStyle(
                              color: (index == selectedIndex)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                    selected: index == selectedIndex,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    selectedColor: SiEkangColors.quizItemSelectedTextColor,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                )),
          ],
        ),
      ));

  Widget _buildChoiceButton(BuildContext context) => SizedBox(
        width: double.infinity,
        height: 48.0,
        child: MaterialButton(
          onPressed: -1 == selectedIndex
              ? null
              : () async {
                  context.read<QuizBloc>().add(
                        NavigateToQuizEvent(
                          quizCategoryChosen: choices[selectedIndex].name,
                        ),
                      );
                  Future.delayed(Duration(milliseconds: 330));
                  context.read<QuizBloc>().add(LoadQuizEvent());
                },
          child: Text("Continue"),
        ),
      );
}
