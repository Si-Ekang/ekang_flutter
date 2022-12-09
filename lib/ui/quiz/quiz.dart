import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizWidget extends StatefulWidget {
  const QuizWidget({super.key});

  @override
  State<QuizWidget> createState() => _QuizState();
}

class _QuizState extends State<QuizWidget> {
  List<List<dynamic>> _data = [];

  @override
  void initState() {
    super.initState();

    if (kDebugMode) {
      log("initState()");
    }

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

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      log("build()");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Route'),
        leading: IconButton(
            onPressed: () => {Navigator.of(context).pop()},
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: _data.length,
          itemBuilder: (context, index) {
            return Card(
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
            );
          }),
    );
  }
}
