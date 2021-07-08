import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManage{

  CollectionReference users = FirebaseFirestore.instance.collection('user');

  Future<void> addUser(email, nicName, uid, regdate) {
    return users
        .add({
      'email': email,
      'nicname': nicName,
      'uid' : uid,
      'regdate' : regdate
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}