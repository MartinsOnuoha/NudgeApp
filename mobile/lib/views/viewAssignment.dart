import 'package:flutter/material.dart';
import 'package:nudge/models/assignmentModel.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';

class ViewAssignment extends StatefulWidget {
  final AssignmentModel assignmentModel;
  const ViewAssignment({Key key, @required this.assignmentModel})
      : super(key: key);
  @override
  ViewAssignmentState createState() => ViewAssignmentState();
}

class ViewAssignmentState extends State<ViewAssignment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: white,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          widget?.assignmentModel?.title ?? '',
          style: TextStyle(
              color: black,
              fontFamily: 'GalanoGrotesque2',
              fontWeight: FontWeight.w300,
              fontSize: 17),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ListView(
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
                  '${_printDuration(widget?.assignmentModel?.dueDate?.toDate()?.difference(DateTime.now()))} left',
                  style: TextStyle(
                      color: black, fontWeight: FontWeight.w300, fontSize: 16),
                ),
              ],
            ),
            
            const YMargin(35),
            Text(
              widget?.assignmentModel?.desc ?? '',
              style: TextStyle(
                  color: text,
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
