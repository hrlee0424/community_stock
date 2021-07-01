import 'package:community_stock/common/decoration.dart';
import 'package:community_stock/firebase.dart';
import 'package:community_stock/common/validate.dart';
import 'package:community_stock/common/widget_style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = new TextEditingController();
  FocusNode _emailFocus = new FocusNode();
  TextEditingController _pwController = new TextEditingController();
  FocusNode _pwFocus = new FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 5.0),
          child: Column(
            children: [
              _inputEmail(),
              _inputPW(),
              WidgetCustom().showBtn(Text('로그인하기'), _login)
            ],
          ),
        ),)
    );
  }

  Widget _inputEmail() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: _emailController,
        focusNode: _emailFocus,
        validator: (value) => CheckValidate().validateEmail(_emailFocus, value),
        decoration: FormDecoration().textFormDecoration('이메일', '이메일을 입력해주세요'),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _inputPW() {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: TextFormField(
          controller: _pwController,
          focusNode: _pwFocus,
          validator: (value) =>
              CheckValidate().validatePassword(_pwFocus, value),
          decoration: FormDecoration().textFormDecoration(
              '비밀번호', '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.'),
          keyboardType: TextInputType.emailAddress,
        ));
  }

  void _login() async{
    if (formKey.currentState.validate()) {
      await Firebase.initializeApp();
      await FireBaseProvider().signInWithEmail(_emailController.text, _pwController.text).then((value) {
        if(!value) _showAlertDialog(context);
        else {
          Route route = MaterialPageRoute(builder: (context) => Home());
          Navigator.pushReplacement(context, route);
        }
      });
    }
  }

  void _showAlertDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text("중복된 아이디가 있습니다. 로그인 해주세요."),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context, "OK");
              },
            ),
          ],
        );
      },
    );
  }

}
