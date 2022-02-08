import 'package:flutter/material.dart';
import 'drawer.dart';

void main() {
  final MaterialApp app = MaterialApp(
    home: Scaffold(
      appBar: AppBar(),
      drawer: const DrawerExample(),
    ),
  );
  runApp(app);
}
