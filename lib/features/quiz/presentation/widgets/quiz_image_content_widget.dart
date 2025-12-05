import 'dart:typed_data';

import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizImageContentWidget extends StatefulWidget {
  final String quizzImage;

  const QuizImageContentWidget({required this.quizzImage, super.key});

  @override
  State<StatefulWidget> createState() => _QuizImageContentState();
}

class _QuizImageContentState extends State<QuizImageContentWidget> {
  Uint8List? imageData;

  @override
  Widget build(BuildContext context) {
    return null == imageData
        ? FutureBuilder<Uint8List?>(
            future: context.read<QuizBloc>().getQuizImage(widget.quizzImage),
            builder: (
              BuildContext context,
              AsyncSnapshot<Uint8List?> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SiEkangLoader(30, 30);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                imageData = snapshot.data!;
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: SiEkangColors.quizItemSelectedTextColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.memory(snapshot.data!),
                );
              } else {
                return const Text('No data available.');
              }
            },
          )
        : Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: SiEkangColors.quizItemSelectedTextColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.memory(imageData!),
          );
  }
}
