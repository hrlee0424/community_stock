import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_stock/firebase/boardmanage.dart';
import 'package:community_stock/view/writeboard.dart';
import 'package:flutter/material.dart';

import '../common/UserInfo.dart';
import '../home.dart';

class DetailView extends StatefulWidget {
  // const DetailView({Key key}) : super(key: key);
  final DocumentSnapshot post;

  DetailView(this.post);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  StreamController<String> streamController = StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('상세보기'),
          actions: [
            // if(widget.post['nicname'] == UserInfo.userName)
            Visibility(
                child: new IconButton(
                    icon: new Icon(Icons.mode_edit),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WriteBoard(post: widget.post)));
                    }),
                visible:
                    widget.post['nicname'] == UserInfo.userName ? true : false),
            Visibility(
                child: new IconButton(
                    icon: new Icon(Icons.delete), onPressed: () {_showAlertDialog(context);}),
                visible:
                    widget.post['nicname'] == UserInfo.userName ? true : false),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.post['title'], style: TextStyle(fontSize: 25),),
              Text(widget.post['nicname']),
              Text(widget.post['contents']),
              Text(widget.post.id),
            ],
          ),
        ));
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
