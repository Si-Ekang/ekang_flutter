import 'package:ekang_flutter/features/main/presentation/bloc/main_bloc.dart';
import 'package:ekang_flutter/features/main/presentation/widgets/main_widget.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  static const String routeName = "MainPage";
  const MainPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          create: (context) => MainBloc()..add(GetCategories()),
        ),
      ],
      child: const MaterialApp(home: MainWidget()),
    );
  }
}
