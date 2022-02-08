import 'package:flutter/material.dart';

class TabScreen extends StatelessWidget {
  final int number;

  const TabScreen(this.number);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('This is Tab #${number}')),
    );
  }
}
