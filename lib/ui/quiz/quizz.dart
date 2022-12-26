import 'dart:developer';

import 'package:ekang_flutter/core/theme/siekangcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QuizWidget extends StatefulWidget {
  const QuizWidget({super.key});

  @override
  State<QuizWidget> createState() => _QuizState();
}

class _QuizState extends State<QuizWidget> {
  final PageController controller = PageController();
  final animationDuration = const Duration(milliseconds: 500);

  List<Widget> quizzList = List.empty();
  List<List<dynamic>> _data = [];

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      log("initState()");
    }

    //loadCsvFromAssets();
  }

  void loadCsvFromAssets() async {
    if (kDebugMode) {
      log("loadCsvFromAssets()");
    }
/*
    final input = await rootBundle.loadString(Assets.csvTest);
    final fields = const CsvToListConverter().convert(input);

    if (null != fields) {
      if (kDebugMode) {
        log("fields : $fields");
      }
    }

    setState(() {
      _data = fields;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      log("build()");
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: SiEkangColors.primaryDark,
          title: const Text('Quiz Route'),
          leading: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: const Icon(Icons.arrow_back)),
        ),
        body: PageView(
          controller: controller,
          children: <Widget>[
            Container(
              color: Colors.pink,
              child: Card(
                child: ElevatedButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: animationDuration,
                          curve: Curves.decelerate);
                    },
                    child: const Text("Next")),
              ),
            ),
            Container(
              color: Colors.cyan,
              child: Card(
                child: ElevatedButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: animationDuration,
                          curve: Curves.decelerate);
                    },
                    child: const Text("Next")),
              ),
            ),
            Container(
              color: Colors.deepPurple,
              child: Card(
                child: ElevatedButton(
                    onPressed: () {
                      controller.previousPage(
                          duration: animationDuration,
                          curve: Curves.decelerate);
                    },
                    child: const Text("Previous")),
              ),
            ),
          ],
        ));
  }
}
