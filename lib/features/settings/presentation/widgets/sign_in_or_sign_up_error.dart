import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInOrSignUpError extends StatelessWidget {
  final String message;

  const SignInOrSignUpError({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                message,
                maxLines: 3,
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(ResetState());
            },
            child: const Text("Retry")),
      ],
    );
  }
}
