import 'package:ekang_flutter/core/utils/constants.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/authentication/authentication.dart';
import 'package:ekang_flutter/features/settings/presentation/widgets/settings_text_title.dart';
import 'package:ekang_flutter/features/settings/presentation/widgets/sign_in_or_sign_up.dart';
import 'package:ekang_flutter/features/settings/presentation/widgets/sign_in_or_sign_up_error.dart';
import 'package:ekang_flutter/features/settings/presentation/widgets/user_logged.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO : Define here the several settings for the application
// TODO : Authentication group
// TODO : Application theme change mode
// TODO : Download library content on the device

class SettingsWidget extends StatefulWidget {
  final bool isAuthenticated = false;

  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AuthenticationBloc>().add(IsLoggedIn());
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(128.0),
            child: SiEkangToolbar(
              title: Constants.settingsTitle,
              onTextChanged: null,
            )),
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
          if (kDebugMode) {
            Fimber.d("_SettingsState.build() | state: ${state.runtimeType}");
          }
        }, builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Authentication section
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SettingsTextTitle(title: "Compte"),
                        const SizedBox(height: 16.0),
                        switch (state) {
                          AuthenticationInitialState _ =>
                            const SignInOrSignUpWidget(),
                          AuthenticationLoadingState _ =>
                            const CircularProgressIndicator(),
                          AuthenticationSuccessState _ => UserLoggedWidget(
                              user: state.user,
                            ),
                          AuthenticationFailureState _ =>
                            SignInOrSignUpError(message: state.errorMessage),

                          // TODO: Handle this case.
                          AuthenticationState() => Container(),
                        }
                      ],
                    ),
                  ),
                ],
              ));
        }));
  }
}
