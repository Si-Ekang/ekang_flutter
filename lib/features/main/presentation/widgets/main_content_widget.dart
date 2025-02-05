import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/home/home.dart';
import 'package:ekang_flutter/features/library/library.dart';
import 'package:ekang_flutter/features/notifications/notifications.dart';
import 'package:ekang_flutter/features/settings/settings.dart';

class MainContentWidget extends StatefulWidget {
  int currentIndex = 0;

  final List<Widget> _pagesOptions = <Widget>[
    const HomePage(),
    const LibraryPage(),
    const NotificationPage(),
    const SettingsPage(),
  ];

  MainContentWidget({super.key, required this.currentIndex});

  @override
  State<MainContentWidget> createState() => _MainContentWidgetState();
}

class _MainContentWidgetState extends State<MainContentWidget> {
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      alignment: Alignment.center,
      children: [
        Center(
          child: widget._pagesOptions.elementAt(widget.currentIndex),
        )
      ],
    );
  }
}
