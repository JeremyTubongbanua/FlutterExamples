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

### Example (5) Cloud Firestore

See lib/firebase_examples/firebase_cloud_firestore/ \

Dependencies:

1. Configure FlutterFire (See FlutterFire Setup)
2. `flutter pub add firebase_core`
3. `flutter pub add cloud_Firestore`

Tips:

-   Access instance through `FirebaseFirestore.instance`
-   Collections hold documents
-   Documents hold field-value pairs and hold collections
-   https://firebase.flutter.dev/docs/firestore/usage#document--query-snapshots (TODO)

Instructions:

1. Initialize Firebase`Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);`
2. Set (removes other data in the document):

```dart
final Map<String, dynamic> data = {'field': 'value'};
await FirebaseFirestore.instance
    .collection('collectionId')
    .doc('documentId')
    .set(data);
```

3. Update (does not remove other data in the document):

```dart
final Map<String, dynamic> data = {'field': 'value', 'lemon': 5};
await FirebaseFirestore.instance
    .collection('collectionId')
    .doc('documentId')
    .update(data);
```

4. Get:

```dart
final documentSnapshot = await FirebaseFirestore.instance.collection('users').doc('user1').get();
print(documentSnapshot.data()); // {lemon: 5, test: 3}
```

5. Add:

-   creates collection (if necessary)
-   creates document with auto-id

```dart
await FirebaseFirestore.instance.collection('poopy').add({'test': 3})
```

6. StreamBuilder + Snapshots:
   Sample: users (collection) > x23mark (document) >

```dart
StreamBuilder(
    stream: FirebaseFirestore.instance.collection('users').snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return const Text('Snapshot has error?');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());

      return ListView(
        children: snapshot.data!.docs
            .map((DocumentSnapshot document) => ListTile(
                  title: Text(document.data().toString()),
                ))
            .toList(),
      );
    },
),
```

7. FutureBuilder (TODO)
   https://firebase.flutter.dev/docs/firestore/usage#one-time-read

8. Checking if a document exists:

```dart
final CollectionReference collection = await FirebaseFirestore.instance.collection('users'); // get collection reference
final DocumentReference document = collection.doc('x23mark'); // get document reference
final DocumentSnapshot snapshot = await document.get(); // get snapshot
final bool hasData = snapshot.data() != null; // hasData ?
```

9. Getting document data:

```dart
final CollectionReference collection = await FirebaseFirestore.instance.collection('users'); // get collection reference
final DocumentReference document = collection.doc('x23mark'); // get document reference
final DocumentSnapshot snapshot = await document.get(); // get document snapshot
final Object? data = snapshot.data()?; // get nullable Object
print(data); // {nickname: jeremy}
```

10. Steps 8 and 10 together

```dart
final CollectionReference collection = await FirebaseFirestore.instance.collection(collectionIdcontroller.text);
final DocumentReference document = collection.doc(documentIdController.text);
final DocumentSnapshot snapshot = await document.get();
final bool hasData = snapshot.data() != null;
if (hasData) {
  document.update({fieldController.text: valueController.text});
} else {
  document.set({fieldController.text: valueController.text});
}
```

![](https://i.imgur.com/okzutea.png) \
main_screen.dart

11. Converters (TODO)
    https://firebase.flutter.dev/docs/firestore/usage#typing-collectionreference-and-documentreference

12. Removing Data (TODO)
    https://firebase.flutter.dev/docs/firestore/usage#typing-collectionreference-and-documentreference

### Example (6) MultiProviders

See lib/other_examples/multi_provider/ \

Dependencies:

1. `$ flutter pub add provider`

Tips:

-   Providers are good for app-wide data
-   Provider flutter package makes life easy

Instructions:

1. Create a class that uses the `ChangeNotifier` mixin. (Use keyword `with` but `extends` works as well to get access to notifyListeners()). \
   Example:

```dart
import 'package:flutter/material.dart';

class CountProvider with ChangeNotifier {
 late int _currentCount;

 CountProvider() {
   _currentCount = 0;
 }

 void increment() {
   _currentCount += 1;
   notifyListeners();
 }

 void decrement() {
   _currentCount -= 1;
   notifyListeners();
 }

 int get currentCount {
   return _currentCount;
 }
}

```

2. Initialize Provider

```dart
final ChangeNotifierProvider<CountProvider> provider = ChagneNotifierProvider<CountProvider>(create: (context) => CountProvider());
```

3. a) Shove it into the MultiProvider \
   `app` is a MaterialApp.

```dart
final MultiProvider providers = MultiProvider(providers: [provider], child: app);
```

3. b) Use a singular provider \
   `app` is a MaterialApp.

```dart
final ChangeNotifierProvider<CountProvider> provider = ChagneNotifierProvider<CountProvider>(create: (context) => CountProvider(), child: app);
```

4. Call `runApp(providers)` (or `runApp(provider) for 3b).

5. Use `ChangeNotifierProvider.value(...)` for Provider classes that are instantiated frequently.

### Example (7) Fonts

See `lib/other_examples/fonts/`

Instructions:

1. Add font files to project. See `lib/other_examples/fonts/assets/` for font file examples.
2. Register fonts into `pubspec.yaml` accordingly. (\*font weight is findable via the place you downloaded the font).

```yaml
fonts:
    - family: Quicksand
      fonts:
          - asset: assets/fonts/Quicksand-Light.ttf
            weight: 300
          - asset: assets/fonts/Quicksand-Regular.ttf
            weight: 400
          - asset: assets/fonts/Quicksand-Medium.ttf
            weight: 500
          - asset: assets/fonts/Quicksand-Semibold.ttf
            weight: 600
          - asset: assets/fonts/Quicksand-Bold.ttf
            weight: 700
```
