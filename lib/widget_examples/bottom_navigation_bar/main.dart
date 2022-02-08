import 'package:flutter/material.dart';
import './tabs_screen.dart';

void main() {
  final MaterialApp app = MaterialApp(
    routes: {
      '/': (ctx) => TabsScreen(), // root
    },
  );
  runApp(app);
}
