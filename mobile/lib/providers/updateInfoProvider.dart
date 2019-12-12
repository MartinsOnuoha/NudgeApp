import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nudge/auth/updateDepartment.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/models/universityModel.dart';
import 'package:nudge/utils/baseAuth.dart';
import 'package:nudge/utils/margin.dart';

class UpdateInfoProvider extends ChangeNotifier {
  final TextEditingController regNoTEC = new TextEditingController();
  final TextEditingController currentLevelTEC = new TextEditingController();
  final TextEditingController schoolTEC = new TextEditingController();

  var formKey = GlobalKey<FormState>();
  BaseAuth auth = new Auth();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _currentLevel;
  String get currentLevel => _currentLevel;

  List<UniversityModel> schoolsList = new List();

  List<FacultyModel> facultyList = new List();
  List<FacultyModel> departmentsList = new List();

  UniversityModel _currentUniversity;
  UniversityModel get currentUniversity => _currentUniversity;

  FacultyModel _facultyModel;
  FacultyModel get facultyModelisLoading => _facultyModel;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

 
  set currentLevel(String val) {
    _currentLevel = val;
    notifyListeners();
  }

  set facultyModel(FacultyModel val) {
    _facultyModel = val;
    notifyListeners();
  }

  set currentUniversity(val) {
    _currentUniversity = val;
    notifyListeners();
  }

  loadSchools() async {
    //schools
    var schools = await Firestore.instance
        .collection('schools')
        .orderBy('schoolId')
        .getDocuments();
    try {
      schoolsList = [];
      notifyListeners();
      schools.documents.forEach((g) {
        // print(g.data);
        schoolsList.add(UniversityModel.fromSnapshot(g));
        notifyListeners();
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  submitSchoolData(BuildContext context, provider) async {
    try {
      if (formKey.currentState.validate()) {
        _isLoading = true;
        notifyListeners();

        var user = await auth.getCurrentUser();
        if (user != null) {
          await Firestore.instance
              .collection('student')
              .document('${user.uid}')
              .updateData({
            'school': '${_currentUniversity.schoolName} ',
            'year': '${currentLevelTEC.text}',
            'reg_no': '${regNoTEC.text}',
          });

          //var studenModel = await auth.getStudentProfileData(user.uid);
          _isLoading = false;
          notifyListeners();
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateDepartment(),
            ),
          );
        }
      }
    } catch (e) {
      _isLoading = false;

      notifyListeners();
      print(e.toString());
    }
  }

  void showSchools(context) {
    Future<void> future = showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return schoolsList != null && schoolsList.length > 0
            ? Container(
                height: 240,
                child: GestureDetector(
                  child: new SafeArea(
                    child: ListView.builder(
                      itemCount: schoolsList.toSet().toList().length ?? 0,
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                          height: 60,
                          child: InkWell(
                            onTap: () {
                              _currentUniversity =
                                  schoolsList.toSet().toList()[i];
                              schoolTEC.text =
                                  schoolsList.toSet().toList()[i].schoolName;
                              notifyListeners();
                              // loadFaculties();
                              Navigator.pop(context);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                YMargin(5),
                                Text(
                                  "${schoolsList.toSet().toList()[i].schoolName}",
                                  style: TextStyle(fontSize: 15),
                                ),
                                const YMargin(10),
                                Divider(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ))
            : Container(
                padding: const EdgeInsets.all(18.0),
                child: Text('No Schools Found'),
              );
      },
    );
    future.then((void value) => {});
  }

  void showLevels(context) {
    Future<void> future = showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return level != null && level.length > 0
            ? Container(
                height: 240,
                child: GestureDetector(
                  child: new SafeArea(
                    child: ListView.builder(
                      itemCount: level.length ?? 0,
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                          height: 60,
                          child: InkWell(
                            onTap: () {
                              _currentLevel = level[i];
                              currentLevelTEC.text = level[i];
                              notifyListeners();
                              Navigator.pop(context);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                YMargin(5),
                                Text(
                                  "${level[i]}",
                                  style: TextStyle(fontSize: 15),
                                ),
                                const YMargin(10),
                                Divider(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ))
            : Container(
                padding: const EdgeInsets.all(18.0),
                child: Text('No Schools Found'),
              );
      },
    );
    future.then((void value) => {});
  }
}

List<String> level = [
  '100 L',
  '200 L',
  '300 L',
  '400 L',
  '500 L',
  '600 L',
];
