import 'package:cloud_firestore/cloud_firestore.dart';

class DeptModel {
  int id;
  String name;
  
  final DocumentReference reference;

  DeptModel({
    this.id,
    this.reference,
  });

  DeptModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : id = map['id'],
        name = map['name'];

  DeptModel.fromJson(Map<String, dynamic> json, {this.reference})
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  DeptModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

