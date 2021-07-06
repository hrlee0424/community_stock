import 'package:community_stock/common/UserInfo.dart';
import 'package:community_stock/firebase.dart';
import 'package:community_stock/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          _getUserInfo(),
          _logout()
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

  Widget _logout() {
    return MaterialButton(
      child: Text('로그아웃'),
      onPressed: () async {
        FireBaseProvider().signOut();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Route route = MaterialPageRoute(builder: (context) => Login());
        Navigator.pushReplacement(context, route);
      },
    );
  }


}