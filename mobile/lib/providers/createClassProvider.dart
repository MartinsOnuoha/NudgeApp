import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/utils/baseAuth.dart';
import 'package:nudge/utils/fade_route.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/views/controller.dart';

class CreateClassProvider extends ChangeNotifier {
  final TextEditingController currentLevelTEC = new TextEditingController();
  final TextEditingController schoolTEC = new TextEditingController();
  final TextEditingController deptTEC = new TextEditingController();

  var formKey = GlobalKey<FormState>();
  BaseAuth auth = new Auth();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  StudentModel _studentModel;
  StudentModel get studentModel => _studentModel;

  set studentModel(StudentModel val) {
    _studentModel = val;
    notifyListeners();
  }

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void initState(context) async {
    try {
      await showCupertinoDialog(
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActionSheet(
              cancelButton: CupertinoButton(
                color: Colors.transparent,
                child: Text(
                  'No I don\'t Agree',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.redAccent,
                      fontFamily: 'GalanoGrotesque2',
                      fontWeight: FontWeight.w200),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                CupertinoButton(
                  child: Text(
                    'Agree & Continue',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontFamily: 'GalanoGrotesque2',
                        fontWeight: FontWeight.w200),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
              message: Text(
                'You\'re about to create a new department and as such will be automatically assigned the role of a Class Representative',
                style: TextStyle(
                    fontSize: 16,
                    color: black,
                    fontFamily: 'GalanoGrotesque2',
                    fontWeight: FontWeight.w200),
              ),
            ),
          );
        },
        context: context,
      );

      var user = await auth.getCurrentUser();
      if (user != null) {
        _studentModel = await auth.getStudentProfileData(user.uid);
        notifyListeners();
        if (studentModel != null) {
          currentLevelTEC.text = _studentModel.year;
          schoolTEC.text = _studentModel.school;
          notifyListeners();
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  createDept(context) async {
    try {
      if (formKey.currentState.validate()) {
        _isLoading = true;
        notifyListeners();

        var user = await auth.getCurrentUser();
        if (user != null && _studentModel != null) {
          await Firestore.instance.collection('classes').add(
            {
              'university': _studentModel.school,
              'year': _studentModel.year,
              'department': deptTEC.text
            },
          ).then((value) async {
            if (value != null) {
              var deps =
                  await Firestore.instance.collection('depts').getDocuments();

              await Firestore.instance.collection('depts').add(
                {
                  'name': deptTEC.text,
                  'id': deps.documents.length + 1,
                },
              );
              await Firestore.instance
                  .collection('student')
                  .document('${user.uid}')
                  .updateData(
                {
                  'department': deptTEC.text,
                  'is_admin': true,
                  'class_id': value.documentID,
                },
              ).then((value) async {
                _studentModel = await auth.getStudentProfileData(user.uid);
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                  FadeRoute(
                    builder: (context) => Controller(
                      studentModel: _studentModel,
                    ),
                  ),
                );
              });
            }
          });
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
