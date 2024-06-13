import 'package:ekang_flutter/core/theme/siekangcolors.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/quiz_widget.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
            builder: (context, constraints) => Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth >= 500
                            ? 500
                            : constraints.maxWidth),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Content of row
                        // Load a Lottie file from your assets
                        Lottie.asset(
                          Assets.lottieLottieQuiz,
                          width: 250,
                          height: 250,
                          fit: BoxFit.contain,
                        ),

                        ElevatedButton(
                          style: ButtonStyle(
                              padding:
                              MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(16)),
                              backgroundColor: MaterialStateProperty.all(
                                  SiEkangColors.primary)),
                          onPressed: () {
                            // Navigate to second route when tapped.
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const QuizWidget()));
                          },
                          child: const Text('Start a new Quizz'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
