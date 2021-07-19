import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_stock/common/color.dart';
import 'package:community_stock/firebase/boardmanage.dart';
import 'package:community_stock/model/boardInfo.dart';
import 'package:community_stock/view/writeboard.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/UserInfo.dart';
import '../home.dart';

class DetailView extends StatefulWidget {
  // const DetailView({Key key}) : super(key: key);
  final DocumentSnapshot post;
  // final String postId;

  DetailView(this.post);
  // DetailView(this.postId);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('상세보기'),
          backgroundColor: CommonColor().basicColor,
          actions: [
            // if(widget.post['nicname'] == UserInfo.userName)
            /*Visibility(
                child: new IconButton(
                    icon: new Icon(Icons.mode_edit),
                    onPressed: ()  {
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WriteBoard(post: widget.post)));
                    }),
                visible:
                    widget.post['nicname'] == UserInfo.userName ? true : false),*/
            Visibility(
                child: new IconButton(
                    icon: new Icon(Icons.delete), onPressed: () {_showAlertDialog(context);}),
                visible:
                    widget.post['nicname'] == UserInfo.userName ? true : false),
          ],
        ),
        body: /*Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  *//*Text(widget.post['title'], style: TextStyle(fontSize: 25),),
                  Text(widget.post['nicname']),
                  // widget.post['image'] != '' ? Image.network(widget.post['image'], fit: BoxFit.contain,) : Container(),
                  Text(widget.post['contents']),
                  Text(widget.post.id),*//*
                ],
              ),
        )*/
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('boardform')
              .doc(widget.post.id)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
            var data = snapshot.data;
            if(snapshot.data == null) return CircularProgressIndicator();
            print(data!.data().toString());
            List<dynamic> list = data['image'];
            return ListView(
                children: [
                  Text(data['title']),
                  Text(data['contents']),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.isNotEmpty ? list.length : 0,
                      itemBuilder: (_, int index){
                      Map<String, dynamic> sp = list[index];
                      return Image.network(sp['img'].toString());
                      },
                  ),
            ],
            );
          },
        )
    );
  }


  void _showAlertDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text("정말 삭제하시겠습니까?"),
          actions: <Widget>[
            TextButton(onPressed: (){
              Navigator.pop(context, "취소");
            }, child: Text('취소')),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                BoardManage().deleteBoard(widget.post.id).then((value) =>
                    Navigator.of(context).popUntil((route) => route.isFirst)//ModalRoute.withName("/Home")
                );
              },
            ),
          ],
        );
      },
    );
  }

}
