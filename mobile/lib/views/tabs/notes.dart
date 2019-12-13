import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nudge/models/notesModel.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/utils/fade_route.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/widgets/dialog.dart';
import 'package:provider/provider.dart';
import 'package:spring_button/spring_button.dart';
import 'package:zefyr/zefyr.dart';

import '../editors.dart';
import '../viewNote.dart';
import 'providers/notesProvider.dart';

class Notes extends StatefulWidget {
  final StudentModel studentModel;

  const Notes({Key key, this.studentModel}) : super(key: key);
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NotesProvider>(context);
    provider.studentModel = widget.studentModel;

    provider.updater();

    return Scaffold(
      body: ListView(
        children: <Widget>[
          const YMargin(20),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 40),
            child: Text(
              'Notes.',
              style: TextStyle(
                  color: blue,
                  fontFamily: 'GalanoGrotesque2',
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            ),
          ),
          const YMargin(30),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: screenHeight(context, percent: 0.25),
                  width: screenHeight(context, percent: 0.19),
                  padding: const EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(31),
                    boxShadow: [
                      new BoxShadow(
                        offset: Offset(0, 10),
                        spreadRadius: -12,
                        color: blue.withOpacity(0.5),
                        blurRadius: 18,
                      ),
                    ],
                    color: Color(0xff3B76FF),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Notes',
                        style: TextStyle(
                            color: white,
                            fontFamily: 'GalanoGrotesque2',
                            fontWeight: FontWeight.w400,
                            fontSize: 21),
                      ),
                      Spacer(),
                      Text(
                        '${provider.notesLength}',
                        style: TextStyle(
                            color: white,
                            fontFamily: 'GalanoGrotesque2',
                            fontWeight: FontWeight.w400,
                            fontSize: 29),
                      ),
                    ],
                  ),
                ),
                const XMargin(10),
                Container(
                  height: screenHeight(context, percent: 0.25),
                  width: screenHeight(context, percent: 0.19),
                  padding: const EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(31),
                    color: Color(0xffF6F7FB),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Important',
                        style: TextStyle(
                            color: lightText,
                            fontFamily: 'GalanoGrotesque2',
                            fontWeight: FontWeight.w400,
                            fontSize: 21),
                      ),
                      Spacer(),
                      Text(
                        '${provider.importantNotesLength}',
                        style: TextStyle(
                            color: black,
                            fontFamily: 'GalanoGrotesque2',
                            fontWeight: FontWeight.w400,
                            fontSize: 28),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Row(
              children: <Widget>[
                InkResponse(
                  onTap: () {
                    provider.tab = 0;
                  },
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Notes',
                        style: TextStyle(
                            color: provider.tab == 0 ? black : lightText,
                            fontFamily: 'GalanoGrotesque2',
                            fontWeight: FontWeight.w400,
                            fontSize: 22),
                      ),
                      Container(
                        height: 30,
                        width: 80,
                        decoration: provider.tab == 0
                            ? BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('assets/icons/line.png')))
                            : null,
                      )
                    ],
                  ),
                ),
                Spacer(),
                InkResponse(
                  onTap: () {
                    provider.tab = 1;
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Important',
                        style: TextStyle(
                            color: provider.tab == 1 ? black : lightText,
                            fontFamily: 'GalanoGrotesque2',
                            fontWeight: FontWeight.w400,
                            fontSize: 22),
                      ),
                      Container(
                        height: 30,
                        width: 80,
                        decoration: provider.tab == 1
                            ? BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('assets/icons/line.png')))
                            : null,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          BuildUI(
            context,
            provider: provider,
          ),
        ],
      ),
      floatingActionButton: SpringButton(
        SpringButtonType.OnlyScale,
        Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(131),
              boxShadow: [
                new BoxShadow(
                  offset: Offset(0, 10),
                  spreadRadius: -9,
                  color: blue.withOpacity(0.6),
                  blurRadius: 18,
                ),
              ],
              color: Color(0xff3B76FF),
            ),
            child: Center(
              child: Icon(
                Icons.add,
                color: white,
                size: 33,
              ),
            )),
        onTap: () {
          Navigator.of(context).push(
            FadeRoute(
              builder: (context) => EditorPage(),
            ),
          );
        },
      ),
    );
  }
}

class BuildUI extends StatelessWidget {
  final NotesProvider provider;
  final homeContext;

  const BuildUI(this.homeContext, {Key key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: provider.notesList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return EmptyUI();
        return BuildFeedList(snapshot.data.documents, provider, homeContext);
      },
    );
  }
}

class BuildFeedList extends StatelessWidget {
  final List<DocumentSnapshot> snapshot;
  final NotesProvider provider;
  final homeContext;
  const BuildFeedList(this.snapshot, this.provider, this.homeContext);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (snapshot.length > 0)
            for (DocumentSnapshot data in snapshot)
              if (provider.tab == 1)
                if (data.data['isImportant'])
                  NotesWidget(data: data)
                else
                  Container()
              else
                NotesWidget(data: data)
        ],
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

class NotesWidget extends StatelessWidget {
  final data;
  const NotesWidget({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notesModel = NotesModel.fromSnapshot(data);
    return InkResponse(
      onTap: () {
        Navigator.of(context).push(
          FadeRoute(
            builder: (context) => ViewNote(
              notesModel: notesModel,
              document: NotusDocument.fromJson(json.decode(notesModel?.desc)),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
            color: Color(0xffF4F4F4).withOpacity(0.7),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 9, left: 19, right: 9),
                child: Container(
                  width: screenWidth(context, percent: 0.7),
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            notesModel?.title ?? '',
                            style: TextStyle(
                                color: black,
                                fontFamily: 'GalanoGrotesque2',
                                fontWeight: FontWeight.w400,
                                fontSize: 19),
                          ),
                          Spacer(),
                          Text(
                            DateFormat("jm")
                                .format(notesModel.timeStamp.toDate()),
                            style: TextStyle(
                                color: Color(0xffCCC2D8),
                                fontWeight: FontWeight.w300,
                                fontFamily: 'GalanoGrotesque2',
                                fontSize: 15),
                          ),
                        ],
                      ),
                      const YMargin(5),
                      Text(
                        NotusDocument.fromJson(json.decode(notesModel?.desc))
                                .toPlainText() ??
                            '',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: lightText,
                            fontWeight: FontWeight.w200,
                            fontSize: 14),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            DateFormat("d")
                                .format(notesModel.timeStamp.toDate()),
                            style: TextStyle(
                                color: Color(0xffCCC2D8),
                                fontWeight: FontWeight.w300,
                                fontFamily: 'GalanoGrotesque2',
                                fontSize: 15),
                          ),
                          const XMargin(5),
                          Text(
                            DateFormat("MMM")
                                .format(notesModel.timeStamp.toDate()),
                            style: TextStyle(
                                color: Color(0xffCCC2D8),
                                fontWeight: FontWeight.w300,
                                fontFamily: 'GalanoGrotesque2',
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ],
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
