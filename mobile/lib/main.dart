import 'package:flutter/material.dart';
import 'package:nudge/utils/theme.dart';

import 'auth/login.dart';
import 'widgets/logo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nudge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'GalanoGrotesque',
          primarySwatch: Colors.blue,
          primaryColor: Color(0xff3B28C7)),
      home: LoginPage(),
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Logo(),
    );
  }
}
