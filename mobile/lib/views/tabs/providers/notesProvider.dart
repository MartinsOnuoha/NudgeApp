import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nudge/models/studentModel.dart';

class NotesProvider extends ChangeNotifier {
  StudentModel studentModel;

  var notesLength = 0;
  var importantNotesLength = 0;

  updater() async {
    notesLength = (await Firestore.instance
            .collection('student')
            .document(studentModel?.reference?.documentID ?? studentModel?.studentID)
            .collection('notes')
            .getDocuments())
        .documents
        .length;
    importantNotesLength = (await Firestore.instance
            .collection('student')
            .document(studentModel?.reference?.documentID ?? studentModel?.studentID)
            .collection('notes')
            .where('isImportant', isEqualTo: true)
            .getDocuments())
        .documents
        .length;
        notifyListeners();
  }

  Stream<QuerySnapshot> notesList() {
    return Firestore.instance
        .collection('student')
        .document(studentModel?.reference?.documentID ?? studentModel?.studentID)
        .collection('notes')
        .orderBy('timeStamp', descending:true)
        .snapshots();
  }

  int _tab = 0;
  int get tab => _tab;

  set tab(int v) {
    _tab = v;
    notifyListeners();
  }
}
