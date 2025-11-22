import 'dart:developer';

import 'package:ekang_flutter/core/utils/log.dart';
import 'package:flutter/foundation.dart';

class Quizz {
  int id = 0;

  String question = "";
  String quizzImage = "";
  List<String> possibleAnswers = List.empty();
  String correctAnswer = "";

  ////////////////////////////////////
  //
  // Constructor
  //
  ////////////////////////////////////
  Quizz();

  Quizz.withData(
    questionId,
    this.question,
    this.quizzImage,
    possibleAnswers,
    this.correctAnswer,
  ) {
    id = questionId;
    this.possibleAnswers = (possibleAnswers as String).split('|').toList();
  }

  bool hasImage() => quizzImage.trim().isNotEmpty;

  @override
  String toString() {
    return 'Quizz{id: $id, question: $question, quizzImage: $quizzImage, possibleAnswers: $possibleAnswers, correctAnswer: $correctAnswer}';
  }

  ////////////////////////////////////
  //
  // Class Methods
  //
  ////////////////////////////////////
  static List<Quizz> toQuizzList(List<List<dynamic>> fields) {
    Log.d("toQuizzList", "fields length : ${fields.length}", "Quizz");

    List<Quizz> list = List.empty(growable: true);

    try {
      for (var element in fields) {
        if (element[0] != 'question_id') {
          Log.d("toQuizzList", "element : $element", "Quizz");

          list.add(Quizz.withData(
              // questionId
              element[0],
              // question
              element[1],
              // imageUrl
              element[2],
              // possibleAnswers
              element[3],
              // correctAnswer
              element[4]));
        }
      }

      return list;
    } catch (exception) {
      Log.e("toQuizzList", "error : ${exception.toString()}");
      return List.empty(growable: false);
    }
  }
}
