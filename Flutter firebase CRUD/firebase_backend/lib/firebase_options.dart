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
        return macos;
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
    apiKey: 'AIzaSyDRrEAWhVCC8X31JHAJVRWmLIIrX-9xTJU',
    appId: '1:514155189187:web:37d75843541cca9e1e2376',
    messagingSenderId: '514155189187',
    projectId: 'testing-cli-5de77',
    authDomain: 'testing-cli-5de77.firebaseapp.com',
    storageBucket: 'testing-cli-5de77.appspot.com',
    measurementId: 'G-HX72D1ZLMH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdV4Xbd7t7_hFvtSCBoMfuZRdd_8HE7ts',
    appId: '1:514155189187:android:315412d2a863e27b1e2376',
    messagingSenderId: '514155189187',
    projectId: 'testing-cli-5de77',
    storageBucket: 'testing-cli-5de77.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3reYkady-NOlCH9bWMZZeXovKbCM6lxo',
    appId: '1:514155189187:ios:769f86114de6c48e1e2376',
    messagingSenderId: '514155189187',
    projectId: 'testing-cli-5de77',
    storageBucket: 'testing-cli-5de77.appspot.com',
    iosBundleId: 'com.example.firebaseBackend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA3reYkady-NOlCH9bWMZZeXovKbCM6lxo',
    appId: '1:514155189187:ios:093ab0518163826b1e2376',
    messagingSenderId: '514155189187',
    projectId: 'testing-cli-5de77',
    storageBucket: 'testing-cli-5de77.appspot.com',
    iosBundleId: 'com.example.firebaseBackend.RunnerTests',
  );
}
