import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:ekang_flutter/features/settings/presentation/widgets/sign_in_or_sign_up_form.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

// TODO: Refactor screen (only for tests currently)
class SignInOrSignUpWidget extends StatelessWidget {
  const SignInOrSignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Vous n'êtes pas connecté."),
        const SizedBox(height: 8.0),
        SignInOrSignUpForm(),
        const SizedBox(height: 8.0),
        const Divider(),
        SignInButton(Buttons.Google, onPressed: () {
          Fimber.d("SignInOrSignUpWidget.build() | on Google button clicked");

          context.read<AuthenticationBloc>().add(const SignInWithGoogle());
        })
      ],
    );
  }
}
