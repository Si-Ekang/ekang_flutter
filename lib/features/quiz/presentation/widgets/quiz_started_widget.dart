import 'dart:developer';

import 'package:audio_session/audio_session.dart';
import 'package:ekang_flutter/core/utils/log.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/quiz/data/models/quizz.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_check_answer_bloc.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/bottom_validate_widget.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/possible_answers_widget.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/top_question_widget.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    with WidgetsBindingObserver, TickerProviderStateMixin {
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
    Fimber.d("build() | data list length = : ${widget.quizzes.length}");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: SiEkangColors.primaryDark,
        title: const Text('Quiz', style: TextStyle(color: Colors.white)),
        leading: IconButton(
            onPressed: () => {Navigator.of(context).pop()},
            icon: const Icon(Icons.arrow_back)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: Row(
            children: [
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
                        // Disable scroll functionality
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (pageIndex) {
                          context.read<QuizBloc>().updateQuizIndex(pageIndex);

                          if (pageIndex == widget.quizzes.length - 1) {
                            canGoNext = false;
                          }
                        },
                        itemCount: widget.quizzes.length,
                        itemBuilder: (context, position) {
                          return Container(
                            child: createPage(
                              position,
                              widget.quizzes[position],
                            ),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
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

  Widget createPage(int page, Quizz quizzItem) {
    log("createPage() | page : $page, quizz : ${quizzItem.toString()}");

    canGoNext =
        context.read<QuizBloc>().currentQuizIndex + 1 != widget.quizzes.length;

    if (context.read<QuizCheckAnswerBloc>().state
        is! QuizCheckAnswerInitialState) {
      // Reset the state when the bloc is not in QuizCheckAnswerInitialState
      context.read<QuizCheckAnswerBloc>().add(ResetCheckAnswerEvent());
    }

    bool hasImage = quizzItem.quizzImage.trim().isNotEmpty;

    // Source - https://stackoverflow.com/a/44578884
    // Posted by Ram ch, modified by community. See post 'Timeline' for change history
    // Retrieved 2025-11-16, License - CC BY-SA 4.0
    //Uint8List? imageData = await _getQuizImage(quizzItem.quizzImage);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: TopQuestionWidget(question: quizzItem.question),
          ),
          !hasImage
              ? SizedBox(width: 0.0, height: 0.0)
              : Expanded(
                  flex: 5,
                  child: FutureBuilder<Uint8List?>(
                    future: _getQuizImage(quizzItem.quizzImage),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<Uint8List?> snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SiEkangLoader(30, 30);
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: SiEkangColors.quizItemSelectedTextColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.memory(snapshot.data!),
                        );
                      } else {
                        return const Text('No data available.');
                      }
                    },
                  ),
                ),
          Expanded(
            flex: hasImage ? 5 : 10,
            child: PossibleAnswersWidget(
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
            flex: 3,
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

                final bool isLastPage =
                    context.read<QuizBloc>().currentQuizIndex + 1 ==
                        widget.quizzes.length;

                // Check if current page is the last page
                if (isLastPage) {
                  Fimber.i("onNavigateToNextPage() | Quiz finished!");

                  //if (kDebugMode) {
                  //Navigator.of(context).pop();
                  // } else {
                  // TODO : Show a final screen
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
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => QuizEnded(context.read<QuizBloc>().totalCorrectAnswers, context.read<QuizBloc>().getSuccessPercentage())));
                  // }

                  return;
                }

                _navigateToNextPage();

                // update progressbar
                progressIndicatorController.value =
                    progressIndicatorController.value + 0.1;

                context.read<QuizBloc>().resetChoice();
              },
              enabled: context.read<QuizBloc>().quizChoice.trim().isNotEmpty,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToNextPage() {
    // update page index
    context.read<QuizBloc>().incrementQuizIndex();

    Log.d(
      "_navigateToPage",
      "index : ${context.read<QuizBloc>().currentQuizIndex}",
      runtimeType.toString(),
    );

    controller.animateToPage(
      context.read<QuizBloc>().currentQuizIndex,
      duration: animationDuration,
      curve: Curves.decelerate,
    );
  }

  Future<Uint8List?> _getQuizImage(String imageName) async {
    if (imageName.isEmpty) {
      Log.e("getQuizImage", "url is empty");
      return null;
    }

    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

    // Create a reference with an initial file path and name
    final pathReference = storageRef.child("images/$imageName");

    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await pathReference.getData(5 * oneMegabyte);

      if (null == data) {
        Log.d(
          "getQuizImage",
          "Error while loading image.",
          runtimeType.toString(),
        );
        return null;
      }

      // Data for "images/island.jpg" is returned, use this as needed.
      return data;

      // emit(state.copyWithState(newState: NotificationsLoadingImageSuccess(imageData: imageData)));
    } on FirebaseException catch (exception, stacktrace) {
      // Handle any errors.
      Log.e(
        "_getImagesFromFirebaseStorage",
        "exception: $exception (stacktrace: ${stacktrace.toString()})",
        runtimeType.toString(),
      );
      return null;
    }
  }
}
