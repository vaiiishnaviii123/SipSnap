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
    apiKey: 'AIzaSyAL7Gkj5H1afOckXR6KQe_aCCzzdsPtvMQ',
    appId: '1:198417524006:web:a57c9eaac71e9486640de7',
    messagingSenderId: '198417524006',
    projectId: 'sipsnap',
    authDomain: 'sipsnap.firebaseapp.com',
    storageBucket: 'sipsnap.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDdMrhLVR_K0Ahn__Rm91yPKn0VKX7q0GY',
    appId: '1:198417524006:android:f80242784655148d640de7',
    messagingSenderId: '198417524006',
    projectId: 'sipsnap',
    storageBucket: 'sipsnap.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXJHc6bSDvJ7MSOSDkxHmpV3oe3usPYio',
    appId: '1:198417524006:ios:fa86831b7fe47865640de7',
    messagingSenderId: '198417524006',
    projectId: 'sipsnap',
    storageBucket: 'sipsnap.appspot.com',
    androidClientId: '198417524006-6lnmdhjrkl42lg1f30mkn4drvercs957.apps.googleusercontent.com',
    iosClientId: '198417524006-i723iv895gp45t23g4fqqf6o7jesbq6n.apps.googleusercontent.com',
    iosBundleId: 'com.example.sipsnap',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBXJHc6bSDvJ7MSOSDkxHmpV3oe3usPYio',
    appId: '1:198417524006:ios:3faa0c7e51f5d878640de7',
    messagingSenderId: '198417524006',
    projectId: 'sipsnap',
    storageBucket: 'sipsnap.appspot.com',
    androidClientId: '198417524006-6lnmdhjrkl42lg1f30mkn4drvercs957.apps.googleusercontent.com',
    iosClientId: '198417524006-7uvf99duir4q0ur97mf0di4o6pl9qatn.apps.googleusercontent.com',
    iosBundleId: 'com.example.sipsnap.RunnerTests',
  );
}
