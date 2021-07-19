import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_stock/model/boardInfo.dart';
import 'package:flutter/cupertino.dart';

class BoardProvider extends ChangeNotifier{
  late BoardInfo boardInfo;

  final db = FirebaseFirestore.instance;
  late StreamSubscription sub;
  

  Future<void> getBoardData(id) async{
    db.collection('boardform').doc('id').snapshots().listen((event) {
      var data = event.data();

    });
  }

}