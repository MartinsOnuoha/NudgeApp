import 'package:flutter/material.dart';
import 'package:nudge/views/tabs/calendar.dart';
import 'package:nudge/views/tabs/home.dart';

class ControllerProvider extends ChangeNotifier {
  final currentTab = [
    Home(),
    Home(),
    Calendar(),
    Home(),
    Home(),
  ];

  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
