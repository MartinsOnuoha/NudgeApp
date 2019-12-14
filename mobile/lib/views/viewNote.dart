import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nudge/models/notesModel.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/widgets/textFields.dart';
import 'package:provider/provider.dart';
import 'package:zefyr/zefyr.dart';

import 'tabs/providers/notesProvider.dart';

class ViewNote extends StatefulWidget {
  final NotusDocument document;
  final NotesModel notesModel;

  const ViewNote({Key key, this.document, this.notesModel}) : super(key: key);
  @override
  ViewNoteState createState() => ViewNoteState();
}

class ViewNoteState extends State<ViewNote> {
  /// Allows to control the editor and the document.
  ZefyrController _controller;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;
  bool isLoading = false;

  final TextEditingController title = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    setState(() {
      title.text = widget.notesModel.title;
      _controller = ZefyrController(widget.document);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget body = (_controller == null)
        ? Center(child: CircularProgressIndicator())
        : ZefyrScaffold(
            child: ZefyrTheme(
                data: new ZefyrThemeData(
                  linkStyle:
                      TextStyle(fontSize: 19, fontFamily: 'GalanoGrotesque'),
                  cursorColor: Colors.blue,
                  toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
                    color: Colors.white,
                    toggleColor: Colors.grey.shade200,
                    iconColor: blue,
                    disabledIconColor: Colors.grey.shade200,
                  ),
                ),
                child: ZefyrEditor(
                  padding: EdgeInsets.all(16),
                  controller: _controller,
                  focusNode: _focusNode,
                )));

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: blue),
        title: NewNoteTitle(
          controller: title,
        ),
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: white,
        actions: <Widget>[
          Builder(
            builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                !isLoading
                    ? Container(
                        height: 40,
                        width: 80,
                        margin: EdgeInsets.all(8),
                        child: FlatButton(
                          color: white,
                          textColor: blue,
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'GalanoGrotesque2'),
                          ),
                          onPressed: () => _saveToFirebase(context),
                        ),
                      )
                    : Container(
                        height: 35,
                        width: 35,
                        margin: EdgeInsets.all(10),
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          )
        ],
      ),
      body: body,
    );
  }

  void _saveToFirebase(context) async {
    setState(() {
      isLoading = true;
    });
    var provider = Provider.of<NotesProvider>(context);

    final contents = json.encode(_controller.document);

    await Firestore.instance
        .collection('student')
        .document(provider?.studentModel?.reference?.documentID ?? provider?.studentModel?.studentID)
        .collection('notes')
        .document(widget.notesModel.reference.documentID)
        .updateData(NotesModel(
          title: title.text,
          desc: contents,
          isImportant: false,
          timeStamp: Timestamp.now(),
        ).toJson())
        .then((_) {
      setState(() {
        isLoading = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Uploaded.")));
      Navigator.pop(context);
    });
  }

}
