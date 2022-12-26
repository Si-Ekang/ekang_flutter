import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:ekang_flutter/core/theme/siekangcolors.dart';
import 'package:ekang_flutter/data/local/model/quizz.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

int pageViewIndex = 1;

class QuizWidget extends StatefulWidget {
  const QuizWidget({super.key});

  @override
  State<QuizWidget> createState() => _QuizState();
}

class _QuizState extends State<QuizWidget> with TickerProviderStateMixin {
  late AnimationController progressIndicatorController;
  final PageController controller = PageController();
  final animationDuration = const Duration(milliseconds: 500);

  List<Quizz> _quizzList = [];

  String choice = '';

  bool canGoNext = true;

  @override
  void initState() {
    super.initState();

    if (kDebugMode) log("initState()");

    progressIndicatorController = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });

    loadCsvFromAssets();
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) log("build()");
    if (kDebugMode) log("data list length = : ${_quizzList.length}");

    return Scaffold(
        appBar: AppBar(
          backgroundColor: SiEkangColors.primaryDark,
          title: const Text('Quiz'),
          leading: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Column(
          children: [
            // Top Progress Bar
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 32.0,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    // source : https://stackoverflow.com/questions/49553402/how-to-determine-screen-height-and-width
                    child: LinearProgressIndicator(
                      minHeight: 4.0,
                      color: SiEkangColors.quizItemSelectedTextColor,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          SiEkangColors.quizItemSelectedTextColor),
                      value: progressIndicatorController.value + 0.1,
                      semanticsLabel: 'Linear progress indicator',
                    ),
                  ),
                )),

            // PageView quizz
            Expanded(
                child: PageView.builder(
                    controller: controller,
                    onPageChanged: (page) {
                      getCurrentPage(page);

                      if (page == _quizzList.length - 1) {
                        canGoNext = false;
                      }
                    },
                    itemCount: _quizzList.length,
                    itemBuilder: (context, position) {
                      return Container(
                        child: createPage(position, _quizzList[position]),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    // Disable scroll functionality
                    physics: const NeverScrollableScrollPhysics()))
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
    if (kDebugMode) log("dispose()");

    // reset view pager index
    pageViewIndex = 1;
    canGoNext = true;
  }

  ///////////////////////////
  //
  // CLASS METHODS
  //
  ///////////////////////////
  void loadCsvFromAssets() async {
    if (kDebugMode) log("loadCsvFromAssets()");

    final input = await rootBundle.loadString(Assets.csvQuizzOiseaux);
    final fields = const CsvToListConverter(fieldDelimiter: ';').convert(input);

    if (null != fields) {
      if (kDebugMode) log("fields : $fields");
    }

    // Build quizz list items
    List<Quizz> list = Quizz.toQuizzList(fields);

    setState(() {
      _quizzList = list;
    });
  }

  topQuestionWidget(String question) {
    return Text(
      "$question ?",
      style: Theme.of(context).textTheme.headline5,
    );
  }

  possibleAnswersWidget(List<String> possibleAnswers) {
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
              color: (choice == possibleAnswers[index])
                  ? Colors.white
                  : Colors.black),
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 64),
        selected: choice == possibleAnswers[index],
        onSelected: (bool selected) {
          setState(() {
            choice = possibleAnswers[index];
          });
        },
        selectedColor: SiEkangColors.quizItemSelectedTextColor,
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(16.0)),
      )),
    );
  }

  bottomValidateWidget(String correctAnswer, int currentPageIndex) {
    return ElevatedButton(
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(const Size(72.0, 36.0))),
        onPressed: () {
          // update page index
          getCurrentPage(currentPageIndex);

          // perform navigate to new page
          if (canGoNext) {
            _navigateToPage(pageViewIndex);

            // update progressbar
            progressIndicatorController.value =
                progressIndicatorController.value + 0.1;
          } else {
            if (kDebugMode) log("end quizz reached last page");
            Navigator.of(context).pop();
          }
        },
        child: Text(canGoNext ? "Next" : 'Finish'));
  }

  createPage(int page, Quizz quizzItem) {
    log("createPage() | page : $page, quizz : ${quizzItem.toString()}");
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: topQuestionWidget(quizzItem.question),
              flex: 1,
            ),
            Expanded(
              child: possibleAnswersWidget(quizzItem.possibleAnswers),
              flex: 10,
            ),
            Expanded(
              child: bottomValidateWidget(
                  quizzItem.correctAnswer, pageViewIndex + 1),
              flex: 1,
            ),
          ],
        ));
  }

  void getCurrentPage(int page) {
    pageViewIndex = page;
  }

  void _navigateToPage(int index) {
    log("_navigateToPage() | index : $index");
    controller.animateToPage(index,
        duration: animationDuration, curve: Curves.decelerate);
  }
}
