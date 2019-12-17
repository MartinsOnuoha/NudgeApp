import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nudge/models/assignmentModel.dart';
import 'package:nudge/models/classModel.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/utils/fade_route.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/utils/timeago.dart';
import 'package:nudge/views/tabs/providers/homeProvider.dart';
import 'package:nudge/widgets/dialog.dart';
import 'package:provider/provider.dart';

import '../viewAssignment.dart';

class Home extends StatefulWidget {
  final StudentModel studentModel;

  const Home({Key key, @required this.studentModel}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeProvider provider;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    await Future.delayed(Duration(milliseconds: 600));
   
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<HomeProvider>(context);
    provider.studentModel = widget.studentModel;
     provider.saveNextClass(context);
    
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
                  'Hi ${widget?.studentModel?.firstName ??''}',
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
                  physics: BouncingScrollPhysics(),
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
                            '(${provider.classLength})',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w200,
                                fontSize: 14),
                          ),
                          Spacer(),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Material(
                              color: white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: InkResponse(
                                  onTap: () {
                                    provider.isClassExpanded =
                                        !provider.isClassExpanded;
                                  },
                                  child: Text(
                                    provider.isClassExpanded
                                        ? 'Hide'
                                        : 'See all',
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
                    BuildUI(
                      context,
                      provider: provider,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        widget?.studentModel?.isAdmin ?? false
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        FadeRoute(
                                          builder: (context) => AddClass(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      '+ Add Class',
                                      style: TextStyle(
                                          color: blue,
                                          fontFamily: 'GalanoGrotesque2',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
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
                              color: white,
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
                    BuildAsst(
                      context,
                      provider: provider,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        widget?.studentModel?.isAdmin ?? false
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        FadeRoute(
                                          builder: (context) =>
                                              CreateAssignment(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      '+ Add Assignment',
                                      style: TextStyle(
                                          color: blue,
                                          fontFamily: 'GalanoGrotesque2',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
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

class BuildUI extends StatelessWidget {
  final HomeProvider provider;
  final homeContext;

  const BuildUI(this.homeContext, {Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: provider.classList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.documents.length <=0 ) return EmptyUI();
        return BuildFeedList(snapshot.data.documents, provider, homeContext);
      },
    );
  }
}

class BuildFeedList extends StatelessWidget {
  final List<DocumentSnapshot> snapshot;
  final HomeProvider provider;
  final homeContext;
  const BuildFeedList(this.snapshot, this.provider, this.homeContext);

  @override
  Widget build(BuildContext context) {
    provider.classLength = provider.classLength < snapshot.length
        ? snapshot.length
        : provider.classLength;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (snapshot.length > 0)
            for (DocumentSnapshot data in snapshot) ClassWidget(data: data)
        ],
      ),
    );
  }
}

class BuildAsst extends StatelessWidget {
  final HomeProvider provider;
  final homeContext;

  const BuildAsst(this.homeContext, {Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: provider.assignmentList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.documents.length <=0 ) return EmptyAss();
        return BuildFeedBuildAsstList(
            snapshot.data.documents, provider, homeContext);
      },
    );
  }
}

class BuildFeedBuildAsstList extends StatelessWidget {
  final List<DocumentSnapshot> snapshot;
  final HomeProvider provider;
  final homeContext;
  const BuildFeedBuildAsstList(this.snapshot, this.provider, this.homeContext);

  @override
  Widget build(BuildContext context) {
    provider.assLength = provider.assLength < snapshot.length
        ? snapshot.length
        : provider.assLength;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 210,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            if (snapshot.length > 0)
              for (DocumentSnapshot data in snapshot)
                AssignmentWidget(data: data)
          ],
        ),
      ),
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
class EmptyAss extends StatelessWidget {
  const EmptyAss({
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
            'You Don\'t have any pending assignments...',
            style: TextStyle(fontSize: 13),
          ),
          const YMargin(20),
        ],
      ),
    );
  }
}

class ClassWidget extends StatelessWidget {
  final data;
  const ClassWidget({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var classModel = ClassModel.fromSnapshot(data);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9),
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
                    DateFormat?.Hm()?.format(classModel?.startTime?.toDate()) ??
                        '',
                    style: TextStyle(
                        color: black,
                        fontFamily: 'GalanoGrotesque2',
                        fontWeight: FontWeight.w700,
                        fontSize: 14),
                  ),
                  const YMargin(5),
                  Text(
                    DateFormat?.jm()
                        ?.format(classModel?.startTime?.toDate())
                        ?.split(' ')[1],
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
              padding: const EdgeInsets.only(top: 9, left: 15),
              child: Container(
                width: screenWidth(context, percent: 0.6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      classModel?.name ?? '',
                      style: TextStyle(
                          color: Color(0xff4E4E4E),
                          fontFamily: 'GalanoGrotesque2',
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    const YMargin(5),
                    Container(
                      width: screenWidth(context, percent: 0.6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: lightText,
                          ),
                          const XMargin(5),
                          Container(
                            width: screenWidth(context, percent: 0.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  classModel?.location ?? '',
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

class AssignmentWidget extends StatelessWidget {
  final data;
  const AssignmentWidget({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var asstModel = AssignmentModel.fromSnapshot(data);
    return InkResponse(
      onTap: () {
        Navigator.of(context).push(
          FadeRoute(
            builder: (context) => ViewAssignment(
              assignmentModel: asstModel,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
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
                  '${_printDuration(asstModel.dueDate.toDate().difference(DateTime.now()))} left',
                  style: TextStyle(
                      color: black, fontWeight: FontWeight.w300, fontSize: 16),
                ),
              ],
            ),
            const YMargin(5),
            Text(
              asstModel?.title ?? '',
              style: TextStyle(
                  color: black,
                  fontFamily: 'GalanoGrotesque2',
                  fontWeight: FontWeight.w300,
                  fontSize: 17),
            ),
          ],
        ),
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
  return "${twoDigits(duration.inHours) != '' ? twoDigits(duration.inDays) + ' Days' : ''}";
}
