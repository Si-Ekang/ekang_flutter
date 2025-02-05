import 'package:ekang_flutter/core/widgets/widgets.dart';

class SnackBarManager {
  void showSuccessSnackBar({
    required BuildContext context,
    required String message,
  }) {
    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            ));
  }

  void showErrorSnackBar({
    required BuildContext context,
    required String message,
  }) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.redAccent,
              ),
            ));
  }
}
