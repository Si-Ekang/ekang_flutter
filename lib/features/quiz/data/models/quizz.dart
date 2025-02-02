import 'dart:developer';

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

  Quizz.withData(questionId, this.question, this.quizzImage, possibleAnswers,
      this.correctAnswer) {
    id = questionId;
    this.possibleAnswers = (possibleAnswers as String).split('|').toList();
  }

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
    if (kDebugMode) log("toQuizzList() : fields length : ${fields.length}");

    List<Quizz> list = List.empty(growable: true);

    try {
      for (var element in fields) {
        if (!element[0].contains('question_id') || element[1].contains('question')  ) {
          if (kDebugMode) log("list.add() | element : $element");
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
      if (kDebugMode) log("error : ${exception.toString()}");
      return List.empty(growable: false);
    }
  }
}
