import 'package:flutter/material.dart';
import './snackbar_util.dart';

class SamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Snack Bar Example'),
              onPressed: () {
                snackBarMessage(context, 'This is a snackbar example!');
              },
            ),
            ElevatedButton(
              child: const Text('Snack Bar Example with Button'),
              onPressed: () {
                snackBarMessageWithButton(context, 'This is a snackbar example!', 'UNDO', () => ScaffoldMessenger.of(context).hideCurrentSnackBar());
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  final MaterialApp app = MaterialApp(
    home: SamplePage(),
  );
  runApp(app);
}
