import 'package:ekang_flutter/core/utils/constants.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:fimber/fimber.dart';

typedef OnNavigationItemSelected = Function(int bottomBarItemIndex);

class MainBottomNavigationBarWidget extends StatefulWidget {
  final List<BottomNavigationBarItem> _bottomNavigationList =
      <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded),
      label: Constants.homeTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.menu_book_rounded),
      label: Constants.libraryTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications_rounded),
      label: Constants.notificationsTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_rounded),
      label: Constants.settingsTitle,
    ),
  ];

  final int selectedIndex;
  final OnNavigationItemSelected onNavigationItemSelected;

  MainBottomNavigationBarWidget({
    super.key,
    required this.selectedIndex,
    required this.onNavigationItemSelected,
  });

  @override
  State<MainBottomNavigationBarWidget> createState() =>
      _MainBottomNavigationBarWidgetState();
}

class _MainBottomNavigationBarWidgetState
    extends State<MainBottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: widget._bottomNavigationList,
      currentIndex: widget.selectedIndex,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        Fimber.i("onTap() | index selected : $index");
        widget.onNavigationItemSelected(index);
      },
    );
  }
}
