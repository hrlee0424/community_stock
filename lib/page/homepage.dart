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
          child: FlatButton(
            child: Text('회원가입'),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
            },
          )
      ),
    );
  }
}
