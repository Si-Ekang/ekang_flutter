import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/authentication/authentication.dart';
import 'package:ekang_flutter/features/settings/presentation/widgets/settings_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
                useCase: AuthenticationUseCase(AuthenticationRepositoryImpl(
                    AuthenticationLocalDataSource())))
              ..add(const AuthenticationInitialEvent()))
      ],
      child: const SettingsWidget(),
    );
  }
}
