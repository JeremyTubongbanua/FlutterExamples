import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './auth_card.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: AuthCard(),
      ),
    );
  }
}
