import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nudge/models/classModel.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/models/teacherModel.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/views/tabs/providers/calendarProvider.dart';
import 'package:provider/provider.dart';

var day = DateFormat("E").format(DateTime.now()).toUpperCase();

class Calendar extends StatefulWidget {
  final StudentModel studentModel;
  Calendar({Key key, this.studentModel}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

   CalendarProvider provider;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    await Future.delayed(Duration(milliseconds: 600));
    provider.persistData(context);
  }


  @override
  Widget build(BuildContext context) {
     provider = Provider.of<CalendarProvider>(context);
    provider.studentModel = widget.studentModel;
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
                  provider.currentDate,
                  selectionColor: blue,
                  provider: provider,
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[BuildUI(context, provider: provider)],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class BuildUI extends StatelessWidget {
  final CalendarProvider provider;
  final homeContext;

  const BuildUI(this.homeContext, {Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: provider.classList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return EmptyUI();
        return BuildFeedList(snapshot.data.documents, provider, homeContext);
      },
    );
  }
}

class BuildFeedList extends StatelessWidget {
  final List<DocumentSnapshot> snapshot;
  final CalendarProvider provider;
  final homeContext;
  const BuildFeedList(this.snapshot, this.provider, this.homeContext);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (snapshot.length > 0)
          for (DocumentSnapshot data in snapshot)
            if (provider.day == data['day']) CalendarItem(data)
      ],
    );
  }
}

class EmptyUI extends StatelessWidget {
  const EmptyUI({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Opacity(
            opacity: 0.2,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://media.istockphoto.com/vectors/open-box-icon-vector-id635771440?k=6&m=635771440&s=612x612&w=0&h=IESJM8lpvGjMO_crsjqErVWzdI8sLnlf0dljbkeO7Ig=',
                          scale: 3))),
            ),
          ),
          const YMargin(10),
          Text(
            'You Don\'t have any class today...',
            style: TextStyle(fontSize: 13),
          ),
          const YMargin(20),
        ],
      ),
    );
  }
}

class CalendarItem extends StatefulWidget {
  final data;
  CalendarItem(this.data);

  @override
  _CalendarItemState createState() => _CalendarItemState();
}

class _CalendarItemState extends State<CalendarItem> {
  TeacherModel teacher;

  fetchTeacher(id) async {
    var querySnapshot =
        await Firestore.instance.collection("teachers").document('$id').get();

    setState(() {
      teacher = (querySnapshot.data != null)
          ? TeacherModel.fromSnapshot(querySnapshot)
          : null;
    });
  }

  @override
  void initState() {
    var classModel = ClassModel.fromSnapshot(widget.data);
    fetchTeacher(classModel.teacher);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var classModel = ClassModel.fromSnapshot(widget.data);
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
                DateFormat?.Hm()?.format(classModel?.startTime?.toDate()),
                style: TextStyle(
                    color: text,
                    fontFamily: 'GalanoGrotesque2',
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              const XMargin(5),
              Text(
                DateFormat?.jm()
                        ?.format(classModel?.startTime?.toDate())
                        ?.split(' ')[1] ??
                    '',
                style: TextStyle(
                    color: text, fontWeight: FontWeight.w100, fontSize: 16),
              ),
              Spacer(),
              Text(
                _printDuration(classModel.endTime
                    .toDate()
                    .difference(classModel.startTime.toDate())),
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
                  classModel?.name ?? '',
                  maxLines: 2,
                  style: TextStyle(
                      color: text,
                      fontFamily: 'GalanoGrotesque2',
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                Text(
                  classModel.desc ?? '',
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
                          teacher?.name ?? '',
                          style: TextStyle(
                              color: text,
                              fontFamily: 'GalanoGrotesque2',
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        Text(
                          teacher?.phone ?? '',
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
                          classModel?.location ?? '',
                          style: TextStyle(
                              color: text,
                              fontFamily: 'GalanoGrotesque2',
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
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

String _printDuration(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n" == '00' ? '' : '$n';
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  //String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours) != '' ? twoDigits(duration.inHours) + ' h' : ''}${twoDigitMinutes != '' ? twoDigitMinutes + ' m' : ''}";
}
