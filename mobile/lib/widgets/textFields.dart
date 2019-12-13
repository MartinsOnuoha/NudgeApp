import 'package:flutter/material.dart';
import 'package:nudge/providers/signupProvider.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/utils/validator.dart';

class Name extends StatelessWidget {
  final text;
  final SignupProvider controller;
  final bool isDarkTheme, isEnabled;
  const Name(
    this.controller, {
    Key key,
    this.text,
    this.isDarkTheme = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Theme(
        data: ThemeData(
            primaryColor: isDarkTheme ? Colors.white : Colors.black,
            accentColor: isDarkTheme ? Colors.white : Colors.black,
            hintColor: isDarkTheme ? Colors.white : Colors.black,
            fontFamily: 'GalanoGrotesque2'),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextFormField(
            validator: (value) {
              if (value.isNotEmpty) {
                return null;
              } else if (value.isEmpty) {
                return "This field can't be left empty";
              } else {
                return "Name is Invalid";
              }
            },
            controller: controller?.nameTEC,
            enabled: isEnabled,
            style: TextStyle(
                fontSize: 16,
                color: isDarkTheme ? Colors.white : Colors.black,
                fontWeight: FontWeight.w200),
            decoration: InputDecoration(
                isDense: false,
                border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'GalanoGrotesque',
                    color: isDarkTheme ? Colors.white : Colors.black),
                errorStyle: TextStyle(
                    fontSize: 14,
                    color: isDarkTheme ? Colors.white : Colors.red),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: isDarkTheme ? Colors.white : Colors.grey[500],
                      width: 1.4),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: isDarkTheme ? Colors.white60 : Colors.grey[300],
                      width: 1.4),
                ),
                errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.red, width: 1.4),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                labelText: 'Name'),
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }
}

class Surname extends StatelessWidget {
  final text;
  final SignupProvider controller;
  final bool isDarkTheme, isEnabled;
  const Surname(
    this.controller, {
    Key key,
    this.text,
    this.isDarkTheme = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Theme(
        data: ThemeData(
            primaryColor: isDarkTheme ? Colors.white : Colors.black,
            accentColor: isDarkTheme ? Colors.white : Colors.black,
            hintColor: isDarkTheme ? Colors.white : Colors.black,
            fontFamily: 'GalanoGrotesque2'),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextFormField(
            validator: (value) {
              if (value.isNotEmpty) {
                return null;
              } else if (value.isEmpty) {
                return "This field can't be left empty";
              } else {
                return "Surname is Invalid";
              }
            },
            controller: controller?.surnameTEC,
            enabled: isEnabled,
            style: TextStyle(
                fontSize: 16,
                color: isDarkTheme ? Colors.white : Colors.black,
                fontWeight: FontWeight.w200),
            decoration: InputDecoration(
                isDense: false,
                border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'GalanoGrotesque',
                    color: isDarkTheme ? Colors.white : Colors.black),
                errorStyle: TextStyle(
                    fontSize: 14,
                    color: isDarkTheme ? Colors.white : Colors.red),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: isDarkTheme ? Colors.white : Colors.grey[500],
                      width: 1.4),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: isDarkTheme ? Colors.white60 : Colors.grey[300],
                      width: 1.4),
                ),
                errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.red, width: 1.4),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                labelText: 'Surname'),
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }
}

class Email extends StatelessWidget {
  final text;
  final controller;
  final bool isDarkTheme, isEnabled;
  const Email(
    this.controller, {
    Key key,
    this.text,
    this.isDarkTheme = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Theme(
        data: ThemeData(
            primaryColor: isDarkTheme ? Colors.white : Colors.black,
            accentColor: isDarkTheme ? Colors.white : Colors.black,
            hintColor: isDarkTheme ? Colors.white : Colors.black,
            fontFamily: 'GalanoGrotesque2'),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextFormField(
            validator: (value) {
              if (Validator.isEmail(value)) {
                return null;
              } else if (value.isEmpty) {
                return "This field can't be left empty";
              } else {
                return "Email is Invalid";
              }
            },
            controller: controller?.emailTEC,
            enabled: isEnabled,
            style: TextStyle(
                fontSize: 16,
                color: isDarkTheme ? Colors.white : Colors.black,
                fontWeight: FontWeight.w200),
            decoration: InputDecoration(
                isDense: false,
                border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'GalanoGrotesque',
                    color: isDarkTheme ? Colors.white : Colors.black),
                errorStyle: TextStyle(
                    fontSize: 14,
                    color: isDarkTheme ? Colors.white : Colors.red),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: isDarkTheme ? Colors.white : Colors.grey[500],
                      width: 1.4),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: isDarkTheme ? Colors.white60 : Colors.grey[300],
                      width: 1.4),
                ),
                errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.red, width: 1.4),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ),
    );
  }
}

class Password extends StatelessWidget {
  final text;
  final controller;
  final bool isDarkTheme, isEnabled;
  const Password(
    this.controller, {
    Key key,
    this.text,
    this.isDarkTheme = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Theme(
        data: ThemeData(
            primaryColor: isDarkTheme ? Colors.white : Colors.black,
            accentColor: isDarkTheme ? Colors.white : Colors.black,
            hintColor: isDarkTheme ? Colors.white : Colors.black,
            fontFamily: 'GalanoGrotesque2'),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextFormField(
            validator: (value) {
              if (Validator.isPassword(value)) {
                return null;
              } else if (value.isEmpty) {
                return "This field can't be left empty";
              } else {
                return "Password is Invalid";
              }
            },
            controller: controller?.passwordTEC,
            enabled: isEnabled,
            obscureText: true,
            style: TextStyle(
                fontSize: 16,
                color: isDarkTheme ? Colors.white : Colors.black,
                fontWeight: FontWeight.w200),
            decoration: InputDecoration(
                isDense: false,
                border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'GalanoGrotesque',
                    color: isDarkTheme ? Colors.white : Colors.black),
                errorStyle: TextStyle(
                    fontSize: 14,
                    color: isDarkTheme ? Colors.white : Colors.red),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: isDarkTheme ? Colors.white : Colors.grey[500],
                      width: 1.4),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: isDarkTheme ? Colors.white60 : Colors.grey[300],
                      width: 1.4),
                ),
                errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.red, width: 1.4),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                labelText: 'Password'),
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }
}

class CMPassword extends StatelessWidget {
  final text;
  final SignupProvider controller;
  final bool isDarkTheme, isEnabled;
  const CMPassword(
    this.controller, {
    Key key,
    this.text,
    this.isDarkTheme = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Theme(
        data: ThemeData(
            primaryColor: isDarkTheme ? Colors.white : Colors.black,
            accentColor: isDarkTheme ? Colors.white : Colors.black,
            hintColor: isDarkTheme ? Colors.white : Colors.black,
            fontFamily: 'GalanoGrotesque2'),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextFormField(
            validator: (value) {
              if (value == controller.passwordTEC.text) {
                return null;
              } else if (value.isEmpty) {
                return "This field can't be left empty";
              } else {
                return "Password Mismatch";
              }
            },
            controller: controller?.cmPasswordTEC,
            enabled: isEnabled,
            obscureText: true,
            style: TextStyle(
                fontSize: 16,
                color: isDarkTheme ? Colors.white : Colors.black,
                fontWeight: FontWeight.w200),
            decoration: InputDecoration(
                isDense: false,
                border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: 'GalanoGrotesque',
                    color: isDarkTheme ? Colors.white : Colors.black),
                errorStyle: TextStyle(
                    fontSize: 14,
                    color: isDarkTheme ? Colors.white : Colors.red),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: isDarkTheme ? Colors.white : Colors.grey[500],
                      width: 1.4),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: isDarkTheme ? Colors.white60 : Colors.grey[300],
                      width: 1.4),
                ),
                errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.red, width: 1.4),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                labelText: 'Confrim Password'),
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }
}

class RegNo extends StatelessWidget {
  final text;
  final controller;
  final bool isDarkTheme, isEnabled;
  const RegNo(
    this.controller, {
    Key key,
    this.text,
    this.isDarkTheme = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Theme(
        data: ThemeData(
            primaryColor: isDarkTheme ? Colors.white : Colors.black,
            accentColor: isDarkTheme ? Colors.white : Colors.black,
            hintColor: isDarkTheme ? Colors.white : Colors.black,
            fontFamily: 'GalanoGrotesque2'),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: TextFormField(
            validator: (value) {
              if (value != null) {
                return null;
              } else if (value.isEmpty) {
                return "This field can't be left empty";
              } else {
                return "Reg no is Invalid";
              }
            },
            controller: controller?.regNoTEC,
            enabled: isEnabled,
            style: TextStyle(
                fontSize: 26,
                color: isDarkTheme ? Colors.white : Colors.black,
                fontWeight: FontWeight.w200),
            decoration: InputDecoration(
                isDense: false,
                border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
                labelStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: 'GalanoGrotesque',
                    color: isDarkTheme ? Colors.white : Colors.black),
                errorStyle: TextStyle(
                    fontSize: 14,
                    color: isDarkTheme ? Colors.white : Colors.red),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: isDarkTheme ? Colors.white : Colors.grey[500],
                      width: 1.4),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: isDarkTheme ? Colors.white60 : Colors.grey[300],
                      width: 1.4),
                ),
                errorBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
                  borderSide: BorderSide(color: Colors.red, width: 1.4),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                labelText: 'Reg Number'),
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }
}

class Level extends StatelessWidget {
  final text;
  final VoidCallback onTap;
  final controller;
  final bool isDarkTheme, isEnabled;
  const Level(
    this.controller, {
    Key key,
    this.text,
    this.onTap,
    this.isDarkTheme = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Theme(
          data: ThemeData(
              primaryColor: isDarkTheme ? Colors.white : Colors.black,
              accentColor: isDarkTheme ? Colors.white : Colors.black,
              hintColor: isDarkTheme ? Colors.white : Colors.black,
              fontFamily: 'GalanoGrotesque2'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              validator: (value) {
                if (value != null) {
                  return null;
                } else if (value.isEmpty) {
                  return "This field can't be left empty";
                } else {
                  return "Current Level is Invalid";
                }
              },
              controller: controller?.currentLevelTEC,
              enabled: isEnabled,
              style: TextStyle(
                  fontSize: 26,
                  color: isDarkTheme ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w200),
              decoration: InputDecoration(
                  isDense: false,
                  border: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'GalanoGrotesque',
                      color: isDarkTheme ? Colors.white : Colors.black),
                  errorStyle: TextStyle(
                      fontSize: 14,
                      color: isDarkTheme ? Colors.white : Colors.red),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white : Colors.grey[500],
                        width: 1.4),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white60 : Colors.grey[300],
                        width: 1.4),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Colors.red, width: 1.4),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  labelText: 'Current Level'),
              keyboardType: TextInputType.text,
            ),
          ),
        ),
      ),
    );
  }
}

class School extends StatelessWidget {
  final text;
  final VoidCallback onTap;
  final controller;
  final bool isDarkTheme, isEnabled;
  const School(
    this.controller, {
    Key key,
    this.text,
    this.onTap,
    this.isDarkTheme = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Theme(
          data: ThemeData(
              primaryColor: isDarkTheme ? Colors.white : Colors.black,
              accentColor: isDarkTheme ? Colors.white : Colors.black,
              hintColor: isDarkTheme ? Colors.white : Colors.black,
              fontFamily: 'GalanoGrotesque2'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              controller: controller?.schoolTEC,
              enabled: isEnabled,
              style: TextStyle(
                  fontSize: 19,
                  color: isDarkTheme ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w200),
              decoration: InputDecoration(
                  isDense: false,
                  border: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'GalanoGrotesque',
                      color: isDarkTheme ? Colors.white : Colors.black),
                  errorStyle: TextStyle(
                      fontSize: 14,
                      color: isDarkTheme ? Colors.white : Colors.red),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white : Colors.grey[500],
                        width: 1.4),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white60 : Colors.grey[300],
                        width: 1.4),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Colors.red, width: 1.4),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  labelText: 'University'),
              keyboardType: TextInputType.text,
            ),
          ),
        ),
      ),
    );
  }
}

class DepartmentName extends StatelessWidget {
  final text;
  final VoidCallback onTap;
  final controller;
  final bool isDarkTheme, isEnabled;
  const DepartmentName(
    this.controller, {
    Key key,
    this.text,
    this.onTap,
    this.isDarkTheme = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Theme(
          data: ThemeData(
              primaryColor: isDarkTheme ? Colors.white : Colors.black,
              accentColor: isDarkTheme ? Colors.white : Colors.black,
              hintColor: isDarkTheme ? Colors.white : Colors.black,
              fontFamily: 'GalanoGrotesque2'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              controller: controller?.deptTEC,
              enabled: isEnabled,
              style: TextStyle(
                  fontSize: 19,
                  color: isDarkTheme ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w200),
              decoration: InputDecoration(
                  isDense: false,
                  border: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'GalanoGrotesque',
                      color: isDarkTheme ? Colors.white : Colors.black),
                  errorStyle: TextStyle(
                      fontSize: 14,
                      color: isDarkTheme ? Colors.white : Colors.red),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white : Colors.grey[500],
                        width: 1.4),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white60 : Colors.grey[300],
                        width: 1.4),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Colors.red, width: 1.4),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  labelText: 'Department Name'),
              keyboardType: TextInputType.text,
            ),
          ),
        ),
      ),
    );
  }
}

class DepartmentSearch extends StatelessWidget {
  final text;
  final VoidCallback onTap;
  final controller;
  final bool isDarkTheme, isEnabled;
  const DepartmentSearch(
    this.controller, {
    Key key,
    this.text,
    this.onTap,
    this.isDarkTheme = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.symmetric(horizontal: 20)
            .add(EdgeInsets.only(bottom: 20)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: blue.withOpacity(0.4),
        ),
        child: Theme(
          data: ThemeData(
              primaryColor: white,
              accentColor: white,
              hintColor: white,
              fontFamily: 'GalanoGrotesque2'),
          child: TextField(
            controller: controller?.searchTEC,
            enabled: isEnabled,
            onChanged: (val) {
              if (val.isNotEmpty)
                controller.isSearching = true;
              else
                controller.isSearching = false;
            },
            style: TextStyle(
                fontSize: 19, color: Colors.white, fontWeight: FontWeight.w200),
            decoration: InputDecoration(
                isDense: false,
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 15, fontFamily: 'GalanoGrotesque', color: white),
                contentPadding: const EdgeInsets.all(15),
                hintText: 'Search...'),
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }
}

class ClassName extends StatelessWidget {
  final text;
  final VoidCallback onTap;
  final controller;
  final bool isDarkTheme, isEnabled;
  const ClassName(
    this.controller, {
    Key key,
    this.text,
    this.onTap,
    this.isDarkTheme = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Theme(
          data: ThemeData(
              primaryColor: isDarkTheme ? Colors.white : Colors.black,
              accentColor: isDarkTheme ? Colors.white : Colors.black,
              hintColor: isDarkTheme ? Colors.white : Colors.black,
              fontFamily: 'GalanoGrotesque2'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              validator: (value) {
                if (value.isNotEmpty) {
                  return null;
                } else if (value.isEmpty) {
                  return "This field can't be left empty";
                } else {
                  return "Class Name or Course is Invalid";
                }
              },
              controller: controller?.classTEC,
              enabled: isEnabled,
              style: TextStyle(
                  fontSize: 26,
                  color: isDarkTheme ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w200),
              decoration: InputDecoration(
                  isDense: false,
                  border: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'GalanoGrotesque',
                      color: isDarkTheme ? Colors.white : Colors.black),
                  errorStyle: TextStyle(
                      fontSize: 14,
                      color: isDarkTheme ? Colors.white : Colors.red),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white : Colors.grey[500],
                        width: 1.4),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white60 : Colors.grey[300],
                        width: 1.4),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Colors.red, width: 1.4),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  labelText: 'Class Name / Course'),
              keyboardType: TextInputType.text,
            ),
          ),
        ),
      ),
    );
  }
}

class Location extends StatelessWidget {
  final text;
  final VoidCallback onTap;
  final controller;
  final bool isDarkTheme, isEnabled;
  const Location(
    this.controller, {
    Key key,
    this.text,
    this.onTap,
    this.isDarkTheme = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Theme(
          data: ThemeData(
              primaryColor: isDarkTheme ? Colors.white : Colors.black,
              accentColor: isDarkTheme ? Colors.white : Colors.black,
              hintColor: isDarkTheme ? Colors.white : Colors.black,
              fontFamily: 'GalanoGrotesque2'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              validator: (value) {
                if (value.isNotEmpty) {
                  return null;
                } else if (value.isEmpty) {
                  return "This field can't be left empty";
                } else {
                  return "Location is Invalid";
                }
              },
              controller: controller?.locationTEC,
              enabled: isEnabled,
              style: TextStyle(
                  fontSize: 26,
                  color: isDarkTheme ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w200),
              decoration: InputDecoration(
                  isDense: false,
                  border: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'GalanoGrotesque',
                      color: isDarkTheme ? Colors.white : Colors.black),
                  errorStyle: TextStyle(
                      fontSize: 14,
                      color: isDarkTheme ? Colors.white : Colors.red),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white : Colors.grey[500],
                        width: 1.4),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white60 : Colors.grey[300],
                        width: 1.4),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Colors.red, width: 1.4),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  labelText: 'Location or Venue'),
              keyboardType: TextInputType.text,
            ),
          ),
        ),
      ),
    );
  }
}

class StartTime extends StatelessWidget {
  final text;
  final VoidCallback onTap;
  final controller;
  final bool isDarkTheme, isEnabled;
  const StartTime(
    this.controller, {
    Key key,
    this.text,
    this.onTap,
    this.isDarkTheme = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Theme(
          data: ThemeData(
              primaryColor: isDarkTheme ? Colors.white : Colors.black,
              accentColor: isDarkTheme ? Colors.white : Colors.black,
              hintColor: isDarkTheme ? Colors.white : Colors.black,
              fontFamily: 'GalanoGrotesque2'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              controller: controller?.startTime,
              enabled: false,
              style: TextStyle(
                  fontSize: 26,
                  color: isDarkTheme ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w200),
              decoration: InputDecoration(
                  isDense: false,
                  border: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'GalanoGrotesque',
                      color: isDarkTheme ? Colors.white : Colors.black),
                  errorStyle: TextStyle(
                      fontSize: 14,
                      color: isDarkTheme ? Colors.white : Colors.red),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white : Colors.grey[500],
                        width: 1.4),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white60 : Colors.grey[300],
                        width: 1.4),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Colors.red, width: 1.4),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  labelText: 'Class Begins At'),
              keyboardType: TextInputType.text,
            ),
          ),
        ),
      ),
    );
  }
}

class EndTime extends StatelessWidget {
  final text;
  final VoidCallback onTap;
  final controller;
  final bool isDarkTheme, isEnabled;
  const EndTime(
    this.controller, {
    Key key,
    this.text,
    this.onTap,
    this.isDarkTheme = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Theme(
          data: ThemeData(
              primaryColor: isDarkTheme ? Colors.white : Colors.black,
              accentColor: isDarkTheme ? Colors.white : Colors.black,
              hintColor: isDarkTheme ? Colors.white : Colors.black,
              fontFamily: 'GalanoGrotesque2'),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              controller: controller?.endTime,
              enabled: false,
              style: TextStyle(
                  fontSize: 26,
                  color: isDarkTheme ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w200),
              decoration: InputDecoration(
                  isDense: false,
                  border: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(
                      fontSize: 15,
                      fontFamily: 'GalanoGrotesque',
                      color: isDarkTheme ? Colors.white : Colors.black),
                  errorStyle: TextStyle(
                      fontSize: 14,
                      color: isDarkTheme ? Colors.white : Colors.red),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white : Colors.grey[500],
                        width: 1.4),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? Colors.white60 : Colors.grey[300],
                        width: 1.4),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide(color: Colors.red, width: 1.4),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  labelText: 'Class Ends At'),
              keyboardType: TextInputType.text,
            ),
          ),
        ),
      ),
    );
  }
}

class TeacherSearch extends StatelessWidget {
  final text;
  final VoidCallback onTap;
  final Function(String) onChanged;
  final bool isDarkTheme, isEnabled;
  final TextEditingController controller;

  TeacherSearch({
    Key key,
    this.onChanged,
    this.text,
    this.onTap,
    this.isDarkTheme = false,
    this.isEnabled = true,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white.withOpacity(0.3),
        ),
        height: 42,
        child: Theme(
          data: ThemeData(
              primaryColor: white,
              accentColor: white,
              hintColor: white,
              fontFamily: 'GalanoGrotesque2'),
          child: TextField(
            enabled: isEnabled,
            controller: controller,
            onChanged: (val) {
              onChanged(val);
            },
            style: TextStyle(
                fontSize: 19, color: Colors.white, fontWeight: FontWeight.w200),
            decoration: InputDecoration(
                isDense: false,
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 15, fontFamily: 'GalanoGrotesque', color: white),
                contentPadding: const EdgeInsets.all(15),
                hintText: 'Search...'),
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }
}

class NewNoteTitle extends StatelessWidget {
  final text;
  final VoidCallback onTap;
  final Function(String) onChanged;
  final bool isDarkTheme, isEnabled;
  final TextEditingController controller;

  NewNoteTitle({
    Key key,
    this.onChanged,
    this.text,
    this.onTap,
    this.isDarkTheme = false,
    this.isEnabled = true,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        
        padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: blue.withOpacity(0.06),
        ),
        child: Theme(
          data: ThemeData(
              primaryColor: blue3,
              accentColor: blue3,
              hintColor: blue3,
              fontFamily: 'GalanoGrotesque2'),
          child: TextFormField(
            enabled: isEnabled,
            controller: controller,
            initialValue: text,
            onChanged: (val) {
              onChanged(val);
            },
            style: TextStyle(
                fontSize: 19, color: blue3, fontWeight: FontWeight.w200),
            decoration: InputDecoration(
                isDense: false,
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontSize: 19, fontFamily: 'GalanoGrotesque2', color: blue3),
                contentPadding: const EdgeInsets.all(15),
                hintText: 'Note Title'),
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );
  }
}
