import 'package:ekang_flutter/core/widgets/widgets.dart';

class QuizLoadingErrorWidget extends StatefulWidget {
  final Function(bool) onRetryCallback;

  const QuizLoadingErrorWidget({super.key, required this.onRetryCallback});

  @override
  State<QuizLoadingErrorWidget> createState() => _QuizLoadingErrorWidgetState();
}

class _QuizLoadingErrorWidgetState extends State<QuizLoadingErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: SiEkangColors.primaryDark,
          title: const Text('Quiz'),
          leading: IconButton(
              onPressed: () => {Navigator.of(context).pop()},
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Error loading the quiz. Please try again.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => widget.onRetryCallback(true),
                child: Text("Retry"),
              ),
              const SizedBox(height: 20),
              const Text(
                'Or go back to the home screen.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ));
  }
}
