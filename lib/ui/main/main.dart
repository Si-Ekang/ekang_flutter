import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ekang_flutter/core/component/siekangtoolbar.dart';
import 'package:ekang_flutter/core/network/connectvity_controller.dart';
import 'package:ekang_flutter/ui/home/home.dart';
import 'package:ekang_flutter/ui/library/library.dart';
import 'package:ekang_flutter/ui/notification/notification.dart';
import 'package:ekang_flutter/ui/profile/profile.dart';
import 'package:ekang_flutter/core/utils/constants.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  ConnectivityController connectivityController = ConnectivityController();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ///////////////////////////
  // Widgets
  ///////////////////////////
  static SiEkangToolbar toolbar = SiEkangToolbar(
      onPageChanged: (RouteSettings routeSettings, bool isLibrary) {
    if (kDebugMode) {
      log('_MainPageWidgetState | SiEkangToolbar.onPageChanged | isLibrary : $isLibrary');
    }
  }, onTextChanged: (String newText) {
    if (kDebugMode) {
      log('_MainPageWidgetState | SiEkangToolbar.onTextChanged | newText : $newText');
    }
    _updateLibraryList(newText);
  });

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

  final List<Widget> _widgetOptions = <Widget>[
    const HomeWidget(),
    LibraryWidget(),
    const NotificationWidget(),
    const ProfileWidget(),
  ];

  // Index variable used to navigate
  int _selectedIndex = 0;

  ///////////////////////////
  //
  // OVERRIDE
  //
  ///////////////////////////
  /*@override
  void initState() {
    super.initState();
    connectivityController.init();
  }*/

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: connectivityController.isConnected,
        builder: (context, value, child) {
          if (!value) {
            Fimber.e('Not connected');
          } else {
            Fimber.d('connected');
          }

          return SafeArea(
              child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(128.0), child: toolbar),
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
          ));
        });
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
    if (null != toolbarKey.currentState) {
      toolbarKey.currentState!.updateRoute(pageName!,
          Constants.libraryTitle == ModalRoute.of(context)?.settings.name);
    }
  }

  static void _updateLibraryList(String newText) {
    // Check state nullability
    if (null != libraryKey.currentState) {
      libraryKey.currentState!.onTextChanged(newText);
    }
  }
}
