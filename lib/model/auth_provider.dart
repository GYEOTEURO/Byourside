import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ChangeNotifier 상속 받이 상태 관리
// AuthProvider 구동
class AuthProvider extends ChangeNotifier {
  // bool _isLoading = false;
  String? _verificationId;
  bool _authOk = false;
  bool _haveEmail = false;
  String? _phoneNum;
  PhoneAuthCredential? _phoneAuthCredential;
  bool _isRegister = false;

  bool get authOk => _authOk; // get 함수를 사용해 외부에서 접근이 가능하게 한다.
  String? get verificationId => _verificationId; // get 함수를 사용해 외부에서 접근이 가능하게 한다.
  // bool get isLoading => _isLoading; // get 함수를 사용해 외부에서 접근이 가능하게 한다.
  bool get haveEmail => _haveEmail;
  String? get phoneNum => _phoneNum;
  PhoneAuthCredential? get phoneAuthCredential => _phoneAuthCredential;
  bool get isRegister => _isRegister;

  changeAuthOk(bool authOk) {
    _authOk = authOk; // updateCurrentPage를 통해 index 값을 받아와 _index 페이지로 바꿔준다.
    notifyListeners(); // notifyListeners 호출해 업데이트된 값을 구독자에게 알림
  }

  // changeIsLoading(bool isLoading) {
  //   _isLoading = isLoading; // updateCurrentPage를 통해 index 값을 받아와 _index 페이지로 바꿔준다.
  //   notifyListeners(); // notifyListeners 호출해 업데이트된 값을 구독자에게 알림
  // }

  setVerificationId(String verificationId) {
    _verificationId = verificationId;
    notifyListeners();
  }

  changeHaveEmail(bool haveEmail) {
    _haveEmail = haveEmail;
    notifyListeners();
  }

  setPhoneNum(String phoneNum) {
    _phoneNum = phoneNum;
    notifyListeners();
  }

  setPhoneCredential(PhoneAuthCredential phoneAuthCredential) {
    _phoneAuthCredential = phoneAuthCredential ;
    notifyListeners();
  }

  changeIsRegister(bool isRegister) {
    _isRegister = isRegister;
    notifyListeners();
  }
}