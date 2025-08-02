import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:ekang_flutter/features/profile/presentation/pages/profile_page.dart';
import 'package:ekang_flutter/features/settings/presentation/widgets/sign_in_or_sign_up_form.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

typedef HeaderBuilder = Widget Function(
    BuildContext context,
    BoxConstraints constraints,
    double shrinkOffset,
    );

// TODO: Refactor screen (only for tests currently)
class SignInOrSignUpWidget extends StatelessWidget {
  const SignInOrSignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {

    /*return Expanded(flex: 1,child: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
             EmailAuthProvider(),
            // GoogleAuthProvider(),
          ],
            headerBuilder: (context, constraints, shrinkOffset) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(Assets.imagesFlutterfire),
              ),
            );
          },);  // Modify this line
        }

        return  Column(
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
      },
    ),);*/

    //////////////////////////////////////////////////////////////////////////////::

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
