import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ekang_flutter/ui/quiz/quiz.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Home route'),
          onPressed: () {
            // Navigate to second route when tapped.
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuizWidget()));
          },
        ),
      ),
    );
  }
}
