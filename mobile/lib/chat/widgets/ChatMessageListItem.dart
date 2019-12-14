import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:nudge/models/studentModel.dart';
import 'package:nudge/utils/margin.dart';
import 'package:nudge/utils/theme.dart';

class ChatMessageListItem extends StatelessWidget {
  final DataSnapshot messageSnapshot;
  final Animation animation;
  final StudentModel sender;

  ChatMessageListItem(
      {this.messageSnapshot,
      this.animation,
      @required this.sender});

  @override
  Widget build(BuildContext context) {
    final bool isMe = sender.studentID == messageSnapshot.value['userId'];
    return new SizeTransition(
      sizeFactor:
          new CurvedAnimation(parent: animation, curve: Curves.decelerate),
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child:
            Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                child: Directionality(
                  textDirection:
                     isMe ? TextDirection.ltr : TextDirection.rtl,
                  child: ListTile(
                    
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(isMe ? 10 : 0),
                              bottomLeft: Radius.circular(isMe ? 0 : 10),
                              topRight: Radius.circular(10),
                            ),
                            color:isMe
                                ? Colors.grey.withOpacity(0.2)
                                : blue3,
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            messageSnapshot.value['text'],
                            style: TextStyle(
                              color: isMe? Colors.grey[800] : white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const YMargin(9),
                        Text(
                            messageSnapshot.value['senderName'],
                            style: TextStyle(
                              color:  Colors.grey[900],
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                    subtitle: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Column(
                        children: <Widget>[
                          const YMargin(8),
                          Row(
                            mainAxisAlignment: isMe
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                intl.DateFormat?.jm()
                        ?.format(DateTime.parse(messageSnapshot.value['timeStamp'])),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                              const XMargin(10),
                              isMe
                                  ? Container()
                                  : Icon(
                                      Icons.done_all,
                                      color: blue3,
                                      size: 16,
                                    )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        ),
      
    );
  }

  List<Widget> getSentMessageLayout(context) {
    //print("Image:" + messageSnapshot.value['imageUrl']);

    return <Widget>[
      new Expanded(
        child: Container(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Text('You',
                  style: new TextStyle(
                      fontSize: 11.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: messageSnapshot.value['imageUrl'] != null
                      ? GestureDetector(
                          onTap: () {
                           /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => Scaffold(
                                  bg: messageSnapshot.value['imageUrl'],
                                  isFromNetwork: true,
                                  child: Container(),
                                ),
                              ),
                            ); */
                          },
                          child: new ClipRRect(
                              borderRadius: new BorderRadius.circular(18.0),
                              child: new FadeInImage.assetNetwork(
                                placeholder: 'assets/images/placeholder.jpg',
                                width: 250,
                                image: messageSnapshot.value['imageUrl'],
                              )))
                      : new Text(messageSnapshot.value['text'],
                          style: new TextStyle(
                              fontSize: 15.0, color: Colors.white)))
            ],
          ),
        ),
      ),
      new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Container(
              margin: const EdgeInsets.only(left: 8.0),
              child: new CircleAvatar(
                backgroundImage: new NetworkImage("https://bit.ly/2BCsKbI"),
              )),
        ],
      ),
    ];
  }

 }
final RegExp REGEX_EMOJI = RegExp(r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
