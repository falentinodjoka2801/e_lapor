import 'dart:convert';

import 'package:e_lapor/DPI/DPIAndOPT.dart' show DPIType;
import 'package:flutter/material.dart' show required;

import 'package:e_lapor/libraries/ServerPath.dart';
import 'package:http/http.dart';

class DPIFuture {
  static String _apiBaseUrl = ServerPath.apiBaseURL;

  static Future<List> getKecamatanWilayahKerja(
      {@required int idUser,
      int idProvinsi,
      int idKabupaten,
      int idKecamatan}) async {
    List _kecamatanWilayahKerja = [];

    String _provinsiQS = (idProvinsi != null) ? '&provinsi=$idProvinsi' : '';
    String _kabupatenQS =
        (idKabupaten != null) ? '&kabupaten=$idKabupaten' : '';
    String _kecamatanQS =
        (idKecamatan != null) ? '&kecamatan=$idKecamatan' : '';

    Uri _url = Uri.parse(_apiBaseUrl +
        '/' +
        ServerPath.kecWilKerPath +
        '?user=$idUser$_provinsiQS$_kabupatenQS$_kecamatanQS');
    Response _httpResponse = await get(_url);
    if (_httpResponse.statusCode == 200) {
      Map<String, dynamic> _decodedBody = jsonDecode(_httpResponse.body);
      if (_decodedBody.containsKey('data')) {
        _kecamatanWilayahKerja = _decodedBody['data'];
      }
    }

    return _kecamatanWilayahKerja;
  }

  static Future<List> getDesaWilayahKerja(
      {int idProvinsi,
      int idKabupaten,
      int idKecamatan,
      int idKelurahan}) async {
    List _desaWilayahKerja = [];

    String _provinsiQS = (idProvinsi != null) ? 'provinsi=$idProvinsi' : '';
    String _kabupatenQS =
        (idKabupaten != null) ? '&kabupaten=$idKabupaten' : '';
    String _kecamatanQS =
        (idKecamatan != null) ? '&kecamatan=$idKecamatan' : '';

    String _kelurahanQS =
        (idKelurahan != null) ? '&kelurahan=$idKelurahan' : '';

    Uri _url = Uri.parse(_apiBaseUrl +
        '/' +
        ServerPath.desaWilKerPath +
        '?$_provinsiQS$_kabupatenQS$_kecamatanQS$_kelurahanQS');
    Response _httpResponse = await get(_url);
    if (_httpResponse.statusCode == 200) {
      Map<String, dynamic> _decodedBody = jsonDecode(_httpResponse.body);
      if (_decodedBody.containsKey('data')) {
        _desaWilayahKerja = _decodedBody['data'];
      }
    }

    return _desaWilayahKerja;
  }

  static Future<List> getKomoditas() async {
    List _komoditas = [];

    Uri _url = Uri.parse(_apiBaseUrl + '/' + ServerPath.komoditasPath);
    Response _httpResponse = await get(_url);
    if (_httpResponse.statusCode == 200) {
      Map<String, dynamic> _decodedBody = jsonDecode(_httpResponse.body);
      if (_decodedBody.containsKey('data')) {
        _komoditas = _decodedBody['data'];
      }
    }

    return _komoditas;
  }

  static Future<bool> saveDPI(
      String tipeDPI, Map<String, dynamic> dataDPI) async {
    return true;
  }

  static Future<Map<String, dynamic>> getDetailDPI(
      int idLaporan, DPIType type) async {
    Map<String, dynamic> _detailDPI;

    Uri _uri;
    if (type == DPIType.banjir) {
      _uri = Uri.parse(
          _apiBaseUrl + '/' + ServerPath.detailBanjirPath + '?id=$idLaporan');
    }
    if (type == DPIType.bencanaAlam) {
      _uri = Uri.parse(_apiBaseUrl +
          '/' +
          ServerPath.detailBencanaAlamPath +
          '?id=$idLaporan');
    }
    if (type == DPIType.kekeringan) {
      _uri = Uri.parse(_apiBaseUrl +
          '/' +
          ServerPath.detailKekeringanPath +
          '?id=$idLaporan');
    }
    if (type == DPIType.gangguanFisiologis) {
      _uri = Uri.parse(_apiBaseUrl +
          '/' +
          ServerPath.detailGangguanFisiologisPath +
          '?id=$idLaporan');
    }

    Response _httpResponse = await get(_uri);

    if (_httpResponse.statusCode == 200) {
      Map<String, dynamic> _decodedBody = jsonDecode(_httpResponse.body);
      if (_decodedBody.containsKey('data')) {
        _detailDPI = _decodedBody['data'];
      }
    }

    return _detailDPI;
  }
}
