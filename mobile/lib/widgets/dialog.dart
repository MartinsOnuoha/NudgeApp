import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/views/tabs/providers/homeProvider.dart';
import 'package:provider/provider.dart';

import 'textFields.dart';

class AddClass extends StatefulWidget {
  const AddClass({Key key}) : super(key: key);

  @override
  _AddClassState createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(true, 'MON'));
    sampleData.add(new RadioModel(false, 'TUE'));
    sampleData.add(new RadioModel(false, 'WED'));
    sampleData.add(new RadioModel(false, 'THU'));
    sampleData.add(new RadioModel(false, 'FRI'));
    sampleData.add(new RadioModel(false, 'SAT'));
    sampleData.add(new RadioModel(false, 'SUN'));
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);

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
                'assets/images/clip-1.png',
                scale: 4,
              ),
              Center(
                child: Text(
                  'Add a new Schedule to your timetable',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 19, color: white),
                ),
              ),
              const YMargin(30),
              ClassName(
                provider,
                isDarkTheme: true,
              ),
              const YMargin(30),
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Text(
                  'Select Day',
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'GalanoGrotesque',
                      color: Colors.white),
                ),
              ),
              Container(
                height: 50,
                margin: EdgeInsets.only(left: 17, top: 8),
                child: new ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sampleData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new InkResponse(
                      onTap: () {
                        setState(() {
                          sampleData
                              .forEach((element) => element.isSelected = false);
                          sampleData[index].isSelected = true;
                          provider.dayTEC.text = sampleData[index].day;
                        });
                      },
                      child: new Days(sampleData[index]),
                    );
                  },
                ),
              ),
              const YMargin(20),
              StartTime(provider, isDarkTheme: true, onTap: () async {
                provider.kTimeStart = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());

                if (provider.kTimeStart != null) {
                  var timePeriod = provider.kTimeStart.minute > 10
                      ? ':${provider.kTimeStart.minute}'
                      : ':0${provider.kTimeStart.minute}';
                  provider.startTime.text =
                      '${provider.kTimeStart.hour}$timePeriod ${provider.kTimeStart.period.index == 0 ? 'AM' : 'PM'}';
                } else {
                  provider.startTime.text = '';
                  provider.kTimeStart = null;
                }
              }),
              EndTime(provider, isDarkTheme: true, onTap: () async {
                provider.kTimeEnd = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                if (provider.kTimeEnd != null) {
                  var timePeriod = provider.kTimeEnd.minute > 10
                      ? ':${provider.kTimeEnd.minute}'
                      : ':0${provider.kTimeEnd.minute}';
                  provider.endTime.text =
                      '${provider.kTimeEnd.hour}$timePeriod ${provider.kTimeEnd.period.index == 0 ? 'AM' : 'PM'}';
                } else {
                  provider.endTime.text = '';
                  provider.kTimeStart = null;
                }
              }),
              Location(
                provider,
                isDarkTheme: true,
              ),
              const YMargin(10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  '* Please make sure that this class is accurate and that it is update incase of changes',
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
                          provider.dialog(context);
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

class Days extends StatelessWidget {
  final RadioModel _item;
  Days(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      margin: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: _item.isSelected ? white : Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(_item.day.toUpperCase(), // Month
                style: TextStyle(
                  color: _item.isSelected ? blue : white,
                  fontSize: 14,
                  fontFamily: 'GalanoGrotesque',
                  fontWeight: FontWeight.w200,
                )),
          ],
        ),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String day;

  RadioModel(this.isSelected, this.day);
}

class CreateAssignment extends StatefulWidget {
  const CreateAssignment({Key key}) : super(key: key);

  @override
  _CreateAssignmentState createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  var formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);

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
          key: formKey,
          child: ListView(
            children: <Widget>[
              const YMargin(10),
              Image.asset(
                'assets/images/clip-2.png',
                scale: 4,
              ),
              Center(
                child: Text(
                  'Add a new Assignment for class',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 19, color: white),
                ),
              ),
              const YMargin(30),
              TitleM(
                provider,
                isDarkTheme: true,
              ),
              const YMargin(20),
              DueDate(provider, isDarkTheme: true, onTap: () async {
                var date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1800),
                    initialDate: DateTime.now(),
                    lastDate: DateTime(3000));

                var timeDue = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());

                provider.kTimeDue =
                    DateTime(date.year, date.day, date.month, timeDue.hour, timeDue.minute);
                print(provider.kTimeDue);

                if (provider.kTimeDue != null) {
                  provider.dueDate.text =
                      DateFormat.MMMMEEEEd(). format(provider.kTimeDue)+ ' - ' + DateFormat.jm().format(provider.kTimeDue);
                } else {
                  provider.dueDate.text = '';
                }
              }),
              
              Desc(
                provider,
                isDarkTheme: true,
              ),
              const YMargin(10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  '* Please make sure that this Assignment is accurate and that it is update incase of changes',
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
                          provider.addAssignment(context, formKey);
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
