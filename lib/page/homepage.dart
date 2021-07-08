import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../signup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
          .collection('BoardForm')
          .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.data == null) return CircularProgressIndicator();
            if(snapshot.data.size <= 0){
              return Center(child: Text('게시글이 없습니다.'),);
            }
            return ListView(
              children:
              snapshot.data.docs.map((board){
                return Center(
                  child: ListTile(
                    title: Text(board['Title']),
                    onTap: (){},
                  ),
                );
              }).toList(),
            );
          },
        ),
      )
    );
  }

}