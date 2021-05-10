
import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:e_lapor/SplashScreen.dart';
import 'package:e_lapor/globalWidgets/CustomNavigation.dart';
import 'package:e_lapor/libraries/NavigatorKey.dart';
import 'package:e_lapor/libraries/SPKey.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/globalWidgets/CustomForm.dart';
import 'package:e_lapor/globalWidgets/Button.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/ClientPath.dart';

import 'package:e_lapor/UbahKataSandi.dart';

import 'package:e_lapor/Future/Akun/AkunFuture.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailAkun extends StatefulWidget {
  _DetailAkunState createState() => _DetailAkunState();
}

class _DetailAkunState extends State<DetailAkun> {
  TextEditingController _namaLengkapController = TextEditingController();
  TextEditingController _nomorHandphoneController = TextEditingController();
  TextEditingController _provinsiController = TextEditingController();
  TextEditingController _kabupatenKotaController = TextEditingController();
  TextEditingController _kecamatanController = TextEditingController();

  void initState() {
    super.initState();
    initialization();
  }

  Future<void> initialization() async {
    Map<String, dynamic> _activeUserDataLogin = await AkunFuture.getDataLogin();

    _provinsiController.text = _activeUserDataLogin[SPKey.provinsiUserString];
    _kabupatenKotaController.text =
        _activeUserDataLogin[SPKey.kabupatenKotaUserString];
    _namaLengkapController.text = _activeUserDataLogin[SPKey.namaUser];
    _nomorHandphoneController.text = _activeUserDataLogin[SPKey.phoneUser];
    _kecamatanController.text = _activeUserDataLogin[SPKey.kecamatanUser];
  }

  void dispose() {
    super.dispose();

    _namaLengkapController.dispose();
    _nomorHandphoneController.dispose();
    _provinsiController.dispose();
    _kabupatenKotaController.dispose();
    _kecamatanController.dispose();
  }

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _paddingTop = SizeConfig.horizontalBlock * 4.0;
    double _labelAndFieldSpace = 10.0;
    double _textFieldLabelFontSize = SizeConfig.horizontalBlock * 3.0;
    double _leadingAndHintTextSpacing = SizeConfig.horizontalBlock * 4.0;

    Color _borderColor = Color(0xFFCBD2D9);

    FontWeight _textFieldLabelFontWeight = FontWeight.w800;

    Widget _mapPin = SvgPicture.asset(ClientPath.svgPath + '/map-pin.svg',
        color: CustomColors.dangerColor);

    return Scaffold(
        appBar: CustomNavigation.appBar(appBarContext: context, title: 'Akun'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.leftAndRightContentContainerPadding,
                right: SizeConfig.leftAndRightContentContainerPadding,
                bottom: SizeConfig.leftAndRightContentContainerPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.horizontalBlock * 5.0),
                child: Row(children: [
                  SvgPicture.asset(ClientPath.svgPath + '/info-circle.svg',
                      color: CustomColors.dangerColor,
                      width: SizeConfig.horizontalBlock * 7.5),
                  SizedBox(width: SizeConfig.horizontalBlock * 3.0),
                  Text('Detil Akun',
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
                    decoration:
                        BoxDecoration(color: CustomColors.eLaporIconColor),
                  )),
              Padding(
                padding: EdgeInsets.only(top: _paddingTop),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomForm.textFieldLabel(context,
                          label: 'NAMA LENGKAP',
                          color: CustomColors.eLaporBlack,
                          fontSize: _textFieldLabelFontSize,
                          fontWeight: _textFieldLabelFontWeight),
                      SizedBox(height: _labelAndFieldSpace),
                      CustomForm.textField(context,
                          enabled: false,
                          controller: _namaLengkapController,
                          hintText: 'NAMA LENGKAP',
                          borderColor: _borderColor,
                          leading: SvgPicture.asset(
                              ClientPath.svgPath + '/user.svg'),
                          leadingAndHintTextSpacing: _leadingAndHintTextSpacing)
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: _paddingTop),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomForm.textFieldLabel(context,
                          label: 'NOMOR HANDPHONE',
                          color: CustomColors.eLaporBlack,
                          fontSize: _textFieldLabelFontSize,
                          fontWeight: _textFieldLabelFontWeight),
                      SizedBox(height: _labelAndFieldSpace),
                      CustomForm.textField(context,
                          enabled: false,
                          controller: _nomorHandphoneController,
                          hintText: 'NOMOR HANDPHONE',
                          keyboardType: TextInputType.phone,
                          borderColor: _borderColor,
                          leading: SvgPicture.asset(
                              ClientPath.svgPath + '/phone.svg'),
                          leadingAndHintTextSpacing: _leadingAndHintTextSpacing)
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: _paddingTop),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomForm.textFieldLabel(context,
                          label: 'PROVINSI',
                          color: CustomColors.eLaporBlack,
                          fontSize: _textFieldLabelFontSize,
                          fontWeight: _textFieldLabelFontWeight),
                      SizedBox(height: _labelAndFieldSpace),
                      CustomForm.textField(context,
                          enabled: false,
                          hintText: 'Provinsi',
                          borderColor: _borderColor,
                          leading: _mapPin,
                          leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
                          controller: _provinsiController)
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: _paddingTop),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomForm.textFieldLabel(context,
                          label: 'KOTA/KABUPATEN',
                          color: CustomColors.eLaporBlack,
                          fontSize: _textFieldLabelFontSize,
                          fontWeight: _textFieldLabelFontWeight),
                      SizedBox(height: _labelAndFieldSpace),
                      CustomForm.textField(context,
                          enabled: false,
                          hintText: 'Kota atau Kabupaten',
                          borderColor: _borderColor,
                          leading: _mapPin,
                          leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
                          controller: _kabupatenKotaController)
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: _paddingTop),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomForm.textFieldLabel(context,
                          label: 'KECAMATAN',
                          color: CustomColors.eLaporBlack,
                          fontSize: _textFieldLabelFontSize,
                          fontWeight: _textFieldLabelFontWeight),
                      SizedBox(height: _labelAndFieldSpace),
                      CustomForm.textField(context,
                          enabled: false,
                          hintText: 'Kecamatan',
                          borderColor: _borderColor,
                          leading: _mapPin,
                          leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
                          controller: _kecamatanController)
                    ]),
              ),
              UbahKataSandi(),
              Button.submitButton(context, 'KELUAR AKUN', () async {
                BuildContext _context =
                    navigatesKey[TabItem.akun].currentContext;
                bool _konfirmasiLogout =
                    await AkunFuture.konfirmasiLogout(_context);
                if (_konfirmasiLogout != null) {
                  if (_konfirmasiLogout) {
                    await AkunFuture.removeDataLogin();
                    // await Navigator.pushAndRemoveUntil(
                    //     _context,
                    //     MaterialPageRoute(builder: (_) => SplashScreen()),
                    //     (route) => false);
                    await Navigator.of(NavigatorKey.of(context)
                            .globalKey
                            .currentState
                            .context)
                        .pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => SplashScreen()),
                            (route) => false);
                  }
                }
              }, color: CustomColors.eLaporRed, useBorder: false, outline: true)
            ]),
          ),
        ));
  }
}
