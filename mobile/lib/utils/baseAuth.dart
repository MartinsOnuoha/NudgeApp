import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nudge/models/studentModel.dart';


abstract class BaseAuth {
  Future<FirebaseUser> signIn(String email, String password);
  Future<FirebaseUser> signUp(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<void> signOut(context);
  Future<void> resetPassword(email, context);
  Future<StudentModel> getStudentProfileData(String userID);

  void updateStudentData({
    @required String name,
    @required String surname,
    @required String year,
    @required String department,
    @required String email,
    @required String regNo,
    @required FacultyModel faculty,
  });
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user;
  }

  Future<FirebaseUser> signUp(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut(context) async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Password Reset"),
              content: new Text("Password Reset Email Sent"),
            ));
    return _firebaseAuth.signOut();
  }

  Future<void> resetPassword(email, context) async {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Password Reset"),
              content: new Text("Password Reset Email Sent"),
            ));

    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<StudentModel> getStudentProfileData(userID) async {
    var querySnapshot = await Firestore.instance
        .collection("assistants")
        .document('$userID')
        .get();

    return (querySnapshot.data != null)
        ? StudentModel.fromSnapshot(querySnapshot)
        : null;
  }

  void updateStudentData({
    @required String name,
    @required String surname,
    @required String year,
    @required String department,
    @required String email,
    @required String regNo,
    @required FacultyModel faculty,
  }) async {
    FirebaseUser user = await getCurrentUser();
    UserUpdateInfo _updateInfo = UserUpdateInfo();
    _updateInfo.displayName = '$surname $name';
    user.updateProfile(_updateInfo);

  try {
 

    await Firestore.instance
        .collection('student')
        .document('${user.uid}')
        .updateData(
      {
        'first_name': '$name ',
        'last_name':'$surname',
        'email': '$email',
        'reg_no': '$regNo',
        'year': '$year',
        'department': '$department',
        'faculty': faculty.toJson(),
        'is_online': false,
      },
    );
    
  } catch (e) {
    print(e.toString());
  }
  }

}
