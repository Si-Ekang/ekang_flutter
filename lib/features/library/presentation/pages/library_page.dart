import 'package:ekang_flutter/features/library/presentation/bloc/library_bloc.dart';
import 'package:ekang_flutter/features/library/presentation/widgets/library_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return /*MultiBlocProvider(
      providers: [
        BlocProvider<LibraryBloc>(
            create: (context) => LibraryBloc()..add(GetCsvLibrary()))
      ],
      child:*/ const LibraryWidget()/*,
    )*/;
  }
}
