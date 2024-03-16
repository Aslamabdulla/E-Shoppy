import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String? name;
  String email;
  String? mobile;
  String? dob;
  String? gender;

  String userCreationTime;
  String? deviceToken;

  UserModel(
      {required this.uid,
      this.name,
      required this.email,
      this.mobile,
      this.dob,
      this.gender,
      required this.userCreationTime,
      this.deviceToken});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'mobile': mobile,
      'dob': dob,
      'gender': gender,
      'deviceToken': deviceToken,
      'userCreationTime': userCreationTime,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        uid: map['uid'],
        name: map['name'],
        email: map['email'],
        mobile: map['mobile'],
        dob: map['dob'],
        gender: map['gender'],
        deviceToken: map['deviceToken'],
        userCreationTime: map['userCreationTime'],
      );

  static UserModel fromSnap(DocumentSnapshot snap) {
    var map = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      mobile: map['mobile'],
      dob: map['dob'],
      gender: map['gender'],
      deviceToken: map['deviceToken'],
      userCreationTime: map['userCreationTime'],
    );
  }
}
