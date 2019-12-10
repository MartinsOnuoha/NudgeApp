import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';

class Calendar extends StatefulWidget {
  Calendar({Key key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF7F7F7),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.only(top: 160),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  )),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const YMargin(90),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Icon(
                      Icons.calendar_today,
                      color: Color(0xff7D79B2),
                      size: 30,
                    ),
                    const XMargin(20),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        DateFormat("MMM").format(DateTime.now()),
                        style: TextStyle(
                            color: Color(0xff242C67),
                            fontWeight: FontWeight.w700,
                            fontSize: 30),
                      ),
                    ),
                    const XMargin(10),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        DateFormat("y").format(DateTime.now()),
                        style: TextStyle(
                            color: Color(0xff242C67),
                            fontWeight: FontWeight.w300,
                            fontSize: 19),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Today',
                        style: TextStyle(
                            color: blue,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              const YMargin(30),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: DatePickerTimeline(
                  DateTime.now(),
                  selectionColor: blue,
                  onDateChange: (date) {
                    // print(date.day.toString());
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return new CalendarItem();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CalendarItem extends StatelessWidget {
  const CalendarItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 11,
                width: 19,
                decoration: BoxDecoration(
                    color: Color(0xffFDC07D),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    )),
              ),
              const XMargin(10),
              Text(
                '07:00',
                style: TextStyle(
                    color: text,
                    fontFamily: 'GalanoGrotesque2',
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              const XMargin(5),
              Text(
                'AM',
                style: TextStyle(
                    color: text, fontWeight: FontWeight.w100, fontSize: 16),
              ),
              Spacer(),
              Text(
                '1 h 45 min',
                style: TextStyle(
                    color: lightText,
                    fontWeight: FontWeight.w200,
                    fontSize: 16),
              ),
              const XMargin(15),
            ],
          ),
          Container(
            height: screenHeight(context, percent: 0.26),
            width: double.infinity,
            margin: EdgeInsets.all(10).add(EdgeInsets.only(left: 20, right: 8)),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                    width: 1.4, color: Color(0xffE3E3E3).withOpacity(0.5)),
                borderRadius: BorderRadius.circular(19)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Mathematic',
                  style: TextStyle(
                      color: text,
                      fontFamily: 'GalanoGrotesque2',
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                Text(
                  'Advanced Mathematic III : Vectors & Surds',
                  style: TextStyle(color: lightText, fontSize: 13),
                ),
                const YMargin(18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Image.asset(
                        'assets/icons/person.png',
                        scale: 1.5,
                        color: Color(0xffA3A9C1),
                      ),
                    ),
                    const XMargin(17),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Adeeze Biola',
                          style: TextStyle(
                              color: text,
                              fontFamily: 'GalanoGrotesque2',
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        Text(
                          '234 000 0000 000',
                          style: TextStyle(color: lightText, fontSize: 13),
                        ),
                      ],
                    )
                  ],
                ),
                const YMargin(18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Image.asset(
                        'assets/icons/locate.png',
                        scale: 1.5,
                        color: Color(0xffA3A9C1),
                      ),
                    ),
                    const XMargin(17),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Faculty of Mathematics Building',
                          style: TextStyle(
                              color: text,
                              fontFamily: 'GalanoGrotesque2',
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        Text(
                          'Room 412, 2nd floor',
                          style: TextStyle(color: lightText, fontSize: 13),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
