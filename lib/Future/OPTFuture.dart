import 'dart:convert';
import 'package:flutter/material.dart' show required;
import 'package:http/http.dart';

import 'package:e_lapor/libraries/ServerPath.dart';

class OPTFuture {
  static String _apiBaseUrl = ServerPath.apiBaseURL;

  static Future<List> getKriteria() async {
    List _kriteria = [];

    Uri _url = Uri.parse(_apiBaseUrl + '/' + ServerPath.kriteriaPath);
    Response _httpResponse = await get(_url);
    if (_httpResponse.statusCode == 200) {
      Map<String, dynamic> _decodedBody = jsonDecode(_httpResponse.body);
      if (_decodedBody.containsKey('data')) {
        _kriteria = _decodedBody['data'];
      }
    }

    return _kriteria;
  }

  static Future<List> getOPT(
      {@required int komoditas, @required int kriteria}) async {
    List _opt = [];

    Uri _url = Uri.parse(_apiBaseUrl +
        '/' +
        ServerPath.optPath +
        '?komoditas=$komoditas&kriteria=$kriteria');
    Response _httpResponse = await get(_url);
    if (_httpResponse.statusCode == 200) {
      Map<String, dynamic> _decodedBody = jsonDecode(_httpResponse.body);
      if (_decodedBody.containsKey('data')) {
        _opt = _decodedBody['data'];
      }
    }

    return _opt;
  }

  static Future<Map<String, dynamic>> getDetailLaporanOPT(
      {@required int id}) async {
    Map<String, dynamic> _detailLaporanOPT;

    Uri _uri =
        Uri.parse(_apiBaseUrl + '/' + ServerPath.detailOPTPath + '?id=$id');
    Response _httpResponse = await get(_uri);
    if (_httpResponse.statusCode == 200) {
      Map<String, dynamic> _decodedBody = jsonDecode(_httpResponse.body);
      if (_decodedBody.containsKey('data')) {
        _detailLaporanOPT = _decodedBody['data'];
      }
    }

    return _detailLaporanOPT;
  }
}
