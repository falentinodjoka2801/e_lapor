import 'dart:convert';

import 'package:flutter/material.dart' show Text, DropdownMenuItem, required;
import 'package:flutter/services.dart';

import 'package:e_lapor/libraries/ClientPath.dart';

enum BagianWilayah { provinsi, kabupatenKota, kecamatan, kelurahan }

class Wilayah {
  static Future<List> getProvinsi() async {
    String _encodedProvinsi =
        await rootBundle.loadString(ClientPath.jsonPath + '/provinsi.json');
    List _decodedProvinsi = await jsonDecode(_encodedProvinsi);

    return _decodedProvinsi;
  }

  static Future<List> getKabupatenKota({Map<String, dynamic> where}) async {
    String _encodedKabupatenKota =
        await rootBundle.loadString(ClientPath.jsonPath + '/kabupaten.json');
    List _decodedKabupatenKota = await jsonDecode(_encodedKabupatenKota);
    if (where != null) {
      String _whereEntity = where['entity'];
      dynamic _whereValue = where['value'];
      _decodedKabupatenKota = _decodedKabupatenKota
          .where((element) => element[_whereEntity] == _whereValue)
          .toList();
    }

    return _decodedKabupatenKota;
  }

  static Future<List> getKecamatan({Map<String, dynamic> where}) async {
    String _encodedKecamatan =
        await rootBundle.loadString(ClientPath.jsonPath + '/kecamatan.json');
    List _decodedKecamatan = await jsonDecode(_encodedKecamatan);

    if (where != null) {
      String _whereEntity = where['entity'];
      dynamic _whereValue = where['value'];
      _decodedKecamatan = _decodedKecamatan
          .where((element) => element[_whereEntity] == _whereValue)
          .toList();
    }

    return _decodedKecamatan;
  }

  static Future<List> getKelurahan({Map<String, dynamic> where}) async {
    String _encodedKelurahan =
        await rootBundle.loadString(ClientPath.jsonPath + '/kelurahan.json');
    List _decodedKelurahan = await jsonDecode(_encodedKelurahan);

    if (where != null) {
      String _whereEntity = where['entity'];
      dynamic _whereValue = where['value'];
      _decodedKelurahan = _decodedKelurahan
          .where((element) => element[_whereEntity] == _whereValue)
          .toList();
    }

    return _decodedKelurahan;
  }

  static List dropdownMenuItemBuilder(List dropdownMenuItems,
      {@required String textIndex,
      @required String valueIndex,
      bool parseValueToInt = false}) {
    return (dropdownMenuItems.length >= 1)
        ? dropdownMenuItems.map((e) {
            dynamic _value = e[valueIndex];

            if (parseValueToInt) {
              if (_value.runtimeType == String) {
                _value = int.parse(_value);
              }
            }

            return DropdownMenuItem(value: _value, child: Text(e[textIndex]));
          }).toList()
        : <DropdownMenuItem>[];
  }
}
