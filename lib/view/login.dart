import 'package:community_stock/common/UserInfo.dart';
import 'package:community_stock/common/color.dart';
import 'package:community_stock/common/decoration.dart';
import 'package:community_stock/firebase/firebase.dart';
import 'package:community_stock/common/validate.dart';
import 'package:community_stock/common/widget_style.dart';
import 'package:community_stock/firebase/usermanage.dart';
import 'package:community_stock/view/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _pwController.dispose();
    _emailFocus.dispose();
    _pwFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
          child: ListView(
            children: [
              logo(),
              _inputEmail(),
              _inputPW(),
              WidgetCustom().showBtn(50.0, Text('로그인하기', style: TextStyle(color: Colors.white)), _login, CommonColor().basicColor),
              Padding(padding: EdgeInsets.only(top: 30), child: Text('ID/PW를 잃어버렸다면?'),),
              _findIdPw(),
              Padding(padding: EdgeInsets.only(top: 30), child: Text('아직 회원이 아니라면?'),),
              WidgetCustom().showBtn(30.0, Text('회원가입', style: TextStyle(color: Colors.white),), _signUp, Colors.blue)
            ],
          ),
        ),)
    );
  }

  Widget logo() {
    return Image.asset('assets/images/logo.png');
  }

  Widget _inputEmail() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
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
        padding: EdgeInsets.only(bottom: 10),
        child: TextFormField(
          controller: _pwController,
          focusNode: _pwFocus,
          obscureText: true,
          validator: (value) =>
              CheckValidate().validatePassword(_pwFocus, value!),
          decoration: FormDecoration().textFormDecoration('비밀번호',
              '비밀번호', '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.'),
          keyboardType: TextInputType.text,
        ));
  }

  Widget _findIdPw(){
    return TextButton(onPressed: (){},
        child: Text('아이디, 비밀번호 찾기', style: TextStyle(fontWeight: FontWeight.bold),));
  }

  void _login() async{
    if (formKey.currentState!.validate()) {
      await Firebase.initializeApp();
      await FireBaseProvider().signInWithEmail(_emailController.text, _pwController.text).then((value) async {
        if(!value) _showAlertDialog(context);
        else {
          setRememberInfo();
          await UserManage().getUserInfo().then((value) {
            UserInfo.userEmail = value['email'];
            UserInfo.userName = value['nicname'];
            print('222222222222 ' + value['nicname']);
          });
          Route route = MaterialPageRoute(builder: (context) => Home());
          Navigator.pushReplacement(context, route);
        }
      });
    }
  }

  void _signUp() {
    Navigator.push(context, MaterialPageRoute(builder : (context) => SignUp()));
  }

  void setRememberInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String email = _emailController.text;
    String pw = _pwController.text;
    pref.setString("userEmail", email);
    pref.setString("userPW", pw);
    /*UserManage().getUserNicName().then((value) {
        UserInfo.userEmail = email;
        UserInfo.userName = value;
    });*/
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
