import 'package:cloud_firestore/cloud_firestore.dart';

class UniversityModel {
  int schoolId;
  String schoolName;
  
  final DocumentReference reference;

  UniversityModel({
    this.schoolId,
    this.reference,
  });

  UniversityModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : schoolId = map['schoolId'],
        schoolName = map['schoolName'];

  UniversityModel.fromJson(Map<String, dynamic> json, {this.reference})
      : schoolId = json['schoolId'],
        schoolName = json['schoolName'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['schoolId'] = this.schoolId;
    data['schoolName'] = this.schoolName;
    return data;
  }

  UniversityModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

