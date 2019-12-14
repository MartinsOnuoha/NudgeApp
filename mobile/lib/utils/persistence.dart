
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future eraseProfileData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.remove('loginData');
  prefs.remove('profileData');
}

Future saveItem({@required item, @required key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key.toString(), item);
}

Future eraseItem({@required key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.remove('$key');
}

eraseItems({List<String> keys}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  for (var i = 0; i < keys.length; i++) {
    prefs.remove('${keys[i]}');
  }
}

Future<bool> keyExists({@required String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.get(key) != null) {
    return true;
  } else {
    return false;
  }
}

eraseAll() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future<dynamic> getItemData({@required key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('$key') != null ? prefs.getString('$key') : null;
}
