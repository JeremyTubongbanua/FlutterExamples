# FlutterExamples

Flutter examples for personal use of widget templates, firebase use examples, providers, and more!

## FlutterFire Setup

FlutterFire is a set of Flutter plugins which connect your Flutter application to Firebase (https://firebase.flutter.dev/docs/overview/)

1. Install Firebase CLI (https://firebase.google.com/docs/cli#install-cli-windows)
2. Install FlutterFire CLI `dart pub global activate flutterfire_cli`
3. Run `flutterfire configure` in your project root directory <<< Step (1) if you've done this before
4. Do the configuration (remove iOS if you want)
5. You should have `firebase_options.dart` inside lib/
6. Get firebase_core `flutter pub add firebase_core` (needed dependency in `firebase_options.dart`) (You should have `generated_plugin_registrant.dart` as well) Step (2)
7. Call `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);` before starting the app <<< Step (3)

### Cloud Firestore
