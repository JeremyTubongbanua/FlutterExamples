import 'package:flutter/material.dart';

void snackBarMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

void snackBarMessageWithButton(BuildContext context, String message, String buttonName, void Function() function) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: buttonName,
      onPressed: function,
    ),
  ));
}
