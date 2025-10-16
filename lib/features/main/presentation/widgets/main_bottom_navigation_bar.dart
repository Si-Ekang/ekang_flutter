import 'package:ekang_flutter/core/utils/constants.dart';
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/notifications/notifications.dart';
import 'package:ekang_flutter/features/notifications/presentation/bloc/notifications_state.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef OnNavigationItemSelected = Function(int bottomBarItemIndex);

class MainBottomNavigationBarWidget extends StatefulWidget {
  final int selectedIndex;
  final OnNavigationItemSelected onNavigationItemSelected;

  const MainBottomNavigationBarWidget({
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

  bool hasNotifications = false;
  int notificationCount = 0;

  late final List<BottomNavigationBarItem> _bottomNavigationList =
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
      icon: !hasNotifications || 0 == notificationCount
          ? const Icon(Icons.notifications_rounded)
          : Badge.count(
              count: notificationCount,
              child: const Icon(Icons.notifications_rounded)),
      label: Constants.notificationsTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings_rounded),
      label: Constants.settingsTitle,
    ),
  ];

  @override
  void initState() {
    super.initState();
    Fimber.d("initState()");

    hasNotifications = context.read<NotificationsBloc>().state
            is NotificationsSuccess &&
        true ==
            (context.read<NotificationsBloc>().state as NotificationsSuccess?)
                ?.model
                .features
                .isNotEmpty;
    notificationCount =
        (context.read<NotificationsBloc>().state as NotificationsSuccess?)
                ?.model
                .features
                .length ??
            0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Fimber.d("didChangeDependencies()");
  }

  @override
  void didUpdateWidget(covariant MainBottomNavigationBarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    Fimber.d("didUpdateWidget()");
    hasNotifications = context.read<NotificationsBloc>().state
            is NotificationsSuccess &&
        true ==
            (context.read<NotificationsBloc>().state as NotificationsSuccess?)
                ?.model
                .features
                .isNotEmpty;
    notificationCount =
        (context.read<NotificationsBloc>().state as NotificationsSuccess?)
                ?.model
                .features
                .length ??
            0;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _bottomNavigationList,
      currentIndex: widget.selectedIndex,
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.amber[800],
      onTap: (index) {
        Fimber.i("onTap() | index selected : $index");
        widget.onNavigationItemSelected(index);
      },
    );
  }

  @override
  void dispose() {
    Fimber.e("dispose()");
    super.dispose();
  }
}
