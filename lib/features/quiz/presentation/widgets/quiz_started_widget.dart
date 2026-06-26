import 'dart:developer';

import 'package:audio_session/audio_session.dart';
import 'package:ekang_flutter/core/utils/log.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/quiz/data/models/quizz.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_bloc.dart';
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

  AudioPlayer? _player;

  @override
  void initState() {
    super.initState();

    Log.d('initState', 'init method', runtimeType.toString());

    progressIndicatorController = AnimationController(
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
      _player?.stop();
    }
  }

  @override
  void dispose() {
    Log.e("dispose", "");

    try {
      context.read<QuizBloc>().add(ResetQuizEvent());
    } catch (error, stacktrace) {
      Log.e("dispose",
          "exception: $error (stacktrace: ${stacktrace.toString()})");
    }

    _player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Fimber.d("build() | data list length = : ${widget.quizzes.length}");

    return BlocConsumer<QuizBloc, QuizState>(
      listener: (context, state) {
        // Animate page controller when the active page index changes in state
        if (controller.hasClients && controller.page?.round() != state.currentQuizIndex) {
          controller.animateToPage(
            state.currentQuizIndex,
            duration: animationDuration,
            curve: Curves.decelerate,
          );
        }
        // Update progress bar indicator value
        if (state.quizzes.isNotEmpty) {
          progressIndicatorController.value = state.currentQuizIndex / state.quizzes.length;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: SiEkangColors.primaryDark,
            title: const Text('Quiz', style: TextStyle(color: Colors.white)),
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
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
                                child: LinearProgressIndicator(
                                  minHeight: 4.0,
                                  color: SiEkangColors.quizItemSelectedTextColor,
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                      SiEkangColors.quizItemSelectedTextColor),
                                  value: progressIndicatorController.value,
                                  semanticsLabel: 'Linear progress indicator',
                                ),
                              ),
                            )),

                        // PageView quizz
                        Expanded(
                          child: PageView.builder(
                            controller: controller,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.quizzes.length,
                            itemBuilder: (context, position) {
                              return createPage(
                                position,
                                state.quizzes[position],
                                state,
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
      },
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
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.speech());
      _player?.playbackEventStream.listen((event) {
        if (kDebugMode) log("event : $event");
      }, onError: (Object e, StackTrace stackTrace) {
        if (kDebugMode) log('A stream error occurred: $e');
      });
    } catch (e) {
      log("Error loading audio source: $e");
    }
  }

  Widget createPage(int page, Quizz quizzItem, QuizState state) {
    log("createPage() | page : $page, quizz : ${quizzItem.toString()}");

    bool hasImage = quizzItem.quizzImage.trim().isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: TopQuestionWidget(question: quizzItem.question),
          ),
          !hasImage
              ? const SizedBox(width: 0.0, height: 0.0)
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
                            side: const BorderSide(
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
              chosenAnswer: state.quizChoice,
              possibleAnswers: quizzItem.possibleAnswers,
              onAnswerChanged: (newAnswer) {
                context.read<QuizBloc>().add(SelectChoiceEvent(choice: newAnswer));
              },
            ),
          ),
          BottomValidateWidget(
            correctAnswer: quizzItem.correctAnswer,
          ),
        ],
      ),
    );
  }

  Future<Uint8List?> _getQuizImage(String imageName) async {
    if (imageName.isEmpty) {
      Log.e("getQuizImage", "url is empty");
      return null;
    }

    final storageRef = FirebaseStorage.instance.ref();
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

      return data;
    } on FirebaseException catch (exception, stacktrace) {
      Log.e(
        "_getImagesFromFirebaseStorage",
        "exception: $exception (stacktrace: ${stacktrace.toString()})",
        runtimeType.toString(),
      );
      return null;
    }
  }
}
