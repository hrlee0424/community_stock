import 'package:community_stock/common/color.dart';
import 'package:community_stock/common/decoration.dart';
import 'package:community_stock/firebase/firebase.dart';
import 'package:community_stock/common/validate.dart';
import 'package:community_stock/common/widget_style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase/usermanage.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = new TextEditingController();
  FocusNode _emailFocus = new FocusNode();
  TextEditingController _pwController = new TextEditingController();
  FocusNode _pwFocus = new FocusNode();
  TextEditingController _pwController2 = new TextEditingController();
  FocusNode _pwFocus2 = new FocusNode();
  TextEditingController _nameController = new TextEditingController();
  FocusNode _nameFocus = new FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _pwController.dispose();
    _emailFocus.dispose();
    _pwFocus.dispose();
    _nameController.dispose();
    _nameFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('회원가입'),
          backgroundColor: Color(0xffe77b7b),
        ),
        body: new Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5.0),
              child: ListView(
                children: [_inputEmail(), _inputPW(), _inputPW2(), _inputName(), WidgetCustom().showBtn(50.0, Text('가입하기', style: TextStyle(color: Colors.white),), _signUp, CommonColor().basicColor)],
              ),
            )));
  }

  Widget _inputEmail() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: _emailController,
        focusNode: _emailFocus,
        validator: (value) => CheckValidate().validateEmail(_emailFocus, value!),
        decoration: FormDecoration().textFormDecoration('이메일', '이메일', '이메일을 입력해주세요'),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _inputPW() {
    return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: _pwController,
          focusNode: _pwFocus,
          obscureText: true,
          validator: (value) =>
              CheckValidate().validatePassword(_pwFocus, value!),
          decoration: FormDecoration().textFormDecoration(
              '비밀번호', '비밀번호', '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.'),
          keyboardType: TextInputType.text,
        ));
  }

  Widget _inputPW2() {
    return Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: _pwController2,
          focusNode: _pwFocus2,
          obscureText: true,
          validator: (value) {
            if(value != _pwController.text){
              return '비밀번호가 일치하지 않습니다. 다시 입력해주세요.';
            }
          },
          decoration: FormDecoration().textFormDecoration(
              '비밀번호 확인', '비밀번호 확인', '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.'),
          keyboardType: TextInputType.text,
        ));
  }

  Widget _inputName() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: _nameController,
        focusNode: _nameFocus,
        validator: (value) {
          if(value!.isEmpty) return '닉네임을 입력하세요.';
          else return null;
        },
        decoration: FormDecoration().textFormDecoration('닉네임', '닉네임', '닉네임을 입력해주세요'),
      ),
    );
  }

  void _signUp() async {
    if (formKey.currentState!.validate()) {
      FocusScopeNode currentFocus = FocusScope.of(context); currentFocus.unfocus();
      await Firebase.initializeApp();
      await FireBaseProvider().signUpWithEmail(
          _emailController.text, _pwController.text).then((value) {
        if (value) {
          // String regdate = TimeMagage().getTimeNow();
          // UserManage().addUser(_emailController.text, _nameController.text, '11111', regdate);
          UserManage().signUp(_emailController.text, _nameController.text);
          Navigator.pop(context);
          } else {
            _showAlertDialog(context);
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
