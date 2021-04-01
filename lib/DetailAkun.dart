import 'package:e_lapor/GlobalState.dart';
import 'package:e_lapor/Navigation/CustomBottomNavigationBar.dart';
import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:e_lapor/globalWidgets/CustomNavigation.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/globalWidgets/CustomForm.dart';
import 'package:e_lapor/globalWidgets/Button.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/ClientPath.dart';

import 'package:e_lapor/UbahKataSandi.dart';

import 'package:e_lapor/FakeData/Wilayah.dart';

import 'package:e_lapor/Future/Akun/AkunFuture.dart';
import 'package:provider/provider.dart';

class DetailAkun extends StatefulWidget {
  _DetailAkunState createState() => _DetailAkunState();
}

class _DetailAkunState extends State<DetailAkun> {
  String _provinsiSelected = '',
      _kabupatenKotaSelected = '',
      _kecamatanSelected = '';

  List _provinsiState = [];
  List _kabupatenKotaState = [];
  List _kecamatanState = [];

  void initState() {
    super.initState();
    initialization();
  }

  Future<void> initialization() async {
    List _provinsiData = await Wilayah.getProvinsi();
    setState(() {
      _provinsiState = _provinsiData;
    });
  }

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _paddingTop = SizeConfig.horizontalBlock * 4.0;
    double _labelAndFieldSpace = 10.0;
    double _textFieldLabelFontSize = SizeConfig.horizontalBlock * 3.0;
    double _leadingAndHintTextSpacing = SizeConfig.horizontalBlock * 4.0;

    Color _borderColor = Color(0xFFCBD2D9);

    FontWeight _textFieldLabelFontWeight = FontWeight.w800;

    Image _leading = Image.asset(ClientPath.laporanIconPath + '/pin-gmaps.png');

    List<DropdownMenuItem> _provinsi =
        Wilayah.dropdownMenuItemBuilder(_provinsiState);
    List<DropdownMenuItem> _kabupatenKota =
        Wilayah.dropdownMenuItemBuilder(_kabupatenKotaState);
    List<DropdownMenuItem> _kecamatan =
        Wilayah.dropdownMenuItemBuilder(_kecamatanState);

    return Column(
      children: [
        CustomNavigation.appBar(
            currentTabItem: TabItem.akun,
            appBarContext: context,
            title: 'Akun'),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.leftAndRightContentContainerPadding,
                  right: SizeConfig.leftAndRightContentContainerPadding,
                  bottom: SizeConfig.leftAndRightContentContainerPadding),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeConfig.horizontalBlock * 5.0),
                      child: Row(children: [
                        Icon(Icons.info_outline_rounded,
                            color: CustomColors.eLaporRed,
                            size: SizeConfig.horizontalBlock * 7.5),
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
                          decoration: BoxDecoration(
                              color: CustomColors.eLaporIconColor),
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
                                hintText: 'NAMA LENGKAP',
                                borderColor: _borderColor,
                                leading: Icon(Icons.people_alt_outlined,
                                    color: CustomColors.eLaporIconColor),
                                leadingAndHintTextSpacing:
                                    _leadingAndHintTextSpacing)
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
                                hintText: 'NOMOR HANDPHONE',
                                keyboardType: TextInputType.phone,
                                borderColor: _borderColor,
                                leading: Icon(Icons.phone,
                                    color: CustomColors.eLaporIconColor),
                                leadingAndHintTextSpacing:
                                    _leadingAndHintTextSpacing)
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
                            CustomForm.selectBox(context,
                                defaultOptionText: 'Pilih Provinsi',
                                defaultOptionValue: '',
                                items: _provinsi,
                                value: _provinsiSelected,
                                onChanged: (selectedValue) async {
                              Map<String, dynamic> _whereKabupatenKota = {
                                'entity': 'idProvinsi',
                                'value': selectedValue
                              };
                              List _decodedKabupatenKota =
                                  await Wilayah.getKabupatenKota(
                                      where: _whereKabupatenKota);
                              setState(() {
                                _provinsiSelected = selectedValue;

                                _kabupatenKotaState = _decodedKabupatenKota;
                                _kecamatanState = [];

                                _kabupatenKotaSelected = '';
                                _kecamatanSelected = '';
                              });
                            },
                                keyboardType: TextInputType.phone,
                                borderColor: _borderColor,
                                leading: _leading,
                                leadingAndHintTextSpacing:
                                    _leadingAndHintTextSpacing)
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
                            CustomForm.selectBox(context,
                                defaultOptionText: 'Pilih Kota/Kabupaten',
                                defaultOptionValue: '',
                                items: _kabupatenKota,
                                value: _kabupatenKotaSelected,
                                onChanged: (selectedValue) async {
                              Map<String, dynamic> _whereKecamatan = {
                                'entity': 'idKabupatenKota',
                                'value': selectedValue
                              };
                              List _decodedKecamatan =
                                  await Wilayah.getKecamatan(
                                      where: _whereKecamatan);

                              setState(() {
                                _kabupatenKotaSelected = selectedValue;

                                _kecamatanState = _decodedKecamatan;

                                _kecamatanSelected = '';
                              });
                            },
                                keyboardType: TextInputType.phone,
                                borderColor: _borderColor,
                                leading: _leading,
                                leadingAndHintTextSpacing:
                                    _leadingAndHintTextSpacing)
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
                            CustomForm.selectBox(context,
                                defaultOptionText: 'Pilih Kecamatan',
                                defaultOptionValue: '',
                                items: _kecamatan,
                                value: _kecamatanSelected,
                                onChanged: (selectedValue) {
                              setState(() {
                                _kecamatanSelected = selectedValue;
                              });
                            },
                                keyboardType: TextInputType.phone,
                                borderColor: _borderColor,
                                leading: _leading,
                                leadingAndHintTextSpacing:
                                    _leadingAndHintTextSpacing)
                          ]),
                    ),
                    UbahKataSandi(),
                    Padding(
                        padding: EdgeInsets.only(top: _paddingTop),
                        child: Button.submitButton(context, 'UBAH', () {},
                            color: CustomColors.eLaporGreen)),
                    Button.submitButton(context, 'KELUAR AKUN', () async {
                      BuildContext _context =
                          navigatesKey[TabItem.akun].currentContext;
                      bool _konfirmasiLogout =
                          await AkunFuture.konfirmasiLogout(_context);
                      if (_konfirmasiLogout != null) {
                        print('Logout');
                      }
                    },
                        color: CustomColors.eLaporRed,
                        useBorder: false,
                        outline: true)
                  ]),
            ),
          ),
        ),
        CustomBottomNavigationBar(
            currenTabItem: TabItem.akun,
            onTap: (tabItem) => Provider.of<GlobalState>(context, listen: false)
                .currentTabItem = tabItem)
      ],
    );
  }
}
