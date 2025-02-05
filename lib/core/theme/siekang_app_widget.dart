import 'package:ekang_flutter/core/widgets/widgets.dart';

class SiEkangAppWidget extends InheritedWidget {
  final SiEkangColors colorScheme = SiEkangColors();

  SiEkangAppWidget({super.key, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static SiEkangAppWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SiEkangAppWidget>();
  }
}
