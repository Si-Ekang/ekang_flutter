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
    loadCsvFromAssets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
            builder: (context, constraints) => Center(
                    child: Row(children: [
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

                          return GestureDetector(
                            onTap: () {
                              textToSpeak = _data[index][1].toString();
                              if (kDebugMode) log("onTap() | $textToSpeak");
                              _speak(textToSpeak!);
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('$francais = $fang'),
                                    Text(
                                        '${null != fang2 && fang2.toString().isNotEmpty ? 'traduction alternative :$fang2' : ''}'
                                        '${null != fang3 && fang3.toString().isNotEmpty ? ', $fang3' : ''}'
                                        '${null != fang4 && fang4.toString().isNotEmpty ? ', $fang4' : ''}'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ]))));
  }

  @override
  void dispose() {
    super.dispose();
    _stop();
  }

  ///////////////////////////
  //
  // CLASS METHODS
  //
  ///////////////////////////
  void loadCsvFromAssets() async {
    if (kDebugMode) log("loadCsvFromAssets()");

    final input = await rootBundle.loadString(Assets.csvVocabulary);
    final fields = const CsvToListConverter(fieldDelimiter: ';').convert(input);

    if (null != fields) {
      if (kDebugMode) log("fields : $fields");
    }

    setState(() {
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
}
