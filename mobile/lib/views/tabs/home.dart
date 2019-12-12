import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';

class Home extends StatefulWidget {
  final StudentModel studentModel;

  const Home({Key key, @required this.studentModel}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffE5F0FF),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.only(top: 250),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(42),
                    topRight: Radius.circular(42),
                  )),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const YMargin(50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const XMargin(20),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        DateFormat("E").format(DateTime.now()),
                        style: TextStyle(
                            color: Color(0xff242C67),
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    ),
                    const XMargin(4),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        DateFormat("d").format(DateTime.now()),
                        style: TextStyle(
                            color: Color(0xff242C67),
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      ),
                    ),
                    const XMargin(4),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        DateFormat("MMMM").format(DateTime.now()),
                        style: TextStyle(
                            color: Color(0xff242C67),
                            fontWeight: FontWeight.w300,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const YMargin(20),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 40),
                child: Text(
                  'Hi ${widget?.studentModel?.firstName}',
                  style: TextStyle(
                      color: Color(0xff333D8A),
                      fontFamily: 'GalanoGrotesque2',
                      fontWeight: FontWeight.w700,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14, left: 40),
                child: Text(
                  'Here is a list of schedule\nyou need to check…',
                  style: TextStyle(
                      color: Color(0xff333D8A),
                      fontWeight: FontWeight.w200,
                      fontSize: 14),
                ),
              ),
              const YMargin(49),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 9.0, left: 23, right: 23),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'TODAY CLASSES',
                            style: TextStyle(
                                color: black,
                                fontFamily: 'GalanoGrotesque2',
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          ),
                          const XMargin(5),
                          Text(
                            '(3)',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w200,
                                fontSize: 14),
                          ),
                          Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Material(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: InkResponse(
                                  onTap: () {},
                                  child: Text(
                                    'See all',
                                    style: TextStyle(
                                        color: blue,
                                        fontFamily: 'GalanoGrotesque2',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const YMargin(10),
                    for (var i = 0; i < 3; i++) new ClassWidget(),
                    const YMargin(20),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 9.0, left: 23, right: 23),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Assignments',
                            style: TextStyle(
                                color: black,
                                fontFamily: 'GalanoGrotesque2',
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          ),
                          const XMargin(5),
                          Text(
                            '(3)',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w200,
                                fontSize: 14),
                          ),
                          Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Material(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: InkResponse(
                                  onTap: () {},
                                  child: Text(
                                    'See all',
                                    style: TextStyle(
                                        color: blue,
                                        fontFamily: 'GalanoGrotesque2',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const YMargin(10),
                    Container(
                      width: screenWidth(context),
                      height: 240,
                      child: ListView.builder(
                        itemCount: 9,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 9),
                                width: 210,
                                height: 210,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Color(0xffFEF5F6).withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Deadine',
                                      style: TextStyle(
                                          color: Color(0xffCCCCCC),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '•',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 23),
                                        ),
                                        const XMargin(5),
                                        Text(
                                          '3 days left',
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    const YMargin(5),
                                    Text(
                                      'Design and Develop A Schedule for Students',
                                      style: TextStyle(
                                          color: black,
                                          fontFamily: 'GalanoGrotesque2',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ClassWidget extends StatelessWidget {
  const ClassWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
      decoration: BoxDecoration(
          color: Color(0xffF4F4F4).withOpacity(0.7),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 9, left: 19, right: 9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '09:30',
                    style: TextStyle(
                        color: black,
                        fontFamily: 'GalanoGrotesque2',
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  ),
                  const YMargin(5),
                  Text(
                    'AM',
                    style: TextStyle(
                        color: lightText,
                        fontWeight: FontWeight.w200,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            const XMargin(10),
            Container(
              width: 2,
              height: 90,
              color: Color(0xffE5E5E5),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9, left: 20),
              child: Container(
                width: screenWidth(context, percent: 0.6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Advanced Mathematic III : Vectors & Surds',
                      style: TextStyle(
                          color: Color(0xff4E4E4E),
                          fontFamily: 'GalanoGrotesque2',
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    const YMargin(5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: lightText,
                        ),
                        const XMargin(5),
                        Container(
                          width: screenWidth(context, percent: 0.5),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Room 412, Faculty of Mathematics',
                                style: TextStyle(
                                    color: lightText,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
