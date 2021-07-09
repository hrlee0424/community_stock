import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  // const DetailView({Key key}) : super(key: key);
  final DocumentSnapshot post;
  DetailView(this.post);

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상세보기'),
      ),
      body: Column(
        children: [
          Text(widget.post['title']),
          Text(widget.post['contents']),
          Text(widget.post['regdate'].toString()),
        ],
      ),
    );
  }
}
