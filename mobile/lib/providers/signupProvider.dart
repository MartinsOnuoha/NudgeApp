import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nudge/auth/updateInfo.dart';
import 'package:nudge/utils/baseAuth.dart';

class SignupProvider extends ChangeNotifier {
  final TextEditingController nameTEC = new TextEditingController();
  final TextEditingController surnameTEC = new TextEditingController();
  final TextEditingController cmPasswordTEC = new TextEditingController();
  final TextEditingController passwordTEC = new TextEditingController();
  final TextEditingController emailTEC = new TextEditingController();

  var formKey = GlobalKey<FormState>();
  BaseAuth auth = new Auth();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  submitData(BuildContext context, provider) async {
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

          var studentModel = await auth.getStudentProfileData(user.uid);
          _isLoading = false;
          notifyListeners();

          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateInfo(
                studentModel: studentModel,
              ),
            ),
          );
        }
      }
    } catch (e) {
      _isLoading = false;
     /*  if (e.toString().contains('ERROR_EMAIL_ALREADY_IN_USE,')) {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text("Invalid Password"),
                  content: new Text(
                      "This email address is already in use by another account."),
                ));
      } */
      notifyListeners();
      print(e.toString());
    }
  }
}
