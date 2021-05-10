import 'package:e_lapor/Future/AuthFuture.dart';
import 'package:flutter/material.dart';

class GlobalState with ChangeNotifier {
  GlobalState() {
    AuthFuture.isLoggedIn().then((value) => _isLogin = value);
  }

  bool _isLogin;

  bool get isLogin => _isLogin;
  set isLogin(bool newValue) {
    _isLogin = newValue;
    notifyListeners();
  }
}
