import 'dart:convert';

import 'package:e_lapor/libraries/ServerPath.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart' show required;

class NotifikasiFuture {
  static String _apiBaseURL = ServerPath.apiBaseURL;

  static Future<List> getNotifikasi({@required int idUser}) async {
    List _notifikasi = [];

    Uri _url = Uri.parse(
        _apiBaseURL + '/' + ServerPath.notifikasiPath + '?user=$idUser');
    Response _httpResponse = await get(_url);
    if (_httpResponse.statusCode == 200) {
      Map<String, dynamic> _decodedBody = jsonDecode(_httpResponse.body);
      if (_decodedBody.containsKey('data')) {
        _notifikasi = _decodedBody['data'];
      }
    }

    return _notifikasi;
  }
}
