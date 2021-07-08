import 'package:cloud_firestore/cloud_firestore.dart';

class BoardManage{
  CollectionReference users = FirebaseFirestore.instance.collection('boardform');

  Future<void> addBoard(nicName, uid, title, contents, regdate) {
    return users
        .add({
      'nicname': nicName,
      'uid' : uid,
      'title' : title,
      'contents' : contents,
      'regdate' : regdate
    })
        .then((value) => print("Board Added"))
        .catchError((error) => print("Failed to add board: $error"));
  }
}