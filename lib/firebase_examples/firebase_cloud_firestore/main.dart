import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_examples/firebase_examples/firebase_auth/firebase_options.dart';
import './main_screen.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final MaterialApp app = MaterialApp(
    routes: {MainScreen.routeName: (ctx) => const MainScreen()},
  );
  runApp(app);
}
