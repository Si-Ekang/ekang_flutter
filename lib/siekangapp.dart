import 'package:ekang_flutter/features/splashcreen/splashscreen.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

// TODO : Implement Authentication

void main() {
  if (kDebugMode) {
    Fimber.plantTree(DebugTree(useColors: true));
  }

  initPlugins();
  initFirebase();

  runApp(const SiEkangApp());
}

void initPlugins() {
  // required when using any plugin. In our case, it's shared_preferences
  WidgetsFlutterBinding.ensureInitialized();
}

void initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FirebaseCrashlytics.instance.setUserIdentifier('mike_dev');

  // Pass all uncaught errors from the framework to Crashlytics.
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

class SiEkangApp extends StatefulWidget {
  const SiEkangApp({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<SiEkangApp> createState() => _SiEkangAppState();
}

class _SiEkangAppState extends State<SiEkangApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
