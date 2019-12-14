import 'package:cloud_firestore/cloud_firestore.dart';

class StudentsClassModel {
  String department;
  String university;
  String year;

  final DocumentReference reference;

  StudentsClassModel({
    this.department,
    this.university,
    this.year,
    this.reference,
  });

  StudentsClassModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : department = map['department'],
        university = map['university'],
        year = map['year'];

  StudentsClassModel.fromJson(Map<String, dynamic> json, {this.reference})
      : department = json['department'],
        university = json['university'],
        year = json['year'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['department'] = this.department;
    data['year'] = this.year;
    data['university'] = this.university;
    return data;
  }

  StudentsClassModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
