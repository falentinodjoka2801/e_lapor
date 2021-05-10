import 'dart:convert';

import 'package:e_lapor/libraries/SPKey.dart';
import 'package:e_lapor/libraries/ServerPath.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/Button.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AkunFuture {
  static String _apiBaseURL = ServerPath.apiBaseURL;
  static const String loginSuccess = 'success';

  static Future<bool> konfirmasiLogout(
      BuildContext konfirmasiLogoutContext) async {
    bool _konfirmasiLogout = await Alert.textComponent(konfirmasiLogoutContext,
        isDismissible: true,
        icon: SvgPicture.asset(ClientPath.svgPath + '/danger.svg'),
        subTitle: 'Apakah anda yakin untuk keluar dari aplikasi?',
        title: null,
        useRouteNavigator: false,
        actions: Column(children: [
          Button.submitButton(konfirmasiLogoutContext, 'YA, KELUARKAN SAYA',
              () {
            Navigator.pop(konfirmasiLogoutContext, true);
          },
              color: CustomColors.eLaporGreen,
              trailing: IconButton(
                  color: CustomColors.eLaporWhite,
                  icon: Icon(Icons.arrow_forward_ios_sharp),
                  onPressed: () => null)),
          SizedBox(height: 5.0),
          Button.submitButton(konfirmasiLogoutContext, 'BATAL', () {
            Navigator.pop(konfirmasiLogoutContext, false);
          }, outline: true, useBorder: false, color: CustomColors.eLaporRed)
        ]));
    return _konfirmasiLogout;
  }

  static Future<Map<String, dynamic>> autentikasiLogin(
      Map<String, dynamic> dataLogin) async {
    Map<String, dynamic> _returnedData;

    Uri _uri = Uri.parse(_apiBaseURL + '/' + ServerPath.login);

    Response _httpResponse = await post(_uri, body: dataLogin);

    if (_httpResponse.statusCode != 404) {
      Map<String, dynamic> _decodedBody = jsonDecode(_httpResponse.body);
      _returnedData = _decodedBody;
    }

    return _returnedData;
  }

  static Future<void> setDataLogin(Map<String, dynamic> dataLogin) async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _sp.setInt(SPKey.idUser, dataLogin['id']);
    _sp.setString(SPKey.namaUser, dataLogin['name']);
    // _sp.setString(SPKey.fotoUser, dataLogin['photo']);
    _sp.setString(SPKey.phoneUser, dataLogin['phone']);
    _sp.setString(SPKey.emailUser, dataLogin['email']);
    _sp.setInt(SPKey.provinsiUser, dataLogin['provinsi']);
    _sp.setString(SPKey.provinsiUserString, dataLogin['nama_provinsi']);
    _sp.setInt(SPKey.kabupatenKotaUser, dataLogin['kabupaten']);
    _sp.setString(SPKey.kabupatenKotaUserString, dataLogin['nama_kabupaten']);
    // _sp.setInt(SPKey.kecamatanUser, dataLogin['kecamatan']);
    _sp.setString(SPKey.kecamatanUser, dataLogin['kecamatan']);
    // _sp.setInt(SPKey.kelurahanUser, dataLogin['desa']);
    _sp.setString(SPKey.privilegesUser, jsonEncode(dataLogin['privileges']));
  }

  static Future<void> removeDataLogin() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    _sp.remove(SPKey.idUser);
    _sp.remove(SPKey.phoneUser);
    _sp.remove(SPKey.namaUser);
    _sp.remove(SPKey.fotoUser);
    _sp.remove(SPKey.emailUser);
    _sp.remove(SPKey.provinsiUser);
    _sp.remove(SPKey.provinsiUserString);
    _sp.remove(SPKey.kabupatenKotaUser);
    _sp.remove(SPKey.kabupatenKotaUserString);
    _sp.remove(SPKey.kecamatanUser);
    _sp.remove(SPKey.kelurahanUser);
    _sp.remove(SPKey.privilegesUser);
  }

  static Future<Map<String, dynamic>> getDataLogin() async {
    SharedPreferences _sp = await SharedPreferences.getInstance();
    String _privilegesUser = _sp.getString(SPKey.privilegesUser);

    return (_privilegesUser != null)
        ? {
            SPKey.idUser: _sp.getInt(SPKey.idUser),
            SPKey.phoneUser: _sp.getString(SPKey.phoneUser),
            SPKey.namaUser: _sp.getString(SPKey.namaUser),
            SPKey.fotoUser: _sp.getString(SPKey.fotoUser),
            SPKey.emailUser: _sp.getString(SPKey.emailUser),
            SPKey.provinsiUser: _sp.getInt(SPKey.provinsiUser),
            SPKey.provinsiUserString: _sp.getString(SPKey.provinsiUserString),
            SPKey.kabupatenKotaUser: _sp.getInt(SPKey.kabupatenKotaUser),
            SPKey.kabupatenKotaUserString:
                _sp.getString(SPKey.kabupatenKotaUserString),
            SPKey.kecamatanUser: _sp.getString(SPKey.kecamatanUser),
            // SPKey.kecamatanUser: _sp.getInt(SPKey.kecamatanUser),
            // SPKey.kelurahanUser: _sp.getInt(SPKey.kelurahanUser),
            SPKey.privilegesUser: jsonDecode(_privilegesUser)
          }
        : null;
  }

  static Future<Map<String, dynamic>> changePassword(
      Map<String, dynamic> _dataPassword) async {
    Map<String, dynamic> _changePassword;
    Uri _uri = Uri.parse(_apiBaseURL + '/' + ServerPath.changePasswordPath);

    Response _httpResponse = await post(_uri, body: _dataPassword);

    if (_httpResponse.statusCode != 404) {
      Map<String, dynamic> _decodedBody = jsonDecode(_httpResponse.body);
      _changePassword = _decodedBody;
    }
    return _changePassword;
  }
}
