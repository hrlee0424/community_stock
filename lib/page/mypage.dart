import 'package:community_stock/common/UserInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _getUserInfo()
        ],
      ),
    );
  }

  Widget _getUserInfo(){
    return Column(
      children: [
        Text(UserInfo.userEmail.toString())
      ],
    );
  }
}
