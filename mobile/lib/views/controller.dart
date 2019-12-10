import 'package:flutter/material.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/providers/controllerProvider.dart';
import 'package:provider/provider.dart';

class Controller extends StatefulWidget {
  final StudentModel studentModel;
  Controller({Key key, /* @required  */this.studentModel}) : super(key: key);

  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ControllerProvider>(context);
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: provider.currentTab[provider.currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Color(0xffF9F9FC),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xff7D79B2),
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/icons/home.png',
              scale: 2.8,
              color: provider.currentIndex == 0
                  ? Color(0xff7D79B2)
                  : Colors.grey[400],
            ),
            title: new Text(''),
          ),
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/icons/pages.png',
              scale: 2.8,
              color: provider.currentIndex == 1
                  ? Color(0xff7D79B2)
                  : Colors.grey[400],
            ),
            title: new Text(''),
          ),
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/icons/calendar.png',
              scale: 2.8,
              color: provider.currentIndex == 2
                  ? Color(0xff7D79B2)
                  : Colors.grey[400],
            ),
            title: new Text(''),
          ),
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/icons/note.png',
              scale: 2.8,
              color: provider.currentIndex == 3
                  ? Color(0xff7D79B2)
                  : Colors.grey[400],
            ),
            title: new Text(''),
          ),
          BottomNavigationBarItem(
            icon: new Image.asset(
              'assets/icons/chat.png',
              scale: 2.8,
              color: provider.currentIndex == 4
                  ? Color(0xff7D79B2)
                  : Colors.grey[400],
            ),
            title: Text(''),
          )
        ],
      ),
    );
  }
}
