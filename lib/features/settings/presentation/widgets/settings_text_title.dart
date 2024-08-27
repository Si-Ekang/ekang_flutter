import 'package:ekang_flutter/core/widgets/widgets.dart';

class SettingsTextTitle extends StatelessWidget {
  final String title;

  const SettingsTextTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
    );
  }
}
