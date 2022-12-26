import 'dart:developer';

import 'package:ekang_flutter/core/component/siekangtoolbar.dart';
import 'package:ekang_flutter/ui/home/home.dart';
import 'package:ekang_flutter/ui/library/library.dart';
import 'package:ekang_flutter/ui/notification/notification.dart';
import 'package:ekang_flutter/ui/profile/profile.dart';
import 'package:ekang_flutter/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPageWidget(),
    );
  }
}

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MainPageWidget> createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  ///////////////////////////
  // Widgets
  ///////////////////////////
  static SiEkangToolbar toolbar = SiEkangToolbar(
    onPageChanged: (RouteSettings routeSettings, bool isLibrary) {},
  );

  static const List<BottomNavigationBarItem> _bottomNavigationList =
      <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: Constants.homeTitle),
    BottomNavigationBarItem(
      icon: Icon(Icons.menu_book),
      label: Constants.libraryTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      label: Constants.notificationsTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: Constants.profileTitle,
    ),
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    LibraryWidget(),
    NotificationWidget(),
    ProfileWidget(),
  ];

  // Index variable used to navigate
  int _selectedIndex = 0;

  ///////////////////////////
  //
  // OVERRIDE
  //
  ///////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbar,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationList,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          if (kDebugMode) log('onTap()');
          _onItemTapped(index);
          _updateToolbarWithIndex(index);
        },
      ),
    );
  }

  ///////////////////////////
  //
  // CLASS METHODS
  //
  ///////////////////////////
  void _onItemTapped(int index) {
    if (kDebugMode) log('_onItemTapped() | index : $index');
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateToolbarWithIndex(int index) {
    if (kDebugMode) log('_updateToolbarWithIndex() | index : $index');
    // current page
    var currentPage = _bottomNavigationList.elementAt(index);
    var pageName = currentPage.label;

    // Check state nullability
    if (null != key.currentState) {
      if (kDebugMode) log('Check state nullability');
      key.currentState!.updateRoute(pageName!,
          Constants.libraryTitle == ModalRoute.of(context)?.settings.name);
    }
  }
}
