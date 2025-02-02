import 'dart:developer';

import 'package:ekang_flutter/core/utils/audio_utils.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/data/bean/wordtexttospeech.dart';
import 'package:flutter/foundation.dart';

class TopQuestionWidget extends StatelessWidget {
  final String question;

  const TopQuestionWidget({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    WordTextToSpeech? element = WordTextToSpeech.values.firstWhere(
        (element) => element.word.trim() == question,
        orElse: () => WordTextToSpeech.NONE);
    bool isVisible = (element != WordTextToSpeech.NONE) ? true : false;
    var audioAsset =
        (element != WordTextToSpeech.NONE) ? element.audioAsset : null;

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$question ?",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Visibility(
                visible: isVisible,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: InkWell(
                      child: const Icon(Icons.surround_sound_rounded,
                          size: 24, color: SiEkangColors.primary),
                      onTap: () {
                        if (kDebugMode) log("onTap()");

                        if (null != audioAsset) {
                          AudioUtils.playWord(audioAsset);
                        }
                      }),
                ))
          ],
        ));
  }
}
