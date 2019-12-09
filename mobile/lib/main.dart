import 'package:flutter/material.dart';
import 'package:nudge/utils/theme.dart';
import 'package:provider/provider.dart';

import 'auth/login.dart';
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
        ChangeNotifierProvider(builder: (_) => LoginProvider()),
        ChangeNotifierProvider(builder: (_) => SignupProvider()),
      ],
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
