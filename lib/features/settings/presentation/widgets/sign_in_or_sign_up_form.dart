import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInOrSignUpForm extends StatefulWidget {
  const SignInOrSignUpForm({super.key});

  @override
  State<SignInOrSignUpForm> createState() => _SignInOrSignUpFormState();
}

class _SignInOrSignUpFormState extends State<SignInOrSignUpForm> {
  final double _borderWidth = 2.0;

  final _loginTextFieldController = TextEditingController();
  final _passwordTextFieldController = TextEditingController();

  /////////////////////////////////////////////////
  //
  // OVERRIDE
  //
  /////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();

    _loginTextFieldController.text = "chronopost_test_dev@test.fr";
    _passwordTextFieldController.text = "test123456";
  }

  @override
  void dispose() {
    _loginTextFieldController.dispose();
    _passwordTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Login
        SizedBox(
          width: double.infinity,
          child: _commonTextField(
            controller: _loginTextFieldController,
            label: "Login",
            errorText: "Login field cannot be empty",
            onChanged: (newValue) {},
            obscureText: false,
          ),
        ),
        const SizedBox(height: 16.0),
        // Password
        SizedBox(
          width: double.infinity,
          child: _commonTextField(
            controller: _passwordTextFieldController,
            label: "Password",
            errorText: "Password field cannot be empty",
            onChanged: (newValue) {},
            obscureText: true,
          ),
        ),
        const SizedBox(height: 12.0),

        kDebugMode
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Reset fields Button
                  ElevatedButton(
                      onPressed: () {
                        // Reset fields
                        _resetFields();
                      },
                      child: Text("Reset")),
                  _loginButton()
                ],
              )
            : _loginButton(),
      ],
    );
  }

  /////////////////////////////////////////////////
  //
  // CLASS METHODS
  //
  /////////////////////////////////////////////////
  /// Create a common field
  Widget _commonTextField({
    required TextEditingController controller,
    required String label,
    required String errorText,
    required Function(String) onChanged,
    bool obscureText = false,
  }) =>
      TextField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: SiEkangColors.colorAccent, width: _borderWidth),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: SiEkangColors.primary, width: _borderWidth),
          ),
          errorText: !_validate() ? errorText : null,
          labelText: label,
          hintText: label,
        ),
        obscureText: obscureText,
        autocorrect: false,
        enabled: true,
        maxLines: 1,
        textAlign: TextAlign.start,
        onChanged: onChanged,
      );

  /// Create a login button widget
  Widget _loginButton() => ElevatedButton(
        onPressed: () {
          if (!_validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Error with login and/or password. Fields cannot be empty')),
            );
            return;
          }

          // Submit login with fields' data
          Fimber.d("SignInOrSignUpWidget.build() | on sign up/sign in button clicked");

          context.read<AuthenticationBloc>().add(
                SignUpUser(
                  _loginTextFieldController.text,
                  _passwordTextFieldController.text,
                ),
              );
        },
        child: Text("S'enregister / Se Connecter"),
      );

  bool _validate() =>
      _loginTextFieldController.text.isNotEmpty &&
      _passwordTextFieldController.text.isNotEmpty;

  void _resetFields() {
    _loginTextFieldController.clear();
    _passwordTextFieldController.clear();
  }
}
