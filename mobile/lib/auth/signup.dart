import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nudge/providers/signupProvider.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/widgets/logo.dart';
import 'package:nudge/widgets/textFields.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SignupProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: white,
      ),
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Form(
          key: provider.formKey,
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
              Surname(provider),
              Name(provider),
              Email(provider),
              Password(provider),
              CMPassword(provider),
              provider.isLoading
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 35,
                            width: 35,
                            margin: EdgeInsets.all(10),
                            child: CircularProgressIndicator(),
                          )
                        ],
                      ))
                  : Container(
                      height: 55,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: FlatButton(
                        color: blue,
                        textColor: white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          provider.submitData(context);
                        },
                        child: Text(
                          'Signup',
                          style: TextStyle(
                              fontSize: 17, fontFamily: 'GalanoGrotesque2'),
                        ),
                      ),
                    ),
              Container(
                height: 55,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: FlatButton(
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
      ),
    );
  }
}
