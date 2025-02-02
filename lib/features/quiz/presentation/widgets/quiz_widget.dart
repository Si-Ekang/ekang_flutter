import 'package:ekang_flutter/core/widgets/loading/loading_widget.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:ekang_flutter/features/quiz/presentation/pages/quiz_page.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/quiz_loading_error_widget.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/quiz_started_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const quizKey = GlobalObjectKey<_QuizState>(2);

class QuizWidget extends StatefulWidget {
  const QuizWidget({super.key});

  @override
  State<QuizWidget> createState() => _QuizState();
}

class _QuizState extends State<QuizWidget> {
  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(128.0),
            child: SiEkangToolbar(
              title: null,
              onTextChanged: (String inputText) {},
            )),
        body: */
        BlocConsumer<QuizBloc, QuizState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state) {
          case QuizLoading _:
            return LoadingWidget();
          case QuizLoadingError _:
            return QuizLoadingErrorWidget(
              onRetryCallback: (isRetry) {
                context.read<QuizBloc>().add(LoadQuizEvent());
              },
            );
          case QuizStarted _:
            return QuizStartedWidget(quizzes: state.quizzes);

          case QuizEnded _:
            return Container();
          default:
            return Center(
              child: Container(),
            );
        }
      },
      // )
    );
  }
}
