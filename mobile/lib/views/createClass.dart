import 'package:flutter/material.dart';
import 'package:nudge/providers/createClassProvider.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/widgets/textFields.dart';
import 'package:provider/provider.dart';

class CreateClass extends StatefulWidget {
  CreateClass({Key key}) : super(key: key);

  @override
  _CreateClassState createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  CreateClassProvider provider;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    await Future.delayed(Duration(milliseconds: 600));
    provider.initState(context);
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<CreateClassProvider>(context);
    return Scaffold(
      backgroundColor: blue,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.dark,
        backgroundColor: blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: provider.formKey,
          child: ListView(
            children: <Widget>[
              const YMargin(10),
              Image.asset(
                'assets/images/clip-2.png',
                scale: 4,
              ),
              Center(
                child: Text(
                  'Add your class to Nudge.',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 19, color: white),
                ),
              ),
              const YMargin(30),
              Level(
                provider,
                isEnabled: false,
                isDarkTheme: true,
              ),
              School(
                provider,
                isEnabled: false,
                isDarkTheme: true,
              ),
              DepartmentName(
                provider,
                isDarkTheme: true,
              ),
              const YMargin(10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  '* Please make sure that your department\'s name is accurate and\n   that your class doesn\'t yet exist.',
                  style: TextStyle(
                      fontSize: 9.9, color: white, fontWeight: FontWeight.w200),
                ),
              ),
              const YMargin(20),
              provider.isLoading
                  ? Container(
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
                      ))
                  : Container(
                      height: 55,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: FlatButton(
                        color: white,
                        textColor: blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          provider.createDept(context);
                        },
                        child: Text(
                          'Confirm and Create',
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
