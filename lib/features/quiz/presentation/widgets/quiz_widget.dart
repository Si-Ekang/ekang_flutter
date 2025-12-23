import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/quiz_category_chooser_widget.dart';
import 'package:ekang_flutter/features/quiz/presentation/widgets/quiz_ended_widget.dart';
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
  /*@override
  Widget build(BuildContext context) => AdsWidget();*/

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizBloc, QuizState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state) {
          case QuizLoadingState _:
            return SiEkangLoader(30, 30);
          case QuizLoadingErrorState _:
            return QuizLoadingErrorWidget(
              onRetryCallback: (isRetry) {
                context.read<QuizBloc>().add(LoadQuizEvent());
              },
            );
          case QuizCategoryChooserState _:
            return QuizCategoryChooserWidget();
          case QuizStartedState _:
            return QuizStartedWidget(quizzes: state.quizzes);

          case QuizEndedState _:
            return QuizEndedWidget(
              score: state.score,
              successPercentage: state.successPercentage,
              onFinishCallback: (value) {
                Navigator.of(context).pop();
              },
            );
          default:
            return Center(
              child: Container(),
            );
        }
      },
    );
  }
}
