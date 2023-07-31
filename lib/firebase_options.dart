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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBqbQRIEBx4isn9IDmqbVTVp3OP3bfSk10',
    appId: '1:27975256039:android:926a616bd5017d50995f42',
    messagingSenderId: '27975256039',
    projectId: 'ecommerce-bbcf0',
    databaseURL: 'https://ecommerce-bbcf0-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'ecommerce-bbcf0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA40aY0lADdDIowHksFUxif6-tzD0m3Q3Q',
    appId: '1:27975256039:ios:936ec1b501bdf607995f42',
    messagingSenderId: '27975256039',
    projectId: 'ecommerce-bbcf0',
    databaseURL: 'https://ecommerce-bbcf0-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'ecommerce-bbcf0.appspot.com',
    androidClientId: '27975256039-npeg9gcc6icasabotqqd6miljbgimqqn.apps.googleusercontent.com',
    iosClientId: '27975256039-c8k3fimu4udlt3u55kvo58pb04g391g9.apps.googleusercontent.com',
    iosBundleId: 'com.alisayar.ecommerce',
  );
}