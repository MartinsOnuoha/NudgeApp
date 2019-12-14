import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/widgets/logo.dart';
import 'package:nudge/widgets/textFields.dart';
import 'package:provider/provider.dart';

import 'providers/profileProvider.dart';

class Profile extends StatefulWidget {
  final StudentModel studentModel;

  const Profile({Key key, this.studentModel}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileProvider provider;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    await Future.delayed(Duration(milliseconds: 600));

    provider.updateData(context, widget.studentModel);
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProfileProvider>(context);
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
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 20),
                child: Text(
                  'Profile.',
                  style: TextStyle(
                      color: blue,
                      fontFamily: 'GalanoGrotesque2',
                      fontWeight: FontWeight.w700,
                      fontSize: 30),
                ),
              ),
              const YMargin(20),
              Surname(provider, isEnabled: false),
              Name(provider, isEnabled: false),
              Email(provider, isEnabled: false),
              Phone(provider, isEnabled: false),
              School(provider, isEnabled: false),
              Level(provider, isEnabled: false),
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
                        onPressed: () {},
                        child: Text(
                          'Update Profile',
                          style: TextStyle(
                              fontSize: 17, fontFamily: 'GalanoGrotesque2'),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
