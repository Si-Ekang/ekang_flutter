import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc() : super(QuizInitial()) {
    on<QuizEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
