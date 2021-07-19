import 'dart:async';
import 'package:community_stock/common/UserInfo.dart';
import 'package:community_stock/home.dart';
import 'package:community_stock/view/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../firebase/firebase.dart';
import '../firebase/usermanage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userEmail, userPW;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          logo(),
          Text('STALK', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        ],
      )
    );
  }

  Widget logo() {
    return Padding(padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Image.asset('assets/images/logo.png'));
  }

  void getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userEmail = pref.getString("userEmail");
    userPW = pref.getString("userPW");
    if(userEmail == null || userEmail == '')
      navigatorPage();
    else {
      _login();
    }
  }

  void _login() async{
      await Firebase.initializeApp();
      await FireBaseProvider().signInWithEmail(userEmail!, userPW!).then((value) async {
        if(value) {
          await UserManage().getUserInfo().then((value) {
            UserInfo.userEmail = userEmail;
            UserInfo.userName = value['nicname'];
            navigatorPage();
          });
        }
      });
  }

  void setUser() async{
    await UserManage().getUserNicName().then((value) {
      if(value != null){
        UserInfo.userEmail = userEmail;
        UserInfo.userName = value.toString();
      }
    });
  }

  startTime() async{
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration,  getUserInfo);
  }

  void navigatorPage() {
    Route route = MaterialPageRoute(builder: (context) => UserInfo.userEmail == null ? Login(): Home());
    Navigator.pushReplacement(context, route);
  }
}
