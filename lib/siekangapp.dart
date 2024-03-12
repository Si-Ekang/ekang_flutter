import 'package:ekang_flutter/ui/splashscreen/splashscreen.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// TODO: Add Firebase support
// TODO : Implement Authentication

Future<void> main() async {
  if (kDebugMode) {
    Fimber.plantTree(DebugTree(useColors: true));
  }

  // required when using any plugin. In our case, it's shared_preferences
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SiEkangApp());
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
