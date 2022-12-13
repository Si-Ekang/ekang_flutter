import 'package:ekang_flutter/ui/splashscreen/splashscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const SiEkangApp());

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
