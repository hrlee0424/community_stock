import 'package:community_stock/firebase.dart';
import 'package:community_stock/validate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = new TextEditingController();
  FocusNode _emailFocus = new FocusNode();
  TextEditingController _pwController = new TextEditingController();
  FocusNode _pwFocus = new FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _pwController.dispose();
    _emailFocus.dispose();
    _pwFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('회원가입'),
        ),
        body: new Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
              child: Column(
                children: [_InputEmail(), _InputPW(), _showBtnSignUp()],
              ),
            )));
  }

  Widget _InputEmail() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: _emailController,
        focusNode: _emailFocus,
        validator: (value) => CheckValidate().validateEmail(_emailFocus, value),
        decoration: _textFormDecoration('이메일', '이메일을 입력해주세요'),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _InputPW() {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: TextFormField(
          controller: _pwController,
          focusNode: _pwFocus,
          validator: (value) =>
              CheckValidate().validatePassword(_pwFocus, value),
          decoration: _textFormDecoration(
              '비밀번호', '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.'),
          keyboardType: TextInputType.emailAddress,
        ));
  }

  InputDecoration _textFormDecoration(hintText, helperText) {
    return new InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(0, 16, 0, 0),
      hintText: hintText,
      helperText: helperText,
    );
  }

  Widget _showBtnSignUp() {
    return Padding(
        padding: EdgeInsets.only(top: 50),
        child: Container(
          width: double.infinity,
          child: MaterialButton(
            height: 50,
            child: Text('가입하기'),
            onPressed: () {
              _SignUp();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Colors.amberAccent,
          ),
        ));
  }

  void _SignUp() async {
    if (formKey.currentState.validate()) {
      await Firebase.initializeApp();
      bool result = false;
      /*await FireBaseProvider().signUpWithEmail(
          _emailController.text, _pwController.text);*/
      if (result) {
        Navigator.pop(context);
      } else {
        showAlertDialog(context);
      }
    }
  }

  void showAlertDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text("중복된 아이디가 있습니다. 로그인 해주세요."),
          actions: <Widget>[
            FlatButton(
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
