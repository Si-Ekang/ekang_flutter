import 'package:ekang_flutter/core/theme/theme.dart';
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
              // Generate 100 widgets that display their index in the List.
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
            ),
            itemCount: choices.length,
            itemBuilder: (context, index) {
              Color cardColor = AdaptiveTheme.of(context).theme.primaryColor;
              Color selectedCardColor = SiEkangColors.quizItemSelectedTextColor;
              double cardBorderWidth = index == selectedIndex ? 2.0 : 0.0;

              return SizedBox.expand(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
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
                        choices[index].name,
                        style: TextStyle(
                          color: (index == selectedIndex)
                              ? selectedCardColor
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      );

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
