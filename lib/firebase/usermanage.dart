import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManage{
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('user');

  Future<void> addUser(email, nicName, uid, regdate) {
    return users
        .add({
      'email': email,
      'nicname': nicName,
      'uid' : uid,
      'regdate' : Timestamp.now()
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> signUp(email, nicName) async {
    FirebaseFirestore.instance.collection("user").doc(firebaseUser.uid).set(
        {
          "nicname" : nicName,
          "email" : email,
          'regdate' : Timestamp.now()
        }).then((_) => print("success!"))
          .catchError((error) => print("Failed to add user: $error"));
  }
}