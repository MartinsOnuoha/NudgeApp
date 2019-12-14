import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nudge/models/studentModel.dart';

class CalendarProvider extends ChangeNotifier {
  StudentModel studentModel;

  String day = DateFormat("E").format(DateTime.now()).toUpperCase();

  DateTime currentDate = DateTime.now();

  Stream<QuerySnapshot> classList() {
    return Firestore.instance
        .collection('classes')
        .document(studentModel?.classID ?? '')
        .collection('timetable')
        .orderBy('startTime')
        .snapshots();
  }

  valueUpdate(val) {
    currentDate = val;
    day = DateFormat("E").format(val).toUpperCase();
    notifyListeners();
  }

  void persistData(context) {}
}
