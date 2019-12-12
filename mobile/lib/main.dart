import 'package:flutter/material.dart';
import 'package:nudge/auth/updateInfo.dart';
import 'package:nudge/providers/controllerProvider.dart';
import 'package:nudge/utils/baseAuth.dart';
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
        home: Splash(),
      ),
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider(builder: (_) => ControllerProvider()),
        ChangeNotifierProvider(builder: (_) => CalendarProvider()),
        ChangeNotifierProvider(builder: (_) => LoginProvider()),
        ChangeNotifierProvider(builder: (_) => SignupProvider()),
        ChangeNotifierProvider(builder: (_) => UpdateInfoProvider()),
        ChangeNotifierProvider(builder: (_) => UpdateDeptProvider()),
        ChangeNotifierProvider(builder: (_) => CreateClassProvider()),
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
    try {
      await Future.delayed(Duration(seconds: 4));
      var user = await auth.getCurrentUser();
      if (user != null) {
        var _studentModel = await auth.getStudentProfileData(user.uid);
        if (_studentModel != null) {
          if (_studentModel.school == null) {
            Navigator.of(context).pushReplacement(
              FadeRoute(
                builder: (context) => UpdateInfo(
                  studentModel: _studentModel,
                ),
              ),
            );
          } else if (_studentModel.classID == null) {
            Navigator.of(context).pushReplacement(
              FadeRoute(
                builder: (context) => UpdateDepartment(),
              ),
            );
          } else {
            Navigator.of(context).pushReplacement(
              FadeRoute(
                builder: (context) => Controller(
                  studentModel: _studentModel,
                ),
              ),
            );
          }
        }
      } else {
        throw 'Logged Out';
      }
    } catch (e) {
      print(e.toString());
      Navigator.of(context).pushReplacement(
        FadeRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Logo(),
    );
  }
}
