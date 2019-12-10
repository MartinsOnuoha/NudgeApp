import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nudge/auth/updateInfo.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/utils/baseAuth.dart';
import 'package:nudge/utils/margin.dart';
class SignupProvider extends ChangeNotifier {
  final TextEditingController nameTEC = new TextEditingController();
  final TextEditingController surnameTEC = new TextEditingController();
  final TextEditingController cmPasswordTEC = new TextEditingController();
  final TextEditingController passwordTEC = new TextEditingController();
  final TextEditingController emailTEC = new TextEditingController();
  final TextEditingController currentLevelTEC = new TextEditingController();

  var formKey = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  BaseAuth auth = new Auth();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _currentLevel;
  String get currentLevel => _currentLevel;

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

  submitData(BuildContext context) async {
    try {
      if (formKey.currentState.validate()) {
        _isLoading = true;
        notifyListeners();

        var user = await auth.signUp(emailTEC.text, passwordTEC.text);
        if (user != null) {
          await Firestore.instance
              .collection('student')
              .document('${user.uid}')
              .setData({
            'first_name': '${nameTEC.text} ',
            'last_name': '${surnameTEC.text}',
            'email': '${emailTEC.text}',
            'is_online': false,
          });

          var studenModel = await auth.getStudentProfileData(user.uid);
          _isLoading = false;
          notifyListeners();
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateInfo(
                studentModel: studenModel,
              ),
            ),
          );
        }
      }
    } catch (e) {
      _isLoading = false;
      if (e.toString().contains('ERROR_EMAIL_ALREADY_IN_USE,')) {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text("Invalid Password"),
                  content: new Text(
                      "This email address is already in use by another account."),
                ));
      }
      notifyListeners();
      print(e.toString());
    }
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
                                YMargin( 5),
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
