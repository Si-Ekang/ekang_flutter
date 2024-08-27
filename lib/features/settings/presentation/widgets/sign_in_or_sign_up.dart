import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:ekang_flutter/ui/auth/bloc/login/login_cubit.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

// TODO: Refactor screen (only for tests currently)
class SignInOrSignUpWidget extends StatelessWidget {
  static const String _email = "chronopost_test_dev@test.fr";
  static const String _password = "test123456";

  const SignInOrSignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Vous n'êtes pas connecté."),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            Fimber.d(
                "SignInOrSignUpWidget.build() | on sign up/sign in button clicked");

            context
                .read<AuthenticationBloc>()
                .add(const SignUpUser(_email, _password));
          },
          child: const Text("S'enregister / Se Connecter"),
        ),
        const Divider(),
        SignInButton(Buttons.Google, onPressed: () {
          Fimber.d("SignInOrSignUpWidget.build() | on Google button clicked");

          context.read<AuthenticationBloc>().add(const SignInWithGoogle());
        })
      ],
    );
  }
}
