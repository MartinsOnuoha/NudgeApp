import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  String title;
  String desc;
  bool isImportant;
  Timestamp timeStamp;

  final DocumentReference reference;

  NotesModel({
    this.title,
    this.desc,
    this.timeStamp,
    this.isImportant,
    this.reference,
  });

  NotesModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : title = map['title'],
        desc = map['desc'],
        isImportant = map['isImportant'],
        timeStamp = map['timeStamp'];

  NotesModel.fromJson(Map<String, dynamic> json, {this.reference})
      : title = json['title'],
        isImportant = json['isImportant'],
        desc = json['desc'],
        timeStamp = json['timeStamp'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['title'] = this.title;
    data['timeStamp'] = this.timeStamp;
    data['isImportant'] = this.isImportant;
    data['desc'] = this.desc;
    return data;
  }

  NotesModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
