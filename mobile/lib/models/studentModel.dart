import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  String firstName;
  String lastName;
  String email;
  String department;
  String regNo;
  String isOnline;
  String imageUrl;
  FacultyModel faculty;
  String year;
  final DocumentReference reference;

  StudentModel({
    this.firstName,
    this.email,
    this.faculty,
    this.department,
    this.lastName,
    this.imageUrl,
    this.regNo,
    this.year,
    this.reference,
  });

  StudentModel.fromMap(Map<dynamic, dynamic> map, {this.reference})
      : firstName = map['first_name'],
        lastName = map['last_name'],
        email = map['email'],
        department = map['department'],
        imageUrl = map['imageUrl'],
        isOnline = map['is_online'],
        regNo = map['reg_no'],
        faculty = map['faculty'] != null
            ? FacultyModel.fromMap(map['faculty'])
            : null,
        year = map['year'];

  StudentModel.fromJson(Map<String, dynamic> json, {this.reference})
      : firstName = json['first_name'],
        lastName = json['last_name'],
        email = json['email'],
        department = json['department'],
        isOnline = json['is_online'],
        year = json['year'],
        faculty = json['faculty'] != null
            ? FacultyModel.fromMap(json['faculty'])
            : null,
        regNo = json['reg_no'],
        imageUrl = json['imageUrl'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['imageUrl'] = this.imageUrl;
    data['department'] = this.department;
    data['is_online'] = this.isOnline;
    data['year'] = this.year;
    data['reg_no'] = this.regNo;
    data['faculty'] = this.faculty.toJson();
    return data;
  }

  StudentModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class FacultyModel {
  String facultyId;
  String name;

  FacultyModel({this.facultyId, this.name});

  FacultyModel.fromMap(Map<dynamic, dynamic> map)
      : facultyId = map['faculty_id'],
        name = map['name'];

  FacultyModel.fromJson(Map<String, dynamic> json)
      : facultyId = json['faculty_id'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['faculty_id'] = this.facultyId;
    data['name'] = this.name;
    return data;
  }
}
