import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nudge/chat/views/ChatScreen.dart';
import 'package:nudge/models/studentClassModel.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/utils/baseAuth.dart';
import 'package:nudge/views/tabs/calendar.dart';
import 'package:nudge/views/tabs/home.dart';
import 'package:nudge/views/tabs/notes.dart';
import 'package:nudge/views/tabs/profile.dart';

class ControllerProvider extends ChangeNotifier {
  BaseAuth auth = new Auth();

  StudentModel _studentModel;
  StudentModel get studentModel => _studentModel;

  StudentsClassModel _studentsClassModel;
  StudentsClassModel get studentsClassModel => _studentsClassModel;

  currentTab() => [
        Home(studentModel: _studentModel),
        Profile(studentModel: _studentModel),
        Calendar(studentModel: _studentModel),
        Notes(studentModel: _studentModel),
        ChatScreen(
          sender: _studentModel,
          studentsClassModel: _studentsClassModel,
          reference: FirebaseDatabase.instance
              .reference()
              .child('chats')
              .child(studentModel?.classID ?? 'm'),
        ),
      ];

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  set studentModel(StudentModel val) {
    _studentModel = val;
    notifyListeners();
  }

  set studentsClassModel(val) {
    _studentsClassModel = val;
    notifyListeners();
  }

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<StudentsClassModel> getClassProfileData() async {
    var querySnapshot = await Firestore.instance
        .collection('classes')
        .document(studentModel?.classID ?? 'm')
        .get();

    return (querySnapshot.data != null)
        ? StudentsClassModel.fromSnapshot(querySnapshot)
        : null;
  }

  loadUser() async {
    var user = await auth.getCurrentUser();
    _studentModel = await auth.getStudentProfileData(user.uid);
    _studentsClassModel = await getClassProfileData();

    notifyListeners();
  }
}
