import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ekang_flutter/core/network/connectvity_controller.dart';
import 'package:ekang_flutter/core/ui/snackbar_manager.dart';
import 'package:ekang_flutter/core/utils/app_lifecycle_reactor.dart';
import 'package:ekang_flutter/core/utils/constants.dart';
import 'package:ekang_flutter/core/widgets/ads/ads_widget.dart';
import 'package:ekang_flutter/core/widgets/ads/app_open_ad_manager.dart';
import 'package:ekang_flutter/features/home/home.dart';
import 'package:ekang_flutter/features/library/library.dart';
import 'package:ekang_flutter/features/main/presentation/bloc/main_bloc.dart';
import 'package:ekang_flutter/features/main/presentation/widgets/main_bottom_navigation_bar.dart';
import 'package:ekang_flutter/features/main/presentation/widgets/main_content_widget.dart';
import 'package:ekang_flutter/features/notifications/notifications.dart';
import 'package:ekang_flutter/features/settings/settings.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  ConnectivityController connectivityController = ConnectivityController();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  late AppLifecycleReactor _appLifecycleReactor;
  late AppOpenAdManager _appOpenAdManager;

  ///////////////////////////
  // Widgets
  ///////////////////////////
  static const List<BottomNavigationBarItem> _bottomNavigationList =
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

  final List<Widget> _pagesOptions = <Widget>[
    const HomePage(),
    const LibraryPage(),
    const NotificationPage(),
    const SettingsPage(),
  ];

  // Index variable used to navigate
  int _selectedIndex = 0;

  ///////////////////////////
  //
  // OVERRIDE
  //
  ///////////////////////////
  @override
  void initState() {
    super.initState();
    connectivityController.init();

    _appOpenAdManager = AppOpenAdManager();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: _appOpenAdManager);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Fimber.d("didChangeDependencies()");
  }

  @override
  void didUpdateWidget(covariant MainWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    Fimber.d("didUpdateWidget()");
  }

  @override
  Widget build(BuildContext context) {
    String networkStatusMessage;

    return ValueListenableBuilder(
      valueListenable: connectivityController.isConnected,
      builder: (context, value, child) {
        if (!value) {
          networkStatusMessage = "No Internet Connection";
          Fimber.e(
              "ValueListenableBuilder | network status message : $networkStatusMessage");
          SnackBarManager().showErrorSnackBar(
            message: networkStatusMessage,
            context: context,
          );
        } else {
          networkStatusMessage = "Connected to internet";
          Fimber.i(
              "ValueListenableBuilder | network status message : $networkStatusMessage");
          SnackBarManager().showSuccessSnackBar(
            message: networkStatusMessage,
            context: context,
          );
        }

        return SafeArea(
            child: Scaffold(
          body: BlocConsumer<MainBloc, MainState>(
            listener: (context, state) {
              if (kDebugMode) {
                Fimber.d("build | BlocConsumer | state: $state");
              }
            },
            builder: (context, state) {
              return MainContentWidget(currentIndex: state.idSelected);
            },
          ),
          bottomNavigationBar: BlocConsumer<MainBloc, MainState>(
            listener: (context, state) {
              if (kDebugMode) {
                Fimber.d("build | BlocConsumer | state: $state");
              }
            },
            builder: (context, state) {
              return MainBottomNavigationBarWidget(
                  selectedIndex: state.idSelected,
                  onNavigationItemSelected: (itemIndex) {
                    if (state.idSelected == itemIndex) {
                      Fimber.w(
                          "build | BlocConsumer | MainBottomNavigationBarWidget.onNavigationItemSelected | Nav bottom item already selected. No need to select it again.");
                      return;
                    }

                    // Update MainBloc state
                    context
                        .read<MainBloc>()
                        .add(SelectCategory(idSelected: itemIndex));
                  });
            },
          ),
        ));
      },
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    connectivityController.stopSubscription();
    super.dispose();
  }

  ///////////////////////////
  //
  // CLASS METHODS
  //
  ///////////////////////////

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = (await _connectivity.checkConnectivity()) as ConnectivityResult;
    } on PlatformException catch (error, stacktrace) {
      if (kDebugMode) {
        Fimber.e(
            "initConnectivity() | Couldn\'t check connectivity status. Error: $error (stacktrace: ${stacktrace.toString()})");
      }
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
      Fimber.d("_updateConnectionStatus() | result : $result");
      _connectionStatus = result;
    });
  }

  static void _updateLibraryList(String newText) {
    // Check state nullability
    if (null != libraryKey.currentState) {
      libraryKey.currentState!.onTextChanged(newText);
    }
  }
}
