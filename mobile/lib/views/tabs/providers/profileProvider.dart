import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:nudge/auth/updateInfo.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/utils/baseAuth.dart';

class ProfileProvider extends ChangeNotifier {
  final TextEditingController nameTEC = new TextEditingController();
  final TextEditingController surnameTEC = new TextEditingController();
  final TextEditingController regNoTEC = new TextEditingController();
  final TextEditingController currentLevelTEC = new TextEditingController();
  final TextEditingController schoolTEC = new TextEditingController();
  final TextEditingController phoneTEC = new TextEditingController();
  final TextEditingController emailTEC = new TextEditingController();

  var formKey = GlobalKey<FormState>();
  BaseAuth auth = new Auth();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  String _countryCode;
  String get countryCode => _countryCode;

  String _phone;
  String get phone => _phone;

  set countryCode(val) {
    _countryCode = val;
    notifyListeners();
  }

  set phone(val) {
    _phone = val;
    notifyListeners();
  }

  void onCountryChange(CountryCode val) {
    _countryCode = val.dialCode;
  }

  updateData(BuildContext context, StudentModel studentModel) async {
    regNoTEC.text = studentModel.regNo;
    surnameTEC.text = studentModel.lastName;
    nameTEC.text = studentModel.firstName;
    currentLevelTEC.text = studentModel.year;
    schoolTEC.text = studentModel.school;
    phoneTEC.text = studentModel.phone.substring(3, studentModel.phone.length);
    emailTEC.text = studentModel.email;
    notifyListeners();
  }
}
