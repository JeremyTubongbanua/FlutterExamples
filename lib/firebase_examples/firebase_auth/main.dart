import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './firebase_options.dart';
import './auth_screen.dart';

void main() {
  final MaterialApp app = MaterialApp(
    routes: {
      '/': (ctx) => AuthScreen(),
    },
  );
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(app);
}
