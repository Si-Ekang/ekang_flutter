// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD5Ms95gA81EvH6ZTj3qWS4Xkv6ecDlw5k',
    appId: '1:473333502274:web:50e40464a7678ee9bf38db',
    messagingSenderId: '473333502274',
    projectId: 'siekang',
    authDomain: 'siekang.firebaseapp.com',
    storageBucket: 'siekang.appspot.com',
    measurementId: 'G-5T08FR29BK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAz3Jio5eh-J2BJCvBu1e3Sm7wMeJCR8EY',
    appId: '1:473333502274:android:57d7d02bb153f131bf38db',
    messagingSenderId: '473333502274',
    projectId: 'siekang',
    storageBucket: 'siekang.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXavBZYgzmXOgoFJhBPIkQf4q4efc2vCs',
    appId: '1:473333502274:ios:0ea42ace19728202bf38db',
    messagingSenderId: '473333502274',
    projectId: 'siekang',
    storageBucket: 'siekang.appspot.com',
    iosBundleId: 'com.siekang.ekangFlutter',
  );
}
