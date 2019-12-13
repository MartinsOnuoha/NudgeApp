import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherModel {
  String phone;
  String name;
  
  final DocumentReference reference;

  TeacherModel({
    this.phone,
    this.reference,
  });

  TeacherModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : phone = map['phone'],
        name = map['name'];

  TeacherModel.fromJson(Map<String, dynamic> json, {this.reference})
      : phone = json['phone'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['phone'] = this.phone;
    data['name'] = this.name;
    return data;
  }

  TeacherModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

