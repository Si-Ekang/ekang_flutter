import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:ekang_flutter/core/texttospeech/texttospeechutils.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../core/texttospeech/ttsstate.dart';

class LibraryWidget extends StatefulWidget {
  const LibraryWidget({super.key});

  @override
  State<LibraryWidget> createState() => _LibraryState();
}

class _LibraryState extends State<LibraryWidget> {
  List<List<dynamic>> _data = [];
  late FlutterTts flutterTts;
  TtsState? ttsState;
  String? _currentWord;
  String? textToSpeak;

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      log("initState()");
    }

    initTTS();
    loadCsvFromAssets();
  }

  void loadCsvFromAssets() async {
    if (kDebugMode) {
      log("loadCsvFromAssets()");
    }

    final input = await rootBundle.loadString(Assets.csvTest);
    final fields = const CsvToListConverter().convert(input);

    if (null != fields) {
      if (kDebugMode) {
        log("fields : $fields");
      }
    }

    setState(() {
      _data = fields;
    });
  }

  void initTTS() async {
    if (kDebugMode) {
      log("initTTS()");
    }

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

    // Android only
    flutterTts.setInitHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                textToSpeak = _data[index][1].toString();
                log("onTap() | $textToSpeak");
                _speak(textToSpeak!);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${_data[index][0]}'),
                      Text(_data[index][1]),
                      Text(_data[index][2]),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _stop();
  }
}
