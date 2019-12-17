import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nudge/auth/signup.dart';
import 'package:nudge/auth/updateInfo.dart';
import 'package:nudge/chat/providers/chatProvider.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/providers/controllerProvider.dart';
import 'package:nudge/utils/baseAuth.dart';
import 'package:nudge/utils/persistence.dart';
import 'package:nudge/utils/theme.dart';
import 'package:provider/provider.dart';

import 'auth/login.dart';
import 'auth/updateDepartment.dart';
import 'providers/createClassProvider.dart';
import 'providers/updateDeptProvider.dart';
import 'providers/updateInfoProvider.dart';
import 'utils/fade_route.dart';
import 'views/controller.dart';
import 'views/rewards.dart';
import 'views/tabs/providers/calendarProvider.dart';
import 'views/tabs/providers/homeProvider.dart';
import 'views/tabs/providers/notesProvider.dart';
import 'views/tabs/providers/profileProvider.dart';
import 'widgets/logo.dart';

import 'providers/signupProvider.dart';
import 'providers/loginProvider.dart';

import 'package:flutter/services.dart';

import 'package:background_fetch/background_fetch.dart';
import 'package:nudge/models/classModel.dart';

import 'api/apiRequest.dart';
import 'models/studentModel.dart';
import 'utils/persistence.dart';

/// This "Headless Task" is run when app is terminated.
void backgroundFetchHeadlessTask() async {
  print('[BackgroundFetch] Headless event received.');
  BackgroundFetch.finish();
}

void main() {
  // Enable integration testing with the Flutter Driver extension.
  // See https://flutter.io/testing/ for more info.
  runApp(new MyApp());

  // Register to receive BackgroundFetch events after app is terminated.
  // Requires {stopOnTerminate: false, enableHeadless: true}
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: 'Nudge',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'GalanoGrotesque',
            primarySwatch: Colors.blue,
            accentColor: blue,
            primaryColor: blue),
        home: Splash(),
      ),
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider(builder: (_) => ControllerProvider()),
        ChangeNotifierProvider(builder: (_) => CalendarProvider()),
        ChangeNotifierProvider(builder: (_) => LoginProvider()),
        ChangeNotifierProvider(builder: (_) => SignupProvider()),
        ChangeNotifierProvider(builder: (_) => UpdateInfoProvider()),
        ChangeNotifierProvider(builder: (_) => UpdateDeptProvider()),
        ChangeNotifierProvider(builder: (_) => CreateClassProvider()),
        ChangeNotifierProvider(builder: (_) => HomeProvider()),
        ChangeNotifierProvider(builder: (_) => NotesProvider()),
        ChangeNotifierProvider(builder: (_) => ChatProvider()),
        ChangeNotifierProvider(builder: (_) => ProfileProvider()),
      ],
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  BaseAuth auth = new Auth();

  @override
  void initState() {
    loadData();

    initPlatformState();
    super.initState();
  }

  int _status = 0;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(
        BackgroundFetchConfig(
            minimumFetchInterval: 15,
            stopOnTerminate: false,
            enableHeadless: false,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: BackgroundFetchConfig.NETWORK_TYPE_NONE),
        () async {
      // This is the fetch-event callback.
      print('[BackgroundFetch] Event received');
      try {
        var studentModel = StudentModel.fromJson(
            json.decode(await getItemData(key: 'userModel')));

        var classModel = ClassModel.fromJson(
            json.decode(await getItemData(key: 'nextClass')));
        if (classModel != null && studentModel != null) {
          var classModel = ClassModel.fromJson(
              json.decode(await getItemData(key: 'nextClass')));
          // print(classM.toJson());

          var compareTime = DateTime.parse(classModel.startTime).difference(
              DateTime(
                  1969, 1, 1, TimeOfDay.now().hour, TimeOfDay.now().minute));
          print(compareTime.inMinutes);
          if (compareTime.inMinutes > 0 &&
              compareTime.inMinutes <= 30 &&
              (await getItemData(key: 'hascalled')) != 'true') {
            saveItem(key: 'hascalled', item: true.toString());
            await NudgeServices.call(
              context,
              message:
                  'Hello, you have ${classModel.name} in ${compareTime.inMinutes} Minutes)}',
              phone: '${studentModel.phone}',
            );
          }
        } else {
          eraseItem(key: 'hascalled');
          eraseItem(key: 'nextClass');
        }
      } catch (e) {}

      // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
      // for taking too long in the background.
      BackgroundFetch.finish();
    }).then((int status) {
      print('[BackgroundFetch] configure success: $status');
      setState(() {
        _status = status;
      });
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
      setState(() {
        _status = e;
      });
    });

    // Optionally query the current BackgroundFetch status.
    int status = await BackgroundFetch.status;
    setState(() {
      _status = status;
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  loadData() async {
    try {
      await Future.delayed(Duration(seconds: 4));
      var user = await auth.getCurrentUser();
      if (user != null) {
        var _studentModel = await auth.getStudentProfileData(user.uid);
        if (_studentModel != null) {
          if (_studentModel.school == null) {
            Navigator.of(context).pushReplacement(
              FadeRoute(
                builder: (context) => UpdateInfo(
                  studentModel: _studentModel,
                ),
              ),
            );
          } else if (_studentModel.classID == null) {
            Navigator.of(context).pushReplacement(
              FadeRoute(
                builder: (context) => UpdateDepartment(),
              ),
            );
          } else {
            Navigator.of(context).pushReplacement(
              FadeRoute(
                builder: (context) => Controller(
                  studentModel: _studentModel,
                ),
              ),
            );
          }
        }
      } else {
        throw 'Logged Out';
      }
    } catch (e) {
      print(e.toString());
      Navigator.of(context).pushReplacement(
        FadeRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: white,
          elevation: 0,
          brightness: Brightness.light,
        ),
        preferredSize: Size.fromHeight(0),
      ),
      body: Logo(),
    );
  }
}
