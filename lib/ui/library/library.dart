import 'dart:developer';

import 'package:audio_session/audio_session.dart';
import 'package:csv/csv.dart';
import 'package:ekang_flutter/core/texttospeech/texttospeechutils.dart';
import 'package:ekang_flutter/data/bean/wordtexttospeech.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:ekang_flutter/core/utils/audio_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/texttospeech/ttsstate.dart';

typedef TextChangedCallback = Function(String inputText);

final libraryKey = GlobalKey<_LibraryState>();

class LibraryWidget extends StatefulWidget {
  LibraryWidget() : super(key: libraryKey);

  @override
  State<LibraryWidget> createState() => _LibraryState();
}

class _LibraryState extends State<LibraryWidget> {
  List<List<dynamic>> _fields = [];
  List<List<dynamic>> _data = [];
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

    if (kDebugMode) log("initState()");

    initTTS();
    initAudioPlayer();
    loadCsvFromAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
            builder: (context, constraints) => Row(children: [
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: constraints.maxWidth >= 500
                            ? 500
                            : constraints.maxWidth),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _data.length,
                        itemBuilder: (context, index) {
                          var francais = _data[index][0];
                          var fang = _data[index][1];
                          var fang2 = _data[index][2];
                          var fang3 = _data[index][3];
                          var fang4 = _data[index][4];

                          return Material(
                              child: Card(
                                  child: ListTile(
                            title: Text('$francais = $fang'),
                            subtitle: Text(
                                '${null != fang2 && fang2.toString().isNotEmpty ? 'traduction alternative :$fang2' : ''}'
                                '${null != fang3 && fang3.toString().isNotEmpty ? ', $fang3' : ''}'
                                '${null != fang4 && fang4.toString().isNotEmpty ? ', $fang4' : ''}'),
                            onTap: () {
                              WordTextToSpeech? element =
                                  WordTextToSpeech.values.firstWhere(
                                      (element) =>
                                          element.word.trim() ==
                                          _data[index][1].toString(),
                                      orElse: () => WordTextToSpeech.NONE);

                              // bool isVisible = (element != WordTextToSpeech.NONE) ? true : false;

                              var audioAsset =
                                  (element != WordTextToSpeech.NONE)
                                      ? element.audioAsset
                                      : null;

                              textToSpeak = _data[index][1].toString();

                              if (kDebugMode) {
                                log("onTap() | $textToSpeak");
                                log("onTap() | $audioAsset");
                              }
                              // _speak(textToSpeak!);

                              if (null != audioAsset ||
                                  true == audioAsset?.isNotEmpty) {
                                AudioUtils.playWord(audioAsset!);
                              }
                            },
                            trailing: const Icon(Icons.surround_sound_rounded),
                          )));
                        }),
                  )
                ])));
  }

  @override
  void dispose() {
    _stop();
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

  void loadCsvFromAssets() async {
    if (kDebugMode) log("loadCsvFromAssets()");

    final input = await rootBundle.loadString(Assets.csvVocabulary);
    final fields = const CsvToListConverter(fieldDelimiter: ';').convert(input);

    /*if (null != fields) {
      if (kDebugMode) log("fields : $fields");
    }*/

    setState(() {
      _fields = fields;
      _data = fields;
    });
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
    var result = await flutterTts.speak(text);
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  void onTextChanged(String query) {
    if (kDebugMode) log("onTextChanged() | query: $query");

    _currentWord = query;

    if ('' == _currentWord) {
      _currentWord = '';

      setState(() {
        _data = _fields;
      });
    } else {
      final suggestions = _fields.where((element) {
        var frenchWord = element[0].toString().toLowerCase();
        var ekangWord = element[1].toString().toLowerCase();

        return frenchWord.contains(_currentWord) ||
            ekangWord.contains(_currentWord);
      }).toList();

      setState(() {
        _data = suggestions;
      });
    }
  }
}
