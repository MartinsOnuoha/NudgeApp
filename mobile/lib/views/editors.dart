import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nudge/models/notesModel.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/widgets/textFields.dart';
import 'package:provider/provider.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

import 'tabs/providers/notesProvider.dart';

class EditorPage extends StatefulWidget {
  @override
  EditorPageState createState() => EditorPageState();
}

class EditorPageState extends State<EditorPage> {
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
    _loadDocument().then((document) {
      setState(() {
        title.text = 'New Note';
        _controller = ZefyrController(document);
      });
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

  /// Loads the document asynchronously from a file if it exists, otherwise
  /// returns default document.
  Future<NotusDocument> _loadDocument() async {
    final file = File(Directory.systemTemp.path + "/quick_start.json");
    if (await file.exists()) {
      final contents = await file
          .readAsString()
          .then((data) => Future.delayed(Duration(seconds: 1), () => data));
      return NotusDocument.fromJson(json.decode(contents));
    }
    final Delta delta = Delta()..insert("Type Something\n");
    return NotusDocument.fromDelta(delta);
  }

  void _saveDocument() {
    // Notus documents can be easily serialized to JSON by passing to
    // `jsonEncode` directly:
    final contents = json.encode(_controller.document);
    // For this example we save our document to a temporary file.
    final file = File(Directory.systemTemp.path + "/quick_start.json");
    // And show a snack bar on success.
    file.writeAsString(contents).then((_) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Saved.")));
    });
  }

  void _saveToFirebase(context) async {
    if (_controller.document != null &&
        _controller.document.toPlainText().isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      var provider = Provider.of<NotesProvider>(context);

      final contents = json.encode(_controller.document);

      await Firestore.instance
          .collection('student')
          .document(provider?.studentModel?.reference?.documentID ?? provider?.studentModel?.studentID)
          .collection('notes')
          .add(NotesModel(
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

  @override
  void dispose() {
    _saveDocument();
    super.dispose();
  }
}
