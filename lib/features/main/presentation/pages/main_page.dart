import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ekang_flutter/core/component/siekangtoolbar.dart';
import 'package:ekang_flutter/core/network/connectvity_controller.dart';
import 'package:ekang_flutter/core/utils/constants.dart';
import 'package:ekang_flutter/features/home/presentation/widgets/home_widget.dart';
import 'package:ekang_flutter/features/library/presentation/pages/library_page.dart';
import 'package:ekang_flutter/features/library/presentation/widgets/library_widget.dart';
import 'package:ekang_flutter/features/main/presentation/bloc/main_bloc.dart';
import 'package:ekang_flutter/features/notifications/presentation/widgets/notification_widget.dart';
import 'package:ekang_flutter/features/profile/presentation/widgets/profile_widget.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
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
    const LibraryWidget(),
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
            body: BlocBuilder<MainBloc, MainState>(
                buildWhen: (previous, current) =>
                    previous.idSelected != current.idSelected,
                builder: (context, state) {
                  switch (state.idSelected) {
                    case 0:
                      {
                        if (kDebugMode) {
                          Fimber.d(
                              '_MainPage | BlocBuilder | state is HomeState');
                        }
                      }
                      break;
                    case 1:
                      {
                        if (kDebugMode) {
                          Fimber.d(
                              '_MainPage | BlocBuilder | state is LibraryState');
                        }
                      }
                      break;
                    case 2:
                      {
                        if (kDebugMode) {
                          Fimber.d(
                              '_MainPage | BlocBuilder | state is NotificationState');
                        }
                      }
                      break;
                    case 3:
                      {
                        if (kDebugMode) {
                          Fimber.d(
                              '_MainPage | BlocBuilder | state is ProfileState');
                        }
                      }
                      break;
                    default:
                      {
                        if (kDebugMode) {
                          Fimber.e(
                              '_MainPage | BlocBuilder | default case | $state');
                        }
                      }
                      break;
                  }
                  return Center(
                    child: _widgetOptions.elementAt(_selectedIndex),
                  );
                }),
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

    // Update MainBloc state
    context.read<MainBloc>().add(SelectCategory(idSelected: _selectedIndex));
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
