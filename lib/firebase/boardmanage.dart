import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BoardManage{
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  CollectionReference board = FirebaseFirestore.instance.collection('boardform');

  Future<void> addBoard(nicName, title, contents) {
    return board
        .add({
      'nicname': nicName,
      'uid' : firebaseUser.uid,
      'title' : title,
      'contents' : contents,
      'regdate' : Timestamp.now()
    })
        .then((value) => print("Board Added"))
        .catchError((error) => print("Failed to add board: $error"));
  }
}