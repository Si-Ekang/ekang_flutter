import 'package:ekang_flutter/core/utils/constants.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/quiz/quiz.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SiEkangToolbar(title: Constants.appName),
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
                                  padding: WidgetStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.all(16)),
                                  backgroundColor: WidgetStateProperty.all(
                                      SiEkangColors.primary)),
                              onPressed: () {
                                // Navigate to second route when tapped.
                                Navigator.of(context)
                                    .pushNamed(QuizPage.routeName);

                                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuizPage()));
                              },
                              child: Text(
                                'Start a new Quizz',
                                style: TextStyle(
                                  color: SiEkangColors.md_theme_light_surface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )));
  }
}
