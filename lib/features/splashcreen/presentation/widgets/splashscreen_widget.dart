import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:ekang_flutter/features/main/presentation/pages/main_page.dart';
import 'package:ekang_flutter/generated/assets.dart';
import 'package:fimber/fimber.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<SplashScreenWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 2500), () {
        if (mounted) {
          // Here you can write your code for open new view
          Navigator.of(context).pushReplacementNamed( MainPage.routeName);
          /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
          );*/
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const SafeArea(
        child: Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Text(
              'This is a splashcreen',
            ),*/
            Image(
                image: AssetImage(Assets.imagesSiEkangLogo),
                width: 120,
                height: 96),
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    Fimber.e("dispose()");
    super.dispose();
  }
}
