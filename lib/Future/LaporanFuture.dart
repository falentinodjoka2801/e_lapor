import 'dart:convert';

import 'package:e_lapor/libraries/ServerPath.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart' show required;

class LaporanFuture {
  static String _apiBaseURL = ServerPath.apiBaseURL;

  static Future<List> getLaporan({@required int idUser, String status}) async {
    List _laporan = [];

    String _statusQS = (status != null) ? '&status=$status' : '';

    Uri _url = Uri.parse(
        _apiBaseURL + '/' + ServerPath.laporanPath + '?user=$idUser$_statusQS');
    Response _httpResponse = await get(_url);

    if (_httpResponse.statusCode == 200) {
      Map<String, dynamic> _decodedBody = jsonDecode(_httpResponse.body);
      if (_decodedBody.containsKey('data')) {
        _laporan = _decodedBody['data'];
      }
    }

    return _laporan;
  }
}
