import 'package:ekang_flutter/features/main/presentation/bloc/main_bloc.dart';
import 'package:ekang_flutter/features/main/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          create: (context) => MainBloc()
            ..add(
              GetCategories(),
            ),
        ),
      ],
      child: const MaterialApp(home: MainPage()),
    );
  }
}
