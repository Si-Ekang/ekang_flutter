import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechUtils {
  FlutterTts? flutterTts;
  late List<dynamic> languages;

  FlutterTts getInstance() {
    flutterTts ??= FlutterTts();
    return flutterTts!;
  }

  void initTextToSpeech() async {
    languages = await flutterTts?.getLanguages;
    await flutterTts?.setSharedInstance(true);
    await flutterTts?.awaitSpeakCompletion(true);

    await flutterTts?.setLanguage("fr-FR");

    await flutterTts?.setSpeechRate(1.0);

    await flutterTts?.setVolume(1.0);

    await flutterTts?.setPitch(1.0);

    await flutterTts?.isLanguageAvailable("en-US");

    // iOS, Android and Web only
    //see the "Pausing on Android" section for more info
    await flutterTts?.pause();

    // iOS, macOS, and Android only
    await flutterTts?.synthesizeToFile(
        "Hello World", Platform.isAndroid ? "tts.wav" : "tts.caf");

    await flutterTts?.setVoice({"name": "Karen", "locale": "en-AU"});

    // iOS only
    await flutterTts?.setSharedInstance(true);

    // Android only
    await flutterTts?.setSilence(2);

    await flutterTts?.getEngines;

    await flutterTts?.getDefaultVoice;

    await flutterTts?.isLanguageInstalled("en-AU");

    await flutterTts?.areLanguagesInstalled(["en-AU", "en-US"]);

    await flutterTts?.setQueueMode(1);

    await flutterTts?.getMaxSpeechInputLength;
  }
}
