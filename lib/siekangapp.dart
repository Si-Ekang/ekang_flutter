/*import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';*/
import 'package:adaptive_theme/adaptive_theme.dart' as theme;
import 'package:ekang_flutter/core/router/routes.dart' as siekang_router;
import 'package:ekang_flutter/core/widgets/widgets.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'firebase_options.dart';

// TODO : Implement Authentication
// TODO : Implement IndexedStack widget
// TODO : Implement Toolbar in page directly
// TODO : Refactor whole project with clean architecture + bloc pattern

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

String _FIREBASE_APPCHECK_DEBUG_TOKEN = "46AB866D-BDAE-49D5-B852-0FF8BDAD6819";

void main() {
  if (kDebugMode) {
    Fimber.plantTree(DebugTree(useColors: true));
  }

  initPlugins();
  initFirebase();
  initMobileAds();

  Fimber.d("main() | SiEkangApp successfully initialized");

  runApp(const SiEkangApp());
}

void initPlugins() {
  // required when using any plugin. In our case, it's shared_preferences
  WidgetsFlutterBinding.ensureInitialized();
}

void initFirebase() async {
  // Initialize Firebase App
  await Firebase.initializeApp(
    name: "SiEkang",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Firebase Crashlytics
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

  await FirebaseAppCheck.instance
      .activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  )
      .then((value) {
    Fimber.i("initFirebase() | value");

    FirebaseAuth.instance.signInAnonymously();
  }, onError: (error) {
    Fimber.e("initFirebase() | error : ${error.toString()}");
  });
}

void initMobileAds() {
  MobileAds.instance.initialize();
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
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    // TextTheme textTheme = Theme.of(context).textTheme;
    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    final _siEkangTheme = SiEkangTheme(textTheme);

    return SiEkangAppWidget(
      child: Builder(builder: (context) {
        return theme.AdaptiveTheme(
            debugShowFloatingThemeButton: false,
            light: _siEkangTheme.light(),
            dark: _siEkangTheme.dark(),
            initial: theme.AdaptiveThemeMode.light,
            builder: (theme, darkTheme) => MaterialApp(
                  navigatorObservers: [routeObserver],
                  debugShowCheckedModeBanner: false,
                  title: "SiEkang",
                  // title: SiEkangAppWidget.of(context)?.values.appName ?? "Should show SiEkang App Name",
                  theme: theme,
                  darkTheme: darkTheme,
                  onGenerateRoute: siekang_router.Router.generateRoute,
                  /*localizationsDelegates: const [
                    AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en'), // English
                    Locale('fr'), // french
                  ],*/
                ));
      }),
    );
  }
}
