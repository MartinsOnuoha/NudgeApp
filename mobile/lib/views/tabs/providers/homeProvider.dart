import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nudge/models/classModel.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/widgets/textFields.dart';

class HomeProvider extends ChangeNotifier {
  final TextEditingController classTEC = new TextEditingController();
  final TextEditingController locationTEC = new TextEditingController();
  final TextEditingController dayTEC = new TextEditingController();
  final TextEditingController startTime = new TextEditingController();
  final TextEditingController endTime = new TextEditingController();

  StudentModel studentModel;
  var formKey = GlobalKey<FormState>();

  TimeOfDay _kTimeStart;
  TimeOfDay get kTimeStart => _kTimeStart;

  TimeOfDay _kTimeEnd;
  TimeOfDay get kTimeEnd => _kTimeEnd;

  int classLength = 0;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isClassExpanded = false;
  bool get isClassExpanded => _isClassExpanded;

  set kTimeStart(TimeOfDay val) {
    _kTimeStart = val;
    notifyListeners();
  }

  set kTimeEnd(TimeOfDay val) {
    _kTimeEnd = val;
    notifyListeners();
  }

  set isClassExpanded(bool val) {
    _isClassExpanded = val;
    notifyListeners();
  }

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Stream<QuerySnapshot> classList() {
    var t = DateFormat("E").format(DateTime.now()).toUpperCase();

    return !_isClassExpanded
        ? Firestore.instance
            .collection('classes')
            .document(studentModel.classID)
            .collection('timetable')
            .where('day', isEqualTo: t)
            .orderBy('startTime')
            .where(
              'startTime',
              isGreaterThanOrEqualTo: DateTime(
                  1969, 1, 1, TimeOfDay.now().hour, TimeOfDay.now().hour),
            )
            .limit(1)
            .snapshots()
        : Firestore.instance
            .collection('classes')
            .document(studentModel.classID)
            .collection('timetable')
            .where('day', isEqualTo: t)
            .orderBy('startTime')
            .snapshots();
  }

  void addClass(BuildContext context, kTeacher) async {
    try {
      if (formKey.currentState.validate()) {
        _isLoading = true;
        notifyListeners();
        await Firestore.instance
            .collection('classes')
            .document(studentModel.classID)
            .collection('timetable')
            .add(ClassModel(
              day: dayTEC.text,
              name: classTEC.text,
              teacher: kTeacher,
              location: locationTEC.text,
              startTime: Timestamp.fromDate(
                DateTime(1969, 1, 1, kTimeStart.hour, kTimeStart.minute),
              ),
              endTime: Timestamp.fromDate(
                DateTime(1969, 1, 1, kTimeEnd.hour, kTimeEnd.minute),
              ),
            ).toJson());
        _isLoading = false;
        dayTEC.text = '';
        classTEC.text = '';
        kTeacher = '';
        locationTEC.text = '';
        notifyListeners();
        Navigator.pop(context);
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }

  dialog(_) async {
    var isSearching = false;
    TextEditingController filter = new TextEditingController();

    var teachers =
        await Firestore.instance.collection('teachers').getDocuments();

    listView() => ListView.builder(
          itemCount: teachers.documents.length,
          itemBuilder: (BuildContext context, int index) {
            if (isSearching) {
              if (teachers.documents[index].data['name']
                  .toString()
                  .toLowerCase()
                  .contains(filter.text.toString().toLowerCase()))
                return ListTile(
                  onTap: () {
                    addClass(_, teachers.documents[index].documentID);
                    Navigator.pop(context);
                  },
                  leading: Image.asset(
                    'assets/icons/person.png',
                    scale: 1.5,
                    color: Color(0xffA3A9C1),
                  ),
                  title: Text(
                    teachers.documents[index].data['name'],
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'GalanoGrotesque',
                        color: Colors.white),
                  ),
                );
              else
                return Container();
            } else
              return ListTile(
                onTap: () {
                  addClass(_, teachers.documents[index].documentID);
                  Navigator.pop(context);
                },
                leading: Image.asset(
                  'assets/icons/person.png',
                  scale: 1.5,
                  color: white,
                ),
                title: Text(
                  teachers.documents[index].data['name'],
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'GalanoGrotesque',
                      color: Colors.white),
                ),
              );
          },
        );

    showDialog(
        context: _,
        builder: (_) => new AlertDialog(
              backgroundColor: blue,
              title: Column(
                children: <Widget>[
                  new Text(
                    "Choose A teacher",
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'GalanoGrotesque2',
                        color: Colors.white),
                  ),
                  const YMargin(20),
                  TeacherSearch(
                    controller: filter,
                    onChanged: (val) {
                      if (val.isNotEmpty)
                        isSearching = true;
                      else
                        isSearching = false;
                    },
                  )
                ],
              ),
              content: Container(
                width: screenWidth(_, percent: 0.8),
                height: screenHeight(_, percent: 0.5),
                child: listView(),
              ),
            ));
  }
}
