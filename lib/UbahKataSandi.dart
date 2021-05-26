import 'package:e_lapor/Future/Akun/AkunFuture.dart';
import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/SPKey.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/globalWidgets/CustomForm.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UbahKataSandi extends StatefulWidget {
  _UbahKataSandiState createState() => _UbahKataSandiState();
}

class _UbahKataSandiState extends State<UbahKataSandi> {
  TextEditingController _kataSandiLamaController = TextEditingController();
  TextEditingController _kataSandiBaruController = TextEditingController();
  TextEditingController _konfirmasiKataSandiBaruController =
      TextEditingController();

  void dispose() {
    super.dispose();

    _kataSandiLamaController.dispose();
    _kataSandiBaruController.dispose();
    _konfirmasiKataSandiBaruController.dispose();
  }

  bool _showKataSandiLama = false;
  bool _showKataSandiBaru = false;
  bool _showKonfirmasiKataSandiBaru = false;
  bool _isSubmitBtnBusy = false;

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _paddingTop = SizeConfig.horizontalBlock * 4.0;
    double _labelAndFieldSpace = 10.0;
    double _textFieldLabelFontSize = SizeConfig.horizontalBlock * 3.0;
    double _leadingAndHintTextSpacing = SizeConfig.horizontalBlock * 4.0;

    Color _borderColor = Color(0xFFCBD2D9);

    FontWeight _textFieldLabelFontWeight = FontWeight.w800;

    Widget _leading = SvgPicture.asset(ClientPath.svgPath + '/lock.svg',
        color: CustomColors.eLaporIconColor);

    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: SizeConfig.horizontalBlock * 5.0),
        child: Row(children: [
          SvgPicture.asset(ClientPath.svgPath + '/info-circle.svg',
              color: CustomColors.dangerColor,
              width: SizeConfig.horizontalBlock * 7.5),
          SizedBox(width: SizeConfig.horizontalBlock * 3.0),
          Text('Ubah Kata Sandi',
              style: TextStyle(
                  fontSize: SizeConfig.horizontalBlock * 5.0,
                  fontWeight: FontWeight.w700))
        ]),
      ),
      Padding(
          padding: EdgeInsets.only(top: _paddingTop),
          child: Container(
            height: 0.5,
            width: SizeConfig.horizontalBlock * 100.0,
            decoration: BoxDecoration(color: CustomColors.eLaporIconColor),
          )),
      Padding(
        padding: EdgeInsets.only(top: _paddingTop),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomForm.textFieldLabel(context,
              label: 'KATA SANDI LAMA',
              color: CustomColors.eLaporBlack,
              fontSize: _textFieldLabelFontSize,
              fontWeight: _textFieldLabelFontWeight),
          SizedBox(height: _labelAndFieldSpace),
          CustomForm.textField(context,
              controller: _kataSandiLamaController,
              hintText: 'KATA SANDI LAMA',
              obsecureText: !_showKataSandiLama,
              borderColor: _borderColor,
              leading: _leading,
              leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    _showKataSandiLama = !_showKataSandiLama;
                  });
                },
                child: SvgPicture.asset(
                    (_showKataSandiLama)
                        ? ClientPath.svgPath + '/eye.svg'
                        : ClientPath.svgPath + '/eye-slash.svg',
                    color: CustomColors.eLaporIconColor),
              ))
        ]),
      ),
      Padding(
        padding: EdgeInsets.only(top: _paddingTop),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomForm.textFieldLabel(context,
              label: 'KATA SANDI BARU',
              color: CustomColors.eLaporBlack,
              fontSize: _textFieldLabelFontSize,
              fontWeight: _textFieldLabelFontWeight),
          SizedBox(height: _labelAndFieldSpace),
          CustomForm.textField(context,
              controller: _kataSandiBaruController,
              hintText: 'KATA SANDI BARU',
              obsecureText: !_showKataSandiBaru,
              borderColor: _borderColor,
              leading: _leading,
              leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    _showKataSandiBaru = !_showKataSandiBaru;
                  });
                },
                child: SvgPicture.asset(
                    (_showKataSandiBaru)
                        ? ClientPath.svgPath + '/eye.svg'
                        : ClientPath.svgPath + '/eye-slash.svg',
                    color: CustomColors.eLaporIconColor),
              ))
        ]),
      ),
      Padding(
        padding: EdgeInsets.only(top: _paddingTop),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomForm.textFieldLabel(context,
              label: 'KONFIRMASI KATA SANDI BARU',
              color: CustomColors.eLaporBlack,
              fontSize: _textFieldLabelFontSize,
              fontWeight: _textFieldLabelFontWeight),
          SizedBox(height: _labelAndFieldSpace),
          CustomForm.textField(context,
              controller: _konfirmasiKataSandiBaruController,
              hintText: 'KONFIRMASI KATA SANDI BARU',
              obsecureText: !_showKonfirmasiKataSandiBaru,
              borderColor: _borderColor,
              leading: _leading,
              leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    _showKonfirmasiKataSandiBaru =
                        !_showKonfirmasiKataSandiBaru;
                  });
                },
                child: SvgPicture.asset(
                    (_showKonfirmasiKataSandiBaru)
                        ? ClientPath.svgPath + '/eye.svg'
                        : ClientPath.svgPath + '/eye-slash.svg',
                    color: CustomColors.eLaporIconColor),
              ))
        ]),
      ),
      Padding(
          padding: EdgeInsets.only(top: _paddingTop),
          child: Button.submitButton(context, 'UBAH', () async {
            setState(() {
              _isSubmitBtnBusy = true;
            });

            Map<String, dynamic> _dataLogin = await AkunFuture.getDataLogin();
            int _userID = _dataLogin[SPKey.idUser];

            Map<String, dynamic> _dataPassword = {
              'user': _userID.toString(),
              'old_password': _kataSandiLamaController.text,
              'password': _kataSandiBaruController.text,
              'password_confirmation': _konfirmasiKataSandiBaruController.text
            };

            Map<String, dynamic> _gantiKataSandi =
                await AkunFuture.changePassword(_dataPassword);

            Color _iconColor = CustomColors.dangerColor;
            String _iconPath = 'danger.svg';
            String _title = 'Server Tidak Merespon!';
            String _buttonText = 'Coba Lagi!';
            String _message = 'Silahkan coba lagi, server tidak merespon!';

            bool _isSuccess;

            if (_gantiKataSandi != null) {
              String _statusGantiKataSandi = _gantiKataSandi['status'];
              String _statusSuccess = 'success';

              _isSuccess =
                  _statusGantiKataSandi.toLowerCase() == _statusSuccess;

              _message = _gantiKataSandi['message'];

              _buttonText = 'OK';

              if (_isSuccess) {
                _iconColor = CustomColors.eLaporGreen;
                _iconPath = 'check-circle.svg';
                _title = 'Berhasil !';
              } else {
                _iconColor = CustomColors.dangerColor;
                _iconPath = 'danger.svg';
                _title = 'Gagal !';
              }
            }

            Widget _actions = Button.button(context, _buttonText, () {
              if (_isSuccess != null && _isSuccess) {
                _kataSandiLamaController.clear();
                _kataSandiBaruController.clear();
                _konfirmasiKataSandiBaruController.clear();
              }
              Navigator.pop(context);
            }, color: _iconColor, outline: true);

            await Alert.textComponent(context,
                icon: SvgPicture.asset(ClientPath.svgPath + '/' + _iconPath),
                title: _title,
                subTitle: _message,
                actions: _actions);

            setState(() {
              _isSubmitBtnBusy = false;
            });
          }, isBusy: _isSubmitBtnBusy, color: CustomColors.eLaporGreen)),
    ]));
  }
}
