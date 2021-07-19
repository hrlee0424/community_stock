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
      appBar:
          WidgetCustom().showAppbar(context, 'MyPage') as PreferredSizeWidget?,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: _getUserInfo(),
            ),
          ),
          Container(
            width: double.infinity,
            child: Divider(
              color: Colors.black87,
              thickness: 1.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                    child: Column(
                      children: [
                        Icon(Icons.assignment_outlined),
                        Text('내가 쓴 글')
                      ],
                    ),)
                  ),
                ),
                Container(
                  child: InkWell(
                      onTap: (){},
                      child: Padding(padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                        child: Column(
                          children: [
                            Icon(Icons.add_comment_outlined),
                            Text('내가 쓴 댓글')
                          ],
                        ),)
                  ),
                ),
                Container(
                  child: InkWell(
                      onTap: (){},
                      child: Padding(padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                        child: Column(
                          children: [
                            Icon(Icons.favorite_border),
                            Text('좋아요 한 글')
                          ],
                        ),)
                  ),
                ),
              ],
            ),
          ),
          WidgetCustom().showColumListItem(context, Icons.list, '공지사항'),
          WidgetCustom().showColumListItem(context, Icons.account_circle_outlined, '개인정보 수정'),
          WidgetCustom().showColumListItem(context, Icons.call, '고객센터'),
          WidgetCustom().showColumListItem(context, Icons.settings, '설정'),
          _logout()
        ],
      ),
    );
  }

  Widget _getUserInfo() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(UserInfo.userName.toString(), style: TextStyle(fontSize: 20)),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              UserInfo.userEmail.toString(),
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }

  Widget _logout() {
    return MaterialButton(
      child: Text('로그아웃'),
      onPressed: () {
        _showAlertDialog(context);
      },
    );
  }

  void _showAlertDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text("정말 로그아웃하시겠습니까?"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.pop(context, "취소");
                },
                child: Text('취소')),
            TextButton(
              child: Text('로그아웃하기'),
              onPressed: () async {
                FireBaseProvider().signOut();
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                Route route = MaterialPageRoute(builder: (context) => Login());
                Navigator.pushReplacement(context, route);
              },
            ),
          ],
        );
      },
    );
  }
}
