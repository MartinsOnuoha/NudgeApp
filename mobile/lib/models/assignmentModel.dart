import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentModel {
  String title;
  String desc;
  Timestamp dueDate;

  final DocumentReference reference;

  AssignmentModel({
    this.title,
    this.desc,
    this.dueDate,
    this.reference,
  });

  AssignmentModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : title = map['title'],
        desc = map['desc'],
        dueDate = map['dueDate'];

  AssignmentModel.fromJson(Map<String, dynamic> json, {this.reference})
      : title = json['title'],
        desc = json['desc'],
        dueDate = json['dueDate'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['title'] = this.title;
    data['desc'] = this.desc;
    data['dueDate'] = this.dueDate.toDate().toUtc().toString();
    return data;
  }

  AssignmentModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
