import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BoardManage{
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  CollectionReference board = FirebaseFirestore.instance.collection('boardform');

  Future<void> addBoard(nicName, title, contents) {
    return board
        .add({
      'nicname': nicName,
      'uid' : firebaseUser!.uid,
      'title' : title,
      'contents' : contents,
      'regdate' : Timestamp.now()
    })
        .then((value) => print("Board Added"))
        .catchError((error) => print("Failed to add board: $error"));
  }

  Future<void> updateBoard(docId, title, contents){
    return board.doc(docId)
         .update({'title': title, 'contents' : contents})
         .then((value) => print("Board Update"))
         .catchError((error) => print("Failed to update board: $error"));
  }

  Future<void> deleteBoard(docId){
    return board.doc(docId)
          .delete().then((value) => print("Board Delete"))
          .catchError((error) => print("Failed to delete board: $error"));
  }
}