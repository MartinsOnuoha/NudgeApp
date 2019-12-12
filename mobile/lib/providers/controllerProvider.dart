import 'package:flutter/material.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/views/tabs/calendar.dart';
import 'package:nudge/views/tabs/home.dart';

class ControllerProvider extends ChangeNotifier {
  currentTab(val) => [
        Home(studentModel: val),
        Home(studentModel: val),
        Calendar(),
        Home(studentModel: val),
        Home(studentModel: val),
      ];

  StudentModel _studentModel;
  StudentModel get studentModel => _studentModel;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  set studentModel(StudentModel val) {
    _studentModel = val;
    notifyListeners();
  }

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
