import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCard extends StatefulWidget {
  const AuthCard();

  @override
  _AuthCardState createState() => _AuthCardState();
}

enum AuthMode { LOGIN, SIGN_UP }

class _AuthCardState extends State<AuthCard> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  AuthMode authMode = AuthMode.LOGIN;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: authMode == AuthMode.LOGIN ? 180 : 250,
        child: Column(
          children: [
            Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(label: Text('Email')),
                ),
                TextField(
                  controller: passController,
                  decoration: const InputDecoration(label: Text('Password')),
                  obscureText: true,
                ),
                if (authMode == AuthMode.SIGN_UP)
                  TextField(
                    controller: confirmPassController,
                    decoration: const InputDecoration(label: Text('Confirm Password')),
                    obscureText: true,
                  ),
              ],
            ),
            Column(
              children: [
                TextButton(
                  // Login/SignUp button
                  onPressed: () async {
                    try {
                      if (authMode == AuthMode.LOGIN) {
                        // Login
                        await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passController.text);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successful!')));
                      } else {
                        if (passController.text != confirmPassController.text) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords don\'t match')));
                          return;
                        }
                        if (passController.text.length < 3) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password length must be >= 3')));
                          return;
                        }

                        // Sign Up
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passController.text);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign Up successful!')));
                      }
                    } catch (error) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
                    }
                  },
                  child: Text(authMode == AuthMode.LOGIN ? 'Login' : 'Sign Up'),
                ),
                TextButton(
                  // CreateAnAccount/LoginInstead button
                  onPressed: () => setState(() => authMode == AuthMode.LOGIN ? authMode = AuthMode.SIGN_UP : authMode = AuthMode.LOGIN),
                  child: Text(authMode == AuthMode.LOGIN ? 'Create An Account' : 'Login Instead'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
