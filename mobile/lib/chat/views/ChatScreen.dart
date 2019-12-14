
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nudge/chat/providers/chatProvider.dart';
import 'package:nudge/chat/widgets/ChatMessageListItem.dart';
import 'package:nudge/models/studentClassModel.dart';
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';
import 'package:nudge/widgets/textFields.dart';
import 'package:provider/provider.dart';
//import 'package:image_picker/image_picker.dart';

var currentUserEmail;

class ChatScreen extends StatefulWidget {
  final reference;
  final StudentsClassModel studentsClassModel;
  final StudentModel sender;

  const ChatScreen(
      {Key key, this.reference, @required this.sender, this.studentsClassModel})
      : super(key: key);

  @override
  ChatScreenState createState() {
    return new ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ChatProvider>(context);
    provider.updateUserModel(widget.sender);
    return new Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.white.withOpacity(0.788), BlendMode.srcATop),
          fit: BoxFit.fill,
          image: NetworkImage(
              'https://user-images.githubusercontent.com/15075759/28719144-86dc0f70-73b1-11e7-911d-60d70fcded21.png'),
        ),
      ),
      child: Column(
        children: <Widget>[
          const YMargin(50),
          Padding(
              padding: const EdgeInsets.all(13),
              child: Container(
                width: screenWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${widget?.studentsClassModel?.department ?? ''} ${widget?.studentsClassModel?.year ?? ''}',
                      style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    Text(
                      '${widget?.studentsClassModel?.university ?? ''}',
                      style: TextStyle(
                        color: lightText,
                        fontWeight: FontWeight.w200,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )),
          Divider(),
          const YMargin(40),
          new Flexible(
            child: new FirebaseAnimatedList(
              query: widget.reference,
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              sort: (a, b) => b.key.compareTo(a.key),
              //comparing timestamp of messages to check which one would appear first
              itemBuilder: (_, DataSnapshot messageSnapshot,
                  Animation<double> animation, x) {
                return new ChatMessageListItem(
                  messageSnapshot: messageSnapshot,
                  animation: animation,
                  sender: widget.sender,
                );
              },
            ),
          ),
          provider.isLoading
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator()),
                )
              : Container(),
          Container(
            height: 49,
            width: screenWidth(context, percent: 0.9),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: -5,
                    color: Colors.blue.withOpacity(0.09),
                    blurRadius: 22,
                  ),
                ]),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.insert_emoticon),
                  color: blue3,
                ),
                Expanded(child: ChatBox(provider)),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: blue3,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: InkResponse(
                      onTap: provider.isComposingMessage
                          ? null
                          : () {
                              if (provider.textEditingController.text != null &&
                                  provider
                                      .textEditingController.text.isNotEmpty)
                                provider.textMessageSubmitted(widget.reference,
                                    provider.textEditingController.text);
                            },
                      child: Icon(
                        Icons.arrow_forward,
                        color: white,
                        size: 19,
                      )),
                ),
                const YMargin(40)
              ],
            ),
          ),
         
        ],
      ),
    ));
  }
}
