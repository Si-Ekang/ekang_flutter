import 'dart:developer';

import 'package:audio_session/audio_session.dart';
import 'package:ekang_flutter/core/texttospeech/texttospeechutils.dart';
import 'package:ekang_flutter/core/texttospeech/ttsstate.dart';
import 'package:ekang_flutter/core/utils/audio_utils.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/data/bean/wordtexttospeech.dart';
import 'package:ekang_flutter/features/library/presentation/bloc/library_bloc.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';

typedef TextChangedCallback = Function(String inputText);

const libraryKey = GlobalObjectKey<_LibraryWidgetState>(1);

class LibraryWidget extends StatefulWidget {
  const LibraryWidget({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<LibraryWidget> createState() => _LibraryWidgetState();
}

class _LibraryWidgetState extends State<LibraryWidget> {
/*  List<List<dynamic>> _fields = [];
  List<List<dynamic>> _data = [];*/
  AudioPlayer? _player;
  late FlutterTts flutterTts;
  TtsState? ttsState;
  String _currentWord = '';
  String? textToSpeak;

  ///////////////////////////
  //
  // OVERRIDE
  //
  ///////////////////////////
  @override
  void initState() {
    super.initState();
    Fimber.d("initState()");

    initTTS();
    initAudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(128.0),
          child: SiEkangToolbar(
            title: null,
            onTextChanged: (newValue) {
              if (kDebugMode) {
                log('_LibraryWidgetState | SiEkangToolbar.onTextChanged | new value : $newValue');
              }

              if (newValue.trim().isEmpty) {
                Fimber.e(
                    "_LibraryWidgetState | SiEkangToolbar.onTextChanged | new value is empty");
                context.read<LibraryBloc>().add(GetCsvLibrary());
                return;
              }

              context
                  .read<LibraryBloc>()
                  .add(SearchWord(wordToSearch: newValue));
            },
          )),
      body: BlocConsumer<LibraryBloc, LibraryState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state) {
            case Idle _:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Loaded _:
              return LayoutBuilder(
                  builder: (context, constraints) => Row(children: [
                        Container(
                            constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth >= 500
                                    ? 500
                                    : constraints.maxWidth),
                            child: _buildVocabularyList(state.data))
                      ]));
            case Found _:
              return LayoutBuilder(
                  builder: (context, constraints) => Row(
                        children: [
                          Container(
                              constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth >= 500
                                      ? 500
                                      : constraints.maxWidth),
                              child: _buildVocabularyList(state.words))
                        ],
                      ));
            case NotFound _:
              return LayoutBuilder(
                  builder: (context, constraints) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Content of row
                          // Load a Lottie file from your assets
                          Lottie.asset(
                            Assets.lottieError404,
                            width: 250,
                            height: 250,
                            fit: BoxFit.contain,
                          ),

                          Text("No item found for value : ${state.wordQuery}")
                        ],
                      ));
            default:
              return Center(
                child: Container(),
              );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    if (TtsState.playing == ttsState) {
      _stop();
    }
    super.dispose();
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

  void initTTS() async {
    if (kDebugMode) log("initTTS()");

    flutterTts = TextToSpeechUtils().getInstance();

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setProgressHandler(
        (String text, int startOffset, int endOffset, String word) {
      setState(() {
        _currentWord = word;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    // Android, iOS and Web
    flutterTts.setPauseHandler(() {
      setState(() {
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        ttsState = TtsState.continued;
      });
    });
  }

  Future _speak(String text) async {
    try {
      var result = await flutterTts.speak(text);
      if (result == 1) setState(() => ttsState = TtsState.playing);
    } catch (exception) {
      Fimber.e('Error caught: ${exception.toString()}');
    }
  }

  Future _stop() async {
    try {
      var result = await flutterTts.stop();
      if (result == 1) setState(() => ttsState = TtsState.stopped);
    } catch (exception) {
      Fimber.e('Error caught: ${exception.toString()}');
    }
  }

  void onTextChanged(String query) {
    if (kDebugMode) log("onTextChanged() | query: $query");

    _currentWord = query;

    if ('' == _currentWord) {
      _currentWord = '';

      /*setState(() {
        _data = _fields;
      });*/
    } else {
      /*final suggestions = _fields.where((element) {
        var frenchWord = element[0].toString().toLowerCase();
        var ekangWord = element[1].toString().toLowerCase();

        return frenchWord.contains(_currentWord) ||
            ekangWord.contains(_currentWord);
      }).toList();

      setState(() {
        _data = suggestions;
      });*/
    }
  }

  Widget _buildVocabularyList(List<List<dynamic>> data) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          var francais = data[index][0];
          var fang = data[index][1];
          var fang2 = data[index][2];
          var fang3 = data[index][3];
          var fang4 = data[index][4];

          return Material(
              child: Card(
                  child: ListTile(
            title: Text('$francais = $fang'),
            subtitle: Text(
                '${null != fang2 && fang2.toString().isNotEmpty ? 'traduction alternative :$fang2' : ''}'
                '${null != fang3 && fang3.toString().isNotEmpty ? ', $fang3' : ''}'
                '${null != fang4 && fang4.toString().isNotEmpty ? ', $fang4' : ''}'),
            onTap: () {
              WordTextToSpeech? element = WordTextToSpeech.values.firstWhere(
                  (element) => element.word.trim() == data[index][1].toString(),
                  orElse: () => WordTextToSpeech.NONE);

              // bool isVisible = (element != WordTextToSpeech.NONE) ? true : false;

              var audioAsset = (element != WordTextToSpeech.NONE)
                  ? element.audioAsset
                  : null;

              textToSpeak = data[index][1].toString();

              if (kDebugMode) {
                log("onTap() | $textToSpeak");
                log("onTap() | $audioAsset");
              }
              // _speak(textToSpeak!);

              if (null != audioAsset || true == audioAsset?.isNotEmpty) {
                AudioUtils.playWord(audioAsset!);
              }
            },
            trailing: const Icon(Icons.surround_sound_rounded),
          )));
        });
  }
}
