import 'package:ekang_flutter/ui/home/home.dart';
import 'package:ekang_flutter/ui/library/library.dart';
import 'package:ekang_flutter/ui/notification/notification.dart';
import 'package:ekang_flutter/ui/profile/profile.dart';
import 'package:ekang_flutter/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    LibraryWidget(),
    NotificationWidget(),
    ProfileWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
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
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
