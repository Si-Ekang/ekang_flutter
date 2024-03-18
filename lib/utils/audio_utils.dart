import 'dart:developer';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';

import '../../core/texttospeech/ttsstate.dart';

class AudioUtils {
  static AudioPlayer? _player;
  FlutterTts? flutterTts;
  TtsState? ttsState;

  AudioUtils._() {
    if (kDebugMode) log("AudioUtils() | private constructor");
  }

  static Future<void> _initAudioPlayer() async {
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

  static void playWord(String audioAsset) async {
    log("playWord() | audioAsset : $audioAsset");

    if (null == _player) {
      _initAudioPlayer();
    }

    // Try to load audio from a source and catch any errors.
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      // await _player.setAudioSource(AudioSource.uri(Uri.parse("https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
      var data = await _player?.setAsset(audioAsset).then((value) => null);
      _player?.play();
    } catch (e) {
      log("Error loading audio source: $e");
    }
  }
}
