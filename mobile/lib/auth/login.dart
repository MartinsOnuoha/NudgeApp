import 'package:flutter/material.dart';
import 'package:nudge/auth/signup.dart';
import 'package:nudge/providers/loginProvider.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/widgets/logo.dart';
import 'package:nudge/widgets/textFields.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginProvider>(context);
    return Scaffold(
      backgroundColor: blue,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark,
        backgroundColor: blue,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Theme(
          data:
              ThemeData(primaryColor: Colors.white, accentColor: Colors.white),
          child: Form(
            key: provider.formKey,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                const YMargin(20),
                Logo(
                  isDarkTheme: true,
                ),
                const YMargin(20),
                Image.asset(
                  'assets/images/clip-education.png',
                  scale: 4,
                ),
                Email(
                  provider,
                  isDarkTheme: true,
                ),
                Password(
                  provider,
                  isDarkTheme: true,
                ),
                const YMargin(60),
                !provider.isLoading
                    ? Container(
                        height: 55,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        child: FlatButton(
                          color: white,
                          textColor: blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            provider.login(context);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 17, fontFamily: 'GalanoGrotesque2'),
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Theme(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 35,
                                width: 35,
                                margin: EdgeInsets.all(10),
                                child: CircularProgressIndicator(),
                              )
                            ],
                          ),
                          data:
                              ThemeData(accentColor: white, primaryColor: white),
                        )),
                Container(
                  height: 55,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: FlatButton(
                    color: Colors.transparent,
                    textColor: white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Signup',
                      style:
                          TextStyle(fontSize: 17, fontFamily: 'GalanoGrotesque2'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
