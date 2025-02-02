import 'dart:developer';

import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:flutter/foundation.dart';

class BottomValidateWidget extends StatefulWidget {
  final String correctAnswer;
  final bool canGoNext;

  // Navigate to next page and update progress bar
  final Function() onNavigateToNextPage;

  const BottomValidateWidget(
      {super.key,
      required this.correctAnswer,
      required this.onNavigateToNextPage,
      required this.canGoNext});

  @override
  State<BottomValidateWidget> createState() => _BottomValidateWidgetState();
}

class _BottomValidateWidgetState extends State<BottomValidateWidget> {
  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(const Size(72.0, 36.0))),
      onPressed: () {
        // update page index
        // getCurrentPage(currentPageIndex);

        // perform navigate to new page
        if (widget.canGoNext) {
          // _navigateToPage(pageViewIndex);
          widget.onNavigateToNextPage();

          // update progressbar
          // progressIndicatorController.value = progressIndicatorController.value + 0.1;
        } else {
          if (kDebugMode) log("end quizz reached last page");
          Navigator.of(context).pop();
        }
      },
      child: Text(widget.canGoNext ? "Next" : 'Finish'));
}
