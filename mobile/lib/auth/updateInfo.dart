import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/providers/updateInfoProvider.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/widgets/textFields.dart';
import 'package:provider/provider.dart';

class UpdateInfo extends StatefulWidget {
  final StudentModel studentModel;

  UpdateInfo({Key key, this.studentModel}) : super(key: key);

  @override
  _UpdateInfoState createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {
  UpdateInfoProvider provider;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    await Future.delayed(Duration(milliseconds: 600));
    provider.loadSchools();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<UpdateInfoProvider>(context);
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
              Image.asset(
                'assets/images/clip-2.png',
                scale: 4,
              ),
              Center(
                child: Text(
                  'Your Profile',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 19, color: black),
                ),
              ),
              const YMargin(30),
              RegNo(provider),
              GestureDetector(
                child: Level(
                  provider,
                  isEnabled: false,
                ),
                onTap: () {
                  provider.showLevels(context);
                },
              ),
              GestureDetector(
                child: School(
                  provider,
                  isEnabled: false,
                ),
                onTap: () {
                  provider.showSchools(context);
                },
              ),
              provider.isLoading
                  ? Column(
                      children: <Widget>[
                        Container(
                          height: 35,
                          width: 35,
                          margin: EdgeInsets.all(10),
                          child: CircularProgressIndicator(),
                        )
                      ],
                    )
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
                          provider
                              .submitSchoolData(context, provider);
                        },
                        child: Text(
                          'Save My Data ',
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
