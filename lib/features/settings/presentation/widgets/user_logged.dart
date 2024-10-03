import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/authentication/authentication.dart';
import 'package:ekang_flutter/features/authentication/data/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLoggedWidget extends StatelessWidget {
  final UserModel user;

  const UserLoggedWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text("User is logged in"),
      const SizedBox(height: 8.0),
      ElevatedButton(
          onPressed: () {
            context.read<AuthenticationBloc>().add(SignOut());
          },
          child: Text("Log Out"))
    ]);
  }
}
