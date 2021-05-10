import 'package:e_lapor/libraries/SPKey.dart';
import 'package:image_picker/image_picker.dart' show PickedFile;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart' show required;

class LocalStorage {
  static Future<void> setPickedFile(PickedFile pickedFile) async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    String _pickedFilePath = pickedFile.path;

    _sp.setString(SPKey.savedPickedFileOPT, _pickedFilePath);
  }

  static Future<void> removePickedFile() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _sp.remove(SPKey.savedPickedFileOPT);
  }

  static Future<String> getPickedFile() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    String _pickedFilePath = _sp.getString(SPKey.savedPickedFileOPT);

    return _pickedFilePath;
  }

  static Future<void> setSavedLocation(
      double latitude, double longitude) async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _sp.setString(SPKey.savedLat, latitude.toString());
    _sp.setString(SPKey.savedLong, longitude.toString());
  }

  static Future<void> removeSavedLocation() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _sp.remove(SPKey.savedLat);
    _sp.remove(SPKey.savedLong);
  }

  static Future<Map<String, double>> getSavedLocation() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    String _savedLat = _sp.getString(SPKey.savedLat);
    String _savedLong = _sp.getString(SPKey.savedLong);

    Map<String, double> _savedLocation = {
      'latitude': double.parse(_savedLat),
      'longitude': double.parse(_savedLong)
    };

    return _savedLocation;
  }

  static Future<void> setFCMToken({@required String token}) async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _sp.setString(SPKey.savedToken, token);
  }

  static Future<String> getFCMToken() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    String _token = _sp.getString(SPKey.savedToken);
    return _token;
  }

  static Future<void> removeFCMToken() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _sp.remove(SPKey.savedToken);
  }
}
