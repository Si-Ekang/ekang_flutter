import 'dart:developer';

import 'package:audio_session/audio_session.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/quiz/data/models/quizz.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/bottom_validate_widget.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/possible_answers_widget.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/top_question_widget.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

int pageViewIndex = 1;

class QuizStartedWidget extends StatefulWidget {
  final List<Quizz> quizzes;

  const QuizStartedWidget({super.key, required this.quizzes});

  @override
  State<QuizStartedWidget> createState() => _QuizStartedWidgetState();
}

class _QuizStartedWidgetState extends State<QuizStartedWidget>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late AnimationController progressIndicatorController;
  final PageController controller = PageController();
  final animationDuration = const Duration(milliseconds: 500);

  String choice = '';

  bool canGoNext = true;

  AudioPlayer? _player;

  @override
  void initState() {
    super.initState();

    Fimber.d("initState()");

    progressIndicatorController = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });

    initAudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    Fimber.d("build() | data list length = : ${widget.quizzes.length}");

    return Scaffold(
        appBar: AppBar(
          backgroundColor: SiEkangColors.primaryDark,
          title: const Text('Quiz'),
          leading: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: const Icon(Icons.arrow_back)),
        ),
        body: LayoutBuilder(
            builder: (context, constraints) => Center(
                    child: Row(children: [
                  Container(
                      constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth >= 500
                              ? 500
                              : constraints.maxWidth),
                      child: Column(
                        children: [
                          // Top Progress Bar
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 32.0,
                              child: Center(
                                child: Container(
                                  margin: const EdgeInsets.all(8.0),
                                  // source : https://stackoverflow.com/questions/49553402/how-to-determine-screen-height-and-width
                                  child: LinearProgressIndicator(
                                    minHeight: 4.0,
                                    color:
                                        SiEkangColors.quizItemSelectedTextColor,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            SiEkangColors
                                                .quizItemSelectedTextColor),
                                    value:
                                        progressIndicatorController.value + 0.1,
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

                                    if (page == widget.quizzes.length - 1) {
                                      canGoNext = false;
                                    }
                                  },
                                  itemCount: widget.quizzes.length,
                                  itemBuilder: (context, position) {
                                    return Container(
                                      child: createPage(
                                          position, widget.quizzes[position]),
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                  // Disable scroll functionality
                                  physics:
                                      const NeverScrollableScrollPhysics()))
                        ],
                      ))
                ]))));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player?.stop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (kDebugMode) log("dispose()");

    // reset view pager index
    pageViewIndex = 1;
    canGoNext = true;

    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player?.dispose();
  }

  ///////////////////////////
  //
  // CLASS METHODS
  //
  ///////////////////////////
  Future<void> initAudioPlayer() async {
    if (kDebugMode) log("initAudioPlayer()");

    _player = AudioPlayer();

    try {
      // Inform the operating system of our app's audio attributes etc.
      // We pick a reasonable default for an app that plays speech.
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.speech());
      // Listen to errors during playback.
      _player?.playbackEventStream.listen((event) {
        if (kDebugMode) log("event : $event");
      }, onError: (Object e, StackTrace stackTrace) {
        if (kDebugMode) log('A stream error occurred: $e');
      });
    } catch (e) {
      log("Error loading audio source: $e");
    }
  }

  createPage(int page, Quizz quizzItem) {
    log("createPage() | page : $page, quizz : ${quizzItem.toString()}");
    return Card(
        margin: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: TopQuestionWidget(question: quizzItem.question),
            ),
            Expanded(
              flex: 10,
              child: PossibleAnswersWidget(
                chosenAnswer: choice,
                possibleAnswers: quizzItem.possibleAnswers,
                onAnswerChanged: (newAnswer) {
                  setState(() {
                    choice = newAnswer;
                  });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: BottomValidateWidget(
                correctAnswer: quizzItem.correctAnswer,
                onNavigateToNextPage: () {
                  Fimber.d(
                      "onNavigateToNextPage() | correct answer : ${quizzItem.correctAnswer}");
                  // update page index
                  pageViewIndex += 1;

                  // update progressbar
                  progressIndicatorController.value =
                      progressIndicatorController.value + 0.1;

                  canGoNext = pageViewIndex + 1 != widget.quizzes.length;
                },
                canGoNext: canGoNext,
              ),
            ),
          ],
        ));
  }

  void getCurrentPage(int page) {
    pageViewIndex = page;
  }

  void _navigateToPage(int index) {
    Fimber.d("_navigateToPage() | index : $index");
    controller.animateToPage(index,
        duration: animationDuration, curve: Curves.decelerate);
  }
}
