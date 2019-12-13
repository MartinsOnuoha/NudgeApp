import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nudge/auth/updateInfo.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/providers/controllerProvider.dart';
import 'package:nudge/utils/baseAuth.dart';
import 'package:nudge/utils/persistence.dart';
import 'package:nudge/utils/theme.dart';
import 'package:provider/provider.dart';

import 'auth/login.dart';
import 'auth/updateDepartment.dart';
import 'providers/createClassProvider.dart';
import 'providers/updateDeptProvider.dart';
import 'providers/updateInfoProvider.dart';
import 'utils/fade_route.dart';
import 'views/controller.dart';
import 'views/tabs/providers/calendarProvider.dart';
import 'views/tabs/providers/homeProvider.dart';
import 'views/tabs/providers/notesProvider.dart';
import 'widgets/logo.dart';

import 'providers/signupProvider.dart';
import 'providers/loginProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: 'Nudge',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'GalanoGrotesque',
            primarySwatch: Colors.blue,
            accentColor: blue,
            primaryColor: blue),
        home: LoginPage(),
      ),
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider(builder: (_) => ControllerProvider()),
        ChangeNotifierProvider(builder: (_) => CalendarProvider()),
        ChangeNotifierProvider(builder: (_) => LoginProvider()),
        ChangeNotifierProvider(builder: (_) => SignupProvider()),
        ChangeNotifierProvider(builder: (_) => UpdateInfoProvider()),
        ChangeNotifierProvider(builder: (_) => UpdateDeptProvider()),
        ChangeNotifierProvider(builder: (_) => CreateClassProvider()),
        ChangeNotifierProvider(builder: (_) => HomeProvider()),
        ChangeNotifierProvider(builder: (_) => NotesProvider()),
      ],
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  BaseAuth auth = new Auth();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 3));

    Navigator.of(context).pushReplacement(
      FadeRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: white,
          elevation: 0,
          brightness: Brightness.light,
        ),
        preferredSize: Size.fromHeight(0),
      ),
      body: Logo(),
    );
  }
}
