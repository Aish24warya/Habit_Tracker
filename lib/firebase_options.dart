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
    apiKey: 'AIzaSyDpoxbw9SgokEVEz0GFRMoIyrY2hoYqmIM',
    appId: '1:744962166881:web:c917dc317942cd1539da20',
    messagingSenderId: '744962166881',
    projectId: 'habittracker-b6061',
    authDomain: 'habittracker-b6061.firebaseapp.com',
    storageBucket: 'habittracker-b6061.appspot.com',
    measurementId: 'G-BBN55SXD3F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC38ZpKGk36HgFRAHgsvm9H12WUivmmd8I',
    appId: '1:744962166881:android:c332eff41d7c723939da20',
    messagingSenderId: '744962166881',
    projectId: 'habittracker-b6061',
    storageBucket: 'habittracker-b6061.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAH9WTCYuLmJp3OWigV_C3MQ65lnvj4p4w',
    appId: '1:744962166881:ios:29868753fb81cd5939da20',
    messagingSenderId: '744962166881',
    projectId: 'habittracker-b6061',
    storageBucket: 'habittracker-b6061.appspot.com',
    iosBundleId: 'com.SystemicAltruism.habittrackerapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAH9WTCYuLmJp3OWigV_C3MQ65lnvj4p4w',
    appId: '1:744962166881:ios:29868753fb81cd5939da20',
    messagingSenderId: '744962166881',
    projectId: 'habittracker-b6061',
    storageBucket: 'habittracker-b6061.appspot.com',
    iosBundleId: 'com.SystemicAltruism.habittrackerapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDpoxbw9SgokEVEz0GFRMoIyrY2hoYqmIM',
    appId: '1:744962166881:web:3e1d758049f83b2939da20',
    messagingSenderId: '744962166881',
    projectId: 'habittracker-b6061',
    authDomain: 'habittracker-b6061.firebaseapp.com',
    storageBucket: 'habittracker-b6061.appspot.com',
    measurementId: 'G-X7T3QBVFXC',
  );
}
