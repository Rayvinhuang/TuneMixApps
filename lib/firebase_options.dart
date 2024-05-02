// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyBBsiAWeGo9HapnrS5ceKPXuJvGL2eaAfU',
    appId: '1:1078918469373:web:6473b2349ef8bb02b69094',
    messagingSenderId: '1078918469373',
    projectId: 'tunemix-e7687',
    authDomain: 'tunemix-e7687.firebaseapp.com',
    databaseURL: 'https://tunemix-e7687-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'tunemix-e7687.appspot.com',
    measurementId: 'G-F3WLEVBST9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2dnbxw-atiKLfQ0hgjcdVBQj3iXxebJc',
    appId: '1:1078918469373:android:5c031b4657ec42f5b69094',
    messagingSenderId: '1078918469373',
    projectId: 'tunemix-e7687',
    databaseURL: 'https://tunemix-e7687-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'tunemix-e7687.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNCH9g6Or32u66roYOSTpuR4OqcbjWY5U',
    appId: '1:1078918469373:ios:f395f8cecab1eb0db69094',
    messagingSenderId: '1078918469373',
    projectId: 'tunemix-e7687',
    databaseURL: 'https://tunemix-e7687-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'tunemix-e7687.appspot.com',
    iosBundleId: 'com.example.tunemixApps',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDNCH9g6Or32u66roYOSTpuR4OqcbjWY5U',
    appId: '1:1078918469373:ios:f395f8cecab1eb0db69094',
    messagingSenderId: '1078918469373',
    projectId: 'tunemix-e7687',
    databaseURL: 'https://tunemix-e7687-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'tunemix-e7687.appspot.com',
    iosBundleId: 'com.example.tunemixApps',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBBsiAWeGo9HapnrS5ceKPXuJvGL2eaAfU',
    appId: '1:1078918469373:web:35dca542257c66b4b69094',
    messagingSenderId: '1078918469373',
    projectId: 'tunemix-e7687',
    authDomain: 'tunemix-e7687.firebaseapp.com',
    databaseURL: 'https://tunemix-e7687-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'tunemix-e7687.appspot.com',
    measurementId: 'G-QN0SFBGE1X',
  );

}