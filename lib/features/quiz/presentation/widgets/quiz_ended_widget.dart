import 'dart:developer';

import 'package:adaptive_theme/adaptive_theme.dart' as theme;
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const quizEndedKey = GlobalObjectKey<_QuizEndedWidgetState>(5);

class QuizEndedWidget extends StatefulWidget {
  final double score;
  final double successPercentage;
  final Function(bool) onFinishCallback;

  const QuizEndedWidget({
    super.key,
    required this.onFinishCallback,
    required this.score,
    required this.successPercentage,
  });

  @override
  State<QuizEndedWidget> createState() => _QuizEndedWidgetState();
}

class _QuizEndedWidgetState extends State<QuizEndedWidget> {
  @override
  void initState() {
    super.initState();

    log("initState() | score : ${widget.score}");
    log("initState() | success percentage : ${widget.successPercentage}");
  }

  @override
  void didUpdateWidget(covariant QuizEndedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    Fimber.i("didUpdateWidget()");

    log("initState() | score : ${widget.score.toInt()} / ${context.read<QuizBloc>().totalQuestions}");
    log("initState() | success percentage : ${widget.successPercentage.toInt()} %");
  }

  @override
  Widget build(BuildContext context) {
    const String toolbarTitle = "Résultats Quiz";

    return SafeArea(
      child: Scaffold(
        appBar: SiEkangToolbar.withKey(
          key: quizEndedKey,
          title: toolbarTitle,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Quiz terminé !",
                style: theme.AdaptiveTheme.of(context)
                    .theme
                    .textTheme
                    .displaySmall,
              ),

              SizedBox(
                height: 16.0,
              ),

              // Can display a Lottie animation

              SizedBox(
                height: 16.0,
              ),
              // Display user statistics
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8.0,
                children: [
                  _buildStatisticSegment(
                    context: context,
                    segmentTitle: "Correct answers",
                    value:
                        "${widget.score.toInt()} / ${context.read<QuizBloc>().totalQuestions}",
                  ),
                  _buildStatisticSegment(
                    context: context,
                    segmentTitle: "Success percentage",
                    value: "${widget.successPercentage.toInt()} %",
                  ),
                  _buildStatisticSegment(
                      context: context,
                      segmentTitle: "Time elapsed",
                      value: "2:30"),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),

              // Close the screen
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Finish"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticSegment({
    required BuildContext context,
    required String segmentTitle,
    required Object value,
  }) {
    final Size mediaSize = MediaQuery.of(context).size;
    String finalSegmentTitle = segmentTitle;

    if (segmentTitle.split(" ").isNotEmpty) {
      var tempStringBuilder = "";
      segmentTitle.split(" ").forEach((element) {
        tempStringBuilder += "$element\n";
      });
      finalSegmentTitle = tempStringBuilder;
    }

    return SizedBox(
      width: mediaSize.width / 3.5,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                finalSegmentTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Text("$value")
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Fimber.e("dispose()");
  }
}
