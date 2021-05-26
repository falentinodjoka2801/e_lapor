import 'dart:convert';

import 'package:e_lapor/Beranda.dart';
import 'package:e_lapor/Laporanku.dart';
import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/ServerPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';

import 'package:e_lapor/DPI/DPIAndOPT.dart';
import 'package:image_picker/image_picker.dart';

enum BanjirAction { add, edit, detail }

class Banjir extends StatefulWidget {
  final TabItem tabItem;
  final int idLaporan;
  final BanjirAction action;
  Banjir(
      {@required this.tabItem, this.idLaporan, this.action = BanjirAction.add});

  _BanjirState createState() => _BanjirState();
}

class _BanjirState extends State<Banjir> {
  bool _isBtnSubmitActive = true;

  Widget build(BuildContext context) {
    DPIAndOPTAction _dpiAction = DPIAndOPTAction.add;
    if (widget.action == BanjirAction.detail) {
      _dpiAction = DPIAndOPTAction.detail;
    }
    if (widget.action == BanjirAction.edit) {
      _dpiAction = DPIAndOPTAction.edit;
    }

    String _editString = '';
    if (widget.idLaporan != null) {
      if (widget.action == BanjirAction.detail) {
        _editString = 'Detail';
      } else {
        _editString = 'Edit';
      }
    }

    return DPIAndOPT(
        idLaporan: widget.idLaporan,
        action: _dpiAction,
        type: DPIType.banjir,
        isBtnSubmitActive: _isBtnSubmitActive,
        dpiAndOPTTitle: '$_editString DPI Banjir',
        onSubmit: (dataDPI) async {
          TabItem _tabItem = widget.tabItem;
          BuildContext _tabItemContext =
              navigatesKey[_tabItem].currentState.context;

          setState(() {
            _isBtnSubmitActive = false;
          });

          PickedFile _photo = dataDPI['photo'];

          String _stringURI =
              ServerPath.apiBaseURL + '/' + ServerPath.saveBanjirPath;
          if (dataDPI.containsKey('id')) {
            _stringURI =
                ServerPath.apiBaseURL + '/' + ServerPath.updateBanjirPath;
          }
          Uri _url = Uri.parse(_stringURI);

          MultipartRequest _request = MultipartRequest('POST', _url);

          if (_photo != null) {
            _request.files
                .add(await MultipartFile.fromPath('photo', _photo.path));
          }

          dataDPI.forEach((key, value) {
            if (key.toLowerCase() != 'photo') {
              _request.fields[key] = value.toString();
            }
          });

          StreamedResponse _response = await _request.send();

          Response _httpResponse = await Response.fromStream(_response);
          Map<String, dynamic> _decodedBody = jsonDecode(_httpResponse.body);
          String _status = _decodedBody['status'];
          String _message = _decodedBody['message'];

          Color _iconColor = CustomColors.dangerColor;
          String _iconPath = 'danger.svg';
          String _title = 'Gagal!';
          String _buttonText = 'Coba Lagi!';
          bool _success = false;
          if (_status.toLowerCase() == 'success') {
            _iconColor = CustomColors.eLaporGreen;
            _iconPath = 'check-circle.svg';
            _title = 'Berhasil !';
            _buttonText = 'OK';
            _success = true;
          }

          Widget _icon = SvgPicture.asset(ClientPath.svgPath + '/$_iconPath');
          Widget _pageToRoute =
              (_tabItem == TabItem.beranda) ? Beranda() : LaporanKu();

          Widget _actions = Button.button(context, _buttonText, () {
            if (_success) {
              Navigator.pushAndRemoveUntil(
                  _tabItemContext,
                  MaterialPageRoute(builder: (_) => _pageToRoute),
                  (route) => false);
            } else {
              Navigator.pop(_tabItemContext);
            }
          }, color: _iconColor, outline: true);

          setState(() {
            _isBtnSubmitActive = true;
          });

          await Alert.textComponent(_tabItemContext,
              icon: _icon,
              title: _title,
              subTitle: _message,
              actions: _actions);
        },
        tinggiBanjir: true,
        sisaTerkena: true,
        sisaTerkenaMenjadiPuso: true,
        sisaTerkenaMenjadiSurut: true,
        luasTambahTerkena: true,
        luasTambahSurut: true,
        keadaanTerkena: true,
        keadaanSurut: true);
  }
}
