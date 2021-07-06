import 'dart:async';
import 'package:community_stock/common/UserInfo.dart';
import 'package:community_stock/home.dart';
import 'package:community_stock/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userEmail, userPW;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('주식이야기'),
    );
  }

  void getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    userEmail = pref.getString("userEmail");
    userPW = pref.getString("userPW");
    logger.e('user ' + userEmail.toString());
    if(userEmail == null || userEmail == '')
      navigatorPage();
    else {
      logger.e('user 11111111111 ' + userEmail.toString());
      _login();
    }
  }

  void _login() async{
      await Firebase.initializeApp();
      await FireBaseProvider().signInWithEmail(userEmail, userPW).then((value) {
        if(value) {
          UserInfo.userEmail = userEmail;
          navigatorPage();
        }
      });
  }

  startTime() async{
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration,  getUserInfo);
  }

  void navigatorPage() {
    logger.e('user 22222222 ' + userEmail.toString());

    Route route = MaterialPageRoute(builder: (context) => UserInfo.userEmail == null ? Login(): Home());
    Navigator.pushReplacement(context, route);
  }
}
