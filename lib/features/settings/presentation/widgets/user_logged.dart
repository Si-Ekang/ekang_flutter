import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/data/models/user_model.dart';

class UserLoggedWidget extends StatelessWidget {

  final UserModel user;

  const UserLoggedWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return const Text("User is logged in");
  }
}