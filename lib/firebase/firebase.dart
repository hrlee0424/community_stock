import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class FireBaseProvider with ChangeNotifier{
  final FirebaseAuth fAuth = FirebaseAuth.instance;
  User? _user;

  String? _lastFirebaseResponse = "";

  FireBaseProvider() {
    logger.d("init FirebaseProvider");

  }

  User? getUser() {
    return _user;
  }

  void setUser(User? value){
    _user = value;
    notifyListeners();
  }

  // 최근 Firebase에 로그인한 사용자의 정보 획득
  prepareUser(){
    if(fAuth.currentUser != null){
      setUser(fAuth.currentUser);
    }
  }

  // 이메일/비밀번호로 Firebase에 회원가입
  Future<bool> signUpWithEmail(String email, String password) async{
    try {
      UserCredential result = await fAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(result.user != null){
        result.user!.sendEmailVerification();
        signOut();
        return true;
      }else{
        return false;
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      // List<String> result = e.toString().split(", ");
      // setLastFBMessage(result[1]);
      return false;
    }
  }

  // 이메일/비밀번호로 Firebase에 로그인
  Future<bool> signInWithEmail(String email, String password) async{
    try {
      var result = await fAuth.signInWithEmailAndPassword(email: email, password: password);
      if(result != null){
        setUser(result.user);
        logger.d(getUser());
        return true;
      }else{
        return false;
      }
      // return false;
    } on Exception catch (e) {
      logger.e(e.toString());
      // List<String> result = e.toString().split(", ");
      setLastFBMessage(e.toString());
      return false;
    }
  }

  // Firebase로부터 로그아웃
  signOut() async{
    await fAuth.signOut();
    setUser(null);
  }

  // 사용자에게 비밀번호 재설정 메일을 영어로 전송 시도
  sendPasswordResetEmailByEnglish() async {
    await fAuth.setLanguageCode("en");
    sendPasswordResetEmail();
  }

  // 사용자에게 비밀번호 재설정 메일을 한글로 전송 시도
  sendPasswordResetEmailByKorean() async {
    await fAuth.setLanguageCode("ko");
    sendPasswordResetEmail();
  }

  // 사용자에게 비밀번호 재설정 메일을 전송
  sendPasswordResetEmail() async {
    fAuth.sendPasswordResetEmail(email: getUser()!.email!);
  }

  // Firebase로부터 회원 탈퇴
  withdrawalAccount() async {
    await getUser()!.delete();
    setUser(null);
  }

  // Firebase로부터 수신한 메시지 설정
  setLastFBMessage(String msg) {
    _lastFirebaseResponse = msg;
  }

  // Firebase로부터 수신한 메시지를 반환하고 삭제
  getLastFBMessage() {
    String? returnValue = _lastFirebaseResponse;
    _lastFirebaseResponse = null;
    return returnValue;
  }

}