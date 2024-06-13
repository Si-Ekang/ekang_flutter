import 'package:ekang_flutter/features/library/presentation/bloc/library_bloc.dart';
import 'package:ekang_flutter/features/library/presentation/pages/library_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryWidget extends StatelessWidget {
  const LibraryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LibraryBloc>(
            create: (context) => LibraryBloc()..add(GetCsvLibrary()))
      ],
      child: const LibraryPage(),
    );
  }
}
