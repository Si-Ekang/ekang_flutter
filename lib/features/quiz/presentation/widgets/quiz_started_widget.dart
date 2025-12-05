import 'dart:developer';

import 'package:audio_session/audio_session.dart';
import 'package:ekang_flutter/core/utils/log.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/quiz/data/models/quizz.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_check_answer_bloc.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/bottom_validate_widget.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/possible_answers_widget.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/quiz_image_content_widget.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/top_question_widget.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class QuizStartedWidget extends StatefulWidget {
  final List<Quizz> quizzes;

  const QuizStartedWidget({super.key, required this.quizzes});

  @override
  State<QuizStartedWidget> createState() => _QuizStartedWidgetState();
}

class _QuizStartedWidgetState extends State<QuizStartedWidget>
    with
        WidgetsBindingObserver,
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin {
  late AnimationController progressIndicatorController;
  final PageController controller = PageController();
  final animationDuration = const Duration(milliseconds: 500);

  bool canGoNext = true;

  AudioPlayer? _player;

  @override
  void initState() {
    super.initState();

    Log.d('initState', 'init method', runtimeType.toString());

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
  void didUpdateWidget(covariant QuizStartedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    Log.d(
      'didUpdateWidget',
      'oldWidget : $oldWidget',
      runtimeType.toString(),
    );
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
    Log.e("dispose", "");

    try {
      // reset view pager index
      context.read<QuizBloc>().resetBlocData();
    } catch (error, stacktrace) {
      Log.e("dispose",
          "exception: $error (stacktrace: ${stacktrace.toString()})");
    }

    canGoNext = true;

    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Fimber.d("build() | data list length = : ${widget.quizzes.length}");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SiEkangColors.primaryDark,
        title: const Text('Quiz', style: TextStyle(color: Colors.white)),
        leading: IconButton(
            onPressed: () => {Navigator.of(context).pop()},
            icon: const Icon(
              Icons.arrow_back,
              color: SiEkangColors.white,
            )),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: _buildQuizContent(constraints),
        ),
      ),
    );
  }

  ///////////////////////////
  //
  // CLASS METHODS
  //
  ///////////////////////////
  Future<void> initAudioPlayer() async {
    Log.d("initAudioPlayer", "");

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

  /*Future<void> _precacheQuizImages(List<Quizz> quizzes) async {
    for (final quiz in quizzes) {
      if (quiz.quizzImage
          .trim()
          .isNotEmpty && context.mounted) {
        await precacheImage(NetworkImage(context.read<QuizBloc>().getQuizImage(quiz.quizzImage)), context);
      }
    }
  }
*/
  Widget _createPage({required int page, required Quizz quizzItem}) {
    log("createPage() | page : $page, quizz : ${quizzItem.toString()}");

    canGoNext =
        context.read<QuizBloc>().currentQuizIndex + 1 != widget.quizzes.length;

    if (context.read<QuizCheckAnswerBloc>().state
        is! QuizCheckAnswerInitialState) {
      // Reset the state when the bloc is not in QuizCheckAnswerInitialState
      context.read<QuizCheckAnswerBloc>().add(ResetCheckAnswerEvent());
    }

    bool hasImage = quizzItem.hasImage();

    // Source - https://stackoverflow.com/a/44578884
    // Posted by Ram ch, modified by community. See post 'Timeline' for change history
    // Retrieved 2025-11-16, License - CC BY-SA 4.0
    //Uint8List? imageData = await _getQuizImage(quizzItem.quizzImage);

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: TopQuestionWidget(question: quizzItem.question),
        ),
        const SizedBox(width: 0.0, height: 8.0),
        !hasImage
            ? SizedBox(width: 0.0, height: 0.0)
            : Expanded(
                flex: 5,
                child: QuizImageContentWidget(
                  quizzImage: quizzItem.quizzImage,
                ),
              ),
        const SizedBox(width: 0.0, height: 8.0),
        Expanded(
          flex: hasImage ? 5 : 7,
          child: PossibleAnswersWidget(
            quizHasImage: hasImage,
            chosenAnswer: context.read<QuizBloc>().quizChoice,
            possibleAnswers: quizzItem.possibleAnswers,
            onAnswerChanged: (newAnswer) {
              setState(() {
                context.read<QuizBloc>().setQuizChoice(newAnswer);
              });
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
              child: BottomValidateWidget(
            correctAnswer: quizzItem.correctAnswer,
            onCheckAnswer: (newState) {
              Fimber.d(
                  "onCheckAnswer() | chosen answer : ${context.read<QuizBloc>().quizChoice}, check answer state : $newState");

              // Update the state of check answer
              context.read<QuizCheckAnswerBloc>().add(
                    CheckAnswerEvent(
                      choice: context.read<QuizBloc>().quizChoice,
                      correctAnswer: quizzItem.correctAnswer,
                    ),
                  );

              // Play the audio
              // playAudio(quizzItem.audioUrl);

              // Reset the choice
              // choice = '';
            },
            onNavigateToNextPage: () {
              Fimber.d(
                  "onNavigateToNextPage() | correct answer : ${quizzItem.correctAnswer}");

              // Check if current page is the last page
              if (context.read<QuizBloc>().isLastPage()) {
                Fimber.i("onNavigateToNextPage() | Quiz finished!");

                final int totalCorrectAnswers =
                    context.read<QuizBloc>().totalCorrectAnswers;

                final double successPercentage =
                    context.read<QuizBloc>().getSuccessPercentage();

                context.read<QuizBloc>().add(
                      QuizFinishEvent(
                        score: totalCorrectAnswers.toDouble(),
                        successPercentage: successPercentage,
                      ),
                    );

                return;
              }

              _navigateToNextPage();

              // update progressbar
              final newProgress =
                  (context.read<QuizBloc>().currentQuizIndex + 1) /
                      context.read<QuizBloc>().totalQuestions;
              progressIndicatorController.value = newProgress;

              context.read<QuizBloc>().resetChoice();
            },
            enabled: context.read<QuizBloc>().quizChoice.trim().isNotEmpty,
          )),
        ),
      ],
    );
  }

  Widget _buildQuizContent(BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
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
            flex: 1,
            child: PageView.builder(
              controller: controller,
              // Disable scroll functionality
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (pageIndex) {
                if (pageIndex == widget.quizzes.length - 1) {
                  canGoNext = false;
                }
              },
              itemCount: widget.quizzes.length,
              itemBuilder: (context, position) {
                return Container(
                  child: _createPage(
                    page: position,
                    quizzItem: widget.quizzes[position],
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  void _navigateToNextPage() {
    // update page index
    //context.read<QuizBloc>().incrementQuizIndex();
    //context.read<QuizBloc>().updateQuizIndex(context.read<QuizBloc>().currentQuizIndex + 1);

    if (null == controller.page) {
      Log.e(
          "_navigateToPage", "controller.page is null", runtimeType.toString());
      return;
    }

    int nextPageIndex = controller.page!.toInt() + 1;

    Log.d(
      "_navigateToPage",
      "next page index to navigate to : $nextPageIndex",
      runtimeType.toString(),
    );

    context.read<QuizBloc>().updateQuizIndex(nextPageIndex);

    controller.nextPage(duration: animationDuration, curve: Curves.decelerate);
  }

  @override
  bool get wantKeepAlive => true;
}
