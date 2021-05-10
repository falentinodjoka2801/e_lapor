import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart' show PickedFile;
import 'package:http/http.dart';

import 'package:e_lapor/DPI/DPIAndOPT.dart';
import 'package:e_lapor/Beranda.dart';

import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/ServerPath.dart';

enum GangguanFisiologisAction { add, edit, detail }

class GangguanFisiologis extends StatefulWidget {
  final int idLaporan;
  final GangguanFisiologisAction action;
  GangguanFisiologis(
      {this.idLaporan, this.action = GangguanFisiologisAction.add});

  @override
  _GangguanFisiologisState createState() => _GangguanFisiologisState();
}

class _GangguanFisiologisState extends State<GangguanFisiologis> {
  bool _isBtnSubmitActive = true;

  Widget build(BuildContext context) {
    DPIAndOPTAction _dpiAction = DPIAndOPTAction.add;
    if (widget.action == GangguanFisiologisAction.detail) {
      _dpiAction = DPIAndOPTAction.detail;
    }
    if (widget.action == GangguanFisiologisAction.edit) {
      _dpiAction = DPIAndOPTAction.edit;
    }

    String _editString = '';
    if (widget.idLaporan != null) {
      if (widget.action == GangguanFisiologisAction.detail) {
        _editString = 'Detail';
      } else {
        _editString = 'Edit';
      }
    }

    return DPIAndOPT(
      idLaporan: widget.idLaporan,
      action: _dpiAction,
      type: DPIType.gangguanFisiologis,
      isBtnSubmitActive: _isBtnSubmitActive,
      dpiAndOPTTitle: '$_editString DPI Gangguan Fisiologis',
      onSubmit: (dataDPI) async {
        setState(() {
          _isBtnSubmitActive = false;
        });

        PickedFile _photo = dataDPI['photo'];

        Uri _url = Uri.parse(ServerPath.apiBaseURL +
            '/' +
            ServerPath.saveGangguanFisiologisPath);

        MultipartRequest _request = MultipartRequest('POST', _url);

        _request.files.add(await MultipartFile.fromPath('photo', _photo.path));

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

        Widget _actions = Button.button(context, _buttonText, () {
          if (_success) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) => Beranda()), (route) => false);
          } else {
            Navigator.pop(context);
          }
        }, color: _iconColor, outline: true);

        setState(() {
          _isBtnSubmitActive = true;
        });

        await Alert.textComponent(context,
            icon: _icon, title: _title, subTitle: _message, actions: _actions);
      },
      sisaTerkenaMenjadiRingan: true,
      sisaTerkenaMenjadiSedang: true,
      sisaTerkenaMenjadiBerat: true,
      sisaTerkenaMenjadiPuso: true,
      sisaTerkenaMenjadiPulih: true,
      sisaTerkenaJumlah: true,
      luasTambahRingan: true,
      luasTambahSedang: true,
      luasTambahBerat: true,
      luasTambahPulih: true,
      luasTambahJumlah: true,
      keadaanRingan: true,
      keadaanSedang: true,
      keadaanBerat: true,
      keadaanPulih: true,
      keadaanJumlah: true,
    );
  }
}
