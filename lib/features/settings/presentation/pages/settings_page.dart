import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/data/data_sources/remote_data_source.dart';
import 'package:ekang_flutter/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:ekang_flutter/features/settings/presentation/widgets/settings_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(RemoteDataSource())
              ..add(const AuthenticationInitialEvent()))
      ],
      child: const SettingsWidget(),
    );
  }
}
