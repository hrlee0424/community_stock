import 'package:community_stock/common/UserInfo.dart';
import 'package:community_stock/firebase/firebase.dart';
import 'package:community_stock/view/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/widget_style.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetCustom().showAppbar(context, 'MyPage') as PreferredSizeWidget?,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Padding(padding: EdgeInsets.all(10.0), child: _getUserInfo(),),
            ),
            Spacer(),
            _logout()
          ],
        ),
    );
  }

  Widget _getUserInfo(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(UserInfo.userName.toString(), style: TextStyle(fontSize: 20)),
          Padding(padding: EdgeInsets.only(top: 10.0),
            child: Text(UserInfo.userEmail.toString(), style: TextStyle(fontSize: 15),),)
        ],
      ),
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
