import 'package:flutter/material.dart';

// ChangeNotifier 상속 받이 상태 관리
// AuthProvider 구동
class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _verificationId;
  bool _authOk = false;
  bool _haveEmail = false;

  bool get authOk => _authOk; // get 함수를 사용해 외부에서 접근이 가능하게 한다.
  String? get verificationId => _verificationId; // get 함수를 사용해 외부에서 접근이 가능하게 한다.
  bool get isLoading => _isLoading; // get 함수를 사용해 외부에서 접근이 가능하게 한다.
  bool get haveEmail => _haveEmail;

  changeAuthOk(bool authOk) {
    _authOk = authOk; // updateCurrentPage를 통해 index 값을 받아와 _index 페이지로 바꿔준다.
    notifyListeners(); // notifyListeners 호출해 업데이트된 값을 구독자에게 알림
  }

  changeIsLoading(bool isLoading) {
    _isLoading = isLoading; // updateCurrentPage를 통해 index 값을 받아와 _index 페이지로 바꿔준다.
    notifyListeners(); // notifyListeners 호출해 업데이트된 값을 구독자에게 알림
  }

  setVerificationId(String verificationId) {
    _verificationId = verificationId;
    notifyListeners();
  }

  changeHaveEmail(bool haveEmail) {
    _haveEmail = haveEmail;
    notifyListeners();
  }
}