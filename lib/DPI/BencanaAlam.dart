import 'dart:convert';

import 'package:e_lapor/Beranda.dart';
import 'package:e_lapor/Laporanku.dart';
import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart';

import 'package:e_lapor/DPI/DPIAndOPT.dart';

import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/ServerPath.dart';

enum BencanaAlamAction { add, edit, detail }

class BencanaAlam extends StatefulWidget {
  final TabItem tabItem;
  final int idLaporan;
  final BencanaAlamAction action;
  BencanaAlam(
      {@required this.tabItem,
      this.idLaporan,
      this.action = BencanaAlamAction.add});

  _BencanaAlamState createState() => _BencanaAlamState();
}

class _BencanaAlamState extends State<BencanaAlam> {
  bool _isBtnSubmitActive = true;

  Widget build(BuildContext context) {
    DPIAndOPTAction _dpiAction = DPIAndOPTAction.add;
    if (widget.action == BencanaAlamAction.detail) {
      _dpiAction = DPIAndOPTAction.detail;
    }
    if (widget.action == BencanaAlamAction.edit) {
      _dpiAction = DPIAndOPTAction.edit;
    }

    String _editString = '';
    if (widget.idLaporan != null) {
      if (widget.action == BencanaAlamAction.detail) {
        _editString = 'Detail';
      } else {
        _editString = 'Edit';
      }
    }

    return DPIAndOPT(
        idLaporan: widget.idLaporan,
        action: _dpiAction,
        type: DPIType.bencanaAlam,
        isBtnSubmitActive: _isBtnSubmitActive,
        dpiAndOPTTitle: '$_editString DPI Bencana Alam',
        onSubmit: (dataDPI) async {
          TabItem _tabItem = widget.tabItem;

          BuildContext _tabItemContext =
              navigatesKey[_tabItem].currentState.context;

          setState(() {
            _isBtnSubmitActive = false;
          });

          PickedFile _photo = dataDPI['photo'];

          Uri _url = Uri.parse(
              ServerPath.apiBaseURL + '/' + ServerPath.saveBencanaAlamPath);

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
        sisaTerkena: true,
        sisaTerkenaMenjadiPuso: true,
        sisaTerkenaMenjadiPulih: true,
        luasTambahPulih: true,
        luasTambahTerkena: true,
        keadaanTerkena: true,
        keadaanPulih: true);
  }
}
