import 'package:flutter/material.dart';
import 'package:nudge/models/studentModel.dart';

class Controller extends StatefulWidget {
  final StudentModel studentModel;
  Controller({Key key, @required this.studentModel}) : super(key: key);

  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
