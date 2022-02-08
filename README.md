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

### Example (1) Firebase Auth

See lib/firebase_examples/firebase_auth/ \
Dependencies:

1. Configure FlutterFire (See FlutterFire Setup)
2. `flutter pub add firebase_core`
3. `flutter pub add firebase_auth`

Instructions:

1. Initialize Firebase before you runApp(): `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);`
2. Sign-In: `await FirebaseAuth.instance.signInWithEmailAndPassword(email: 'jeremy.tubongbanua@gmail.com', password: 'lemon1234');`
3. Create: `await FirebaseAuth.instance.createUserWithEmailAndPassword(email: 'jeremy.tubongbanua@gmail.com', password: 'lemon1234');`

![](https://i.imgur.com/KaB9HtH.png) \
auth_card.dart

### Example (2) Snackbar

See lib/widget_examples/snackbar/ \
Method examples: lib/widget_examples/snackbar/snackbar_util.dart \
Raw Example:

```dart
ScaffoldMessenger.of(context).hideCurrentSnackBar();
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
```

![](https://i.imgur.com/Ky7hnzu.png) \
snackbar_util.dart

### Example (3) Drawer

See lib/widget_examples/drawer/ \
Template: lib/widget_examples/drawer/drawer.dart \
Raw Example:

```dart
Scaffold(
    drawer: Drawer(...) // see template: lib/widget_examples/drawer/drawer.dart
)
```

![](https://i.imgur.com/1dwMjxE.png) \
drawer.dart

### Example (4) Bottom Navigation Bar

See lib/widget_examples/bottom_navigation_bar/ \
Tabs Screen template: lib/widget_examples/bottom_navigation_bar/tabs_screen.dart \
Raw Example:

```dart
Scaffold(
    bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // 0 <= x <= items.length;
        items: [/* ... Insert Widgets ...*/],
        onTap: () {
            setState((index) {
                _currentIndex = index;
            });
        }
    )
)
```

![](https://i.imgur.com/usXxrj7.png) \
tab_screen.dart
