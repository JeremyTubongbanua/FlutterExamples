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
