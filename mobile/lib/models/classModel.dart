import 'package:cloud_firestore/cloud_firestore.dart';

class ClassModel {
  String day;
  String name;
  String desc;
  String teacher;
  Timestamp startTime;
  Timestamp endTime;
  String location;

  final DocumentReference reference;

  ClassModel({
    this.day,
    this.name,
    this.teacher,
    this.desc,
    this.startTime,
    this.endTime,
    this.location,
    this.reference,
  });

  ClassModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : day = map['day'],
        teacher = map['teacher'],
        name = map['name'],
        desc = map['desc'],
        startTime = map['startTime'],
        endTime = map['endTime'],
        location = map['location'];

  ClassModel.fromJson(Map<String, dynamic> json, {this.reference})
      : day = json['day'],
        teacher = json['teacher'],
        name = json['name'],
        desc = json['desc'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        location = json['location'];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['day'] = this.day;
    data['teacher'] = this.teacher;
    data['endTime'] = this.endTime;
    data['desc'] = this.desc;
    data['startTime'] = this.startTime;
    data['location'] = this.location;
    data['name'] = this.name;
    return data;
  }

  ClassModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
