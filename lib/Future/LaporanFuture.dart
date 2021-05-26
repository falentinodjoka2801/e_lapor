import 'dart:convert';

import 'package:e_lapor/libraries/ServerPath.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart' show required;

class LaporanResponse {
  final List laporan;
  final int statusCode;
  LaporanResponse({@required this.laporan, @required this.statusCode});
}

class LaporanFuture {
  static String _apiBaseURL = ServerPath.apiBaseURL;

  static Future<LaporanResponse> getLaporan(
      {@required int idUser,
      String status,
      int idProvinsi,
      idKabupatenKota,
      int idKecamatan,
      int idKelurahan}) async {
    String _statusQS = (status != null) ? '&status=$status' : '';
    String _provinsiQS = (idProvinsi != null) ? '&provinsi=$idProvinsi' : '';
    String _kabupatenKotaQS =
        (idKabupatenKota != null) ? '&kabupaten=$idKabupatenKota' : '';
    String _kecamatanQS =
        (idKecamatan != null) ? '&kecamatan=$idKecamatan' : '';
    String _kelurahanQS = (idKelurahan != null) ? '&desa=$idKelurahan' : '';

    Uri _url = Uri.parse(_apiBaseURL +
        '/' +
        ServerPath.laporanPath +
        '?user=$idUser$_statusQS$_provinsiQS$_kabupatenKotaQS$_kecamatanQS$_kelurahanQS');
    Response _httpResponse = await get(_url);

    List _laporan = [];
    int _statusCode = _httpResponse.statusCode;

    if (_statusCode == 200) {
      Map<String, dynamic> _decodedBody = jsonDecode(_httpResponse.body);
      if (_decodedBody.containsKey('data')) {
        _laporan = _decodedBody['data'];
      }
    }

    print(_url);
    print(_statusCode);

    return LaporanResponse(laporan: _laporan, statusCode: _statusCode);
  }
}
