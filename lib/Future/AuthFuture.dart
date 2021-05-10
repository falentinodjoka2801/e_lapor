import 'package:e_lapor/Future/Akun/AkunFuture.dart';

import 'package:e_lapor/libraries/Environment.dart';
import 'package:e_lapor/libraries/SPKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthFuture {
  static Future<bool> isLoggedIn() async {
    bool _isUserLoggedIn = false;

    if (Environment.environment == Environment.dev) {
      await Future.delayed(Duration(seconds: 1));
    }

    Map<String, dynamic> _dataLogin = await AkunFuture.getDataLogin();
    if (_dataLogin != null) {
      int _userID = _dataLogin[SPKey.idUser];
      if (_userID != null) {
        _isUserLoggedIn = true;
      }
    }
    return _isUserLoggedIn;
  }

  static Future<void> saveUsernameAndPassword(
      String username, String password) async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _sp.setString(SPKey.savedUsername, username);
    _sp.setString(SPKey.savedPassword, password);
  }

  static Future<void> removeSavedUsernameAndPassword() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _sp.remove(SPKey.savedUsername);
    _sp.remove(SPKey.savedPassword);
  }

  static Future<Map<String, String>> getSavedUsernameAndPassword() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    String _username = _sp.getString(SPKey.savedUsername);
    String _password = _sp.getString(SPKey.savedPassword);

    return {'username': _username, 'password': _password};
  }
}
