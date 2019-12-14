import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nudge/models/deptModel.dart';
import 'package:nudge/utils/baseAuth.dart';
import 'package:nudge/utils/fade_route.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/views/controller.dart';

class UpdateDeptProvider extends ChangeNotifier {
  final TextEditingController searchTEC = new TextEditingController();
  BaseAuth auth = new Auth();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  var homeContext;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  Stream<QuerySnapshot> deptsList =
      Firestore.instance.collection('depts').orderBy('name').snapshots();

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  set isSearching(bool val) {
    _isSearching = val;
    notifyListeners();
  }

  selectDept(DeptModel dept, _) async {
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
                  updateDepartment(dept);
                },
              ),
            ],
            message: Text(
              'Continue with ${dept.name} as your deparment',
              style: TextStyle(
                  fontSize: 16,
                  color: black,
                  fontFamily: 'GalanoGrotesque2',
                  fontWeight: FontWeight.w200),
            ),
          ),
        );
      },
      context: _,
    );
  }

  updateDepartment(DeptModel dept) async {
    try {
      _isLoading = true;
      notifyListeners();

      var user = await auth.getCurrentUser();

      if (user != null) {
        var studentModel = await auth.getStudentProfileData(user.uid);
        notifyListeners();
        if (studentModel != null) {
          var deps = await Firestore.instance
              .collection('classes')
              .where('year', isEqualTo: studentModel.year)
              .where('department', isEqualTo: dept.name)
              .getDocuments();

          var hasFound = false;

          if (deps.documents.length > 0) {
            for (var i = 0; i < deps.documents.length; i++) {
              
              if (studentModel.school
                  .toString()
                  .contains(deps.documents[i].data['university'])) {
                hasFound = true;
                notifyListeners();
                await Firestore.instance
                    .collection('student')
                    .document('${user.uid}')
                    .updateData(
                  {
                    'department': dept.name,
                    'is_admin': false,
                    'class_id': deps.documents[0].documentID,
                  },
                ).then((value) async {
                  studentModel = await auth.getStudentProfileData(user.uid);
                  Navigator.pop(homeContext);
                  Navigator.of(homeContext).pushReplacement(
                    FadeRoute(
                      builder: (context) => Controller(
                        studentModel: studentModel,
                      ),
                    ),
                  );
                });
              }
              if (i == deps.documents.length - 1 && !hasFound)
                throw 'Not found';
            }
          } else {
            throw 'Not found';
          }
        }
      }
    } catch (e) {
      _isLoading = false;
      print(e.toString());
      notifyListeners();
      await showDialog(
          context: homeContext,
          builder: (_) => new AlertDialog(
                title: new Text("Error"),
                content: new Text("Could not update your department"),
              ));
    }
  }
}
