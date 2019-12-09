import 'package:flutter/material.dart';

class Name extends StatelessWidget {
  final text;
  final controller;
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
                this.controller.email = value;

                return null;
              } else if (value.isEmpty) {
                return "This field can't be left empty";
              } else {
                return "Name on Card is Invalid";
              }
            },
            maxLines: null,
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
                labelText: 'Name'),
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
              if (value.isNotEmpty) {
                this.controller.email = value;

                return null;
              } else if (value.isEmpty) {
                return "This field can't be left empty";
              } else {
                return "Name on Card is Invalid";
              }
            },
            maxLines: null,
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
              if (value.isNotEmpty) {
                this.controller.email = value;

                return null;
              } else if (value.isEmpty) {
                return "This field can't be left empty";
              } else {
                return "Name on Card is Invalid";
              }
            },
            maxLines: null,
            controller: controller?.emailTEC,
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
  final controller;
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
              if (value.isNotEmpty) {
                this.controller.email = value;

                return null;
              } else if (value.isEmpty) {
                return "This field can't be left empty";
              } else {
                return "Name on Card is Invalid";
              }
            },
            maxLines: null,
            controller: controller?.emailTEC,
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
