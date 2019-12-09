import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/widgets/logo.dart';
import 'package:nudge/widgets/textFields.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: white,
      ),
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            const YMargin(10),
            Logo(),
            const YMargin(20),
            Image.asset(
              'assets/images/clip-1.png',
              scale: 4,
            ),
            Name(null),
            Email(null),
            Password(null),
            CMPassword(null),
            Container(
              height: 55,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: FlatButton(
                //pressedOpacity: 0.7,
                color: blue,
                textColor: white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {},
                child: Text(
                  'Signup',
                  style:
                      TextStyle(fontSize: 17, fontFamily: 'GalanoGrotesque2'),
                ),
              ),
            ),
            Container(
              height: 55,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: FlatButton(
                //pressedOpacity: 0.7,
                color: white,
                textColor: blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {},
                child: Text(
                  'Login',
                  style:
                      TextStyle(fontSize: 17, fontFamily: 'GalanoGrotesque2'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
