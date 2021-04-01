import 'package:e_lapor/GlobalState.dart';
import 'package:e_lapor/Navigation/CustomBottomNavigationBar.dart';
import 'package:e_lapor/Navigation/TabItem.dart';
import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/globalWidgets/CustomForm.dart';
import 'package:e_lapor/globalWidgets/CustomNavigation.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';

import 'package:e_lapor/FakeData/Wilayah.dart';
import 'package:provider/provider.dart';

// import 'package:e_lapor/globalWidgets/CustomNavigation.dart';

enum TambahLaporanState { edit, detail }

class TambahLaporan extends StatefulWidget {
  final String idLaporan;
  final TambahLaporanState state;
  TambahLaporan({this.idLaporan, this.state});
  _TambahLaporanState createState() => _TambahLaporanState();
}

class _TambahLaporanState extends State<TambahLaporan> {
  dynamic _provinsiSelected = '',
      _kotaKabupatenSelected = '',
      _kecamatanSelected = '',
      _kelurahanSelected = '';

  List _provinsiState = [];
  List _kotaKabupatenState = [];
  List _kecamatanState = [];
  List _kelurahanState = [];

  void initState() {
    super.initState();
    initialization();
  }

  Future<void> initialization() async {
    List _decodedProvinsi = await Wilayah.getProvinsi();
    setState(() {
      _provinsiState = _decodedProvinsi;
    });
  }

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _widthAndHeightImageBPTP = SizeConfig.horizontalBlock * 72.5;
    double _iconAndTitleSpace = SizeConfig.horizontalBlock * 3.15;
    double _paddingTop = SizeConfig.horizontalBlock * 4.0;
    double _labelAndFormSpacing = SizeConfig.horizontalBlock * 2.5;
    double _leadingAndHintTextSpacing = SizeConfig.horizontalBlock * 5.25;

    TextStyle _titleStyle = TextStyle(
        fontSize: SizeConfig.horizontalBlock * 5.0,
        color: CustomColors.eLaporBlack,
        fontWeight: FontWeight.w700);

    String _idLaporan = widget.idLaporan;
    TambahLaporanState _state = widget.state;

    bool _isIDLaporanNull = _idLaporan == null;
    bool _isStateNull = _state == null;

    bool _showSubmitButton = true;
    bool _isInputEnabled = true;

    String _appBarTitle = 'Tambah Laporan';

    if (!_isIDLaporanNull && !_isStateNull) {
      if (_state == TambahLaporanState.edit) {
        _appBarTitle = 'Edit Laporan';
      } else {
        _appBarTitle = 'Detail Laporan';
        _showSubmitButton = false;
        _isInputEnabled = false;
      }
    }

    Image _pinGmapsIcon =
        Image.asset(ClientPath.laporanIconPath + '/' + AssetImageName.pinGmaps);

    List<DropdownMenuItem> _provinsi =
        Wilayah.dropdownMenuItemBuilder(_provinsiState);
    List<DropdownMenuItem> _kotaKabupaten =
        Wilayah.dropdownMenuItemBuilder(_kotaKabupatenState);
    List<DropdownMenuItem> _kecamatan =
        Wilayah.dropdownMenuItemBuilder(_kecamatanState);
    List<DropdownMenuItem> _kelurahan =
        Wilayah.dropdownMenuItemBuilder(_kelurahanState);

    return Column(
      children: [
        CustomNavigation.appBar(
            appBarContext: context,
            title: _appBarTitle,
            currentTabItem: TabItem.laporanKu,
            actions: IconButton(
                icon: Icon(Icons.close, color: CustomColors.eLaporWhite),
                onPressed: () => null)),
        Expanded(
          child: Stack(children: [
            Positioned(
              top: -_widthAndHeightImageBPTP / 2 + kToolbarHeight,
              left: SizeConfig.horizontalBlock * 50.0 -
                  (_widthAndHeightImageBPTP / 2),
              child: Container(
                width: _widthAndHeightImageBPTP,
                height: _widthAndHeightImageBPTP,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(ClientPath.iconPath + '/bptp.png'))),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  right: SizeConfig.leftAndRightContentContainerPadding,
                  left: SizeConfig.leftAndRightContentContainerPadding),
              decoration:
                  BoxDecoration(color: Color.fromRGBO(52, 195, 105, 0.95)),
            ),
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.horizontalBlock * 18.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                  child: Container(
                      padding: EdgeInsets.only(
                          top: SizeConfig.horizontalBlock * 5.0,
                          right: SizeConfig.leftAndRightContentContainerPadding,
                          left: SizeConfig.leftAndRightContentContainerPadding),
                      decoration:
                          BoxDecoration(color: CustomColors.eLaporWhite),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.horizontalBlock * 5.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(children: [
                                  _pinGmapsIcon,
                                  SizedBox(width: _iconAndTitleSpace),
                                  Text('Laporan OPT', style: _titleStyle)
                                ]),
                                Padding(
                                    padding: EdgeInsets.only(top: _paddingTop),
                                    child: Container(
                                      color: CustomColors.eLaporBlack,
                                      height: 0.35,
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(top: _paddingTop),
                                    child: Button.submitButton(context,
                                        'PILIH FOTO DARI GALERI', () {},
                                        color: CustomColors.eLaporGreen,
                                        trailing: Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: CustomColors.eLaporWhite))),
                                SizedBox(height: 7.0),
                                Padding(
                                    padding: EdgeInsets.only(top: _paddingTop),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        CustomForm.textFieldLabel(context,
                                            label: 'PROVINSI',
                                            letterSpacing: 1.5,
                                            color: CustomColors.eLaporBlack),
                                        SizedBox(height: _labelAndFormSpacing),
                                        CustomForm.selectBox(context,
                                            defaultOptionText: 'Pilih Provinsi',
                                            defaultOptionValue: '',
                                            enabled: _isInputEnabled,
                                            leading: _pinGmapsIcon,
                                            leadingAndHintTextSpacing:
                                                _leadingAndHintTextSpacing,
                                            items: _provinsi,
                                            value: _provinsiSelected,
                                            borderColor:
                                                CustomColors.eLaporBlack,
                                            borderWidth: 1.0,
                                            onChanged: (newValue) async {
                                          Map<String, dynamic>
                                              _whereKotaKabupaten = {
                                            'entity': 'idProvinsi',
                                            'value': newValue
                                          };
                                          List _decodedKotaKabupaten =
                                              await Wilayah.getKabupatenKota(
                                                  where: _whereKotaKabupaten);

                                          setState(() {
                                            _kotaKabupatenState =
                                                _decodedKotaKabupaten;
                                            _provinsiSelected = newValue;
                                            _kotaKabupatenSelected = '';
                                            _kecamatanSelected = '';
                                            _kelurahanSelected = '';

                                            _kecamatanState = [];
                                            _kelurahanState = [];
                                          });
                                        })
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(top: _paddingTop),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        CustomForm.textFieldLabel(context,
                                            label: 'KOTA/KABUPATEN',
                                            letterSpacing: 1.5,
                                            color: CustomColors.eLaporBlack),
                                        SizedBox(height: _labelAndFormSpacing),
                                        CustomForm.selectBox(context,
                                            defaultOptionText:
                                                'Pilih Kota/Kabupaten',
                                            defaultOptionValue: '',
                                            enabled: _isInputEnabled,
                                            leading: _pinGmapsIcon,
                                            leadingAndHintTextSpacing:
                                                _leadingAndHintTextSpacing,
                                            items: _kotaKabupaten,
                                            value: _kotaKabupatenSelected,
                                            borderColor:
                                                CustomColors.eLaporBlack,
                                            borderWidth: 1.0,
                                            onChanged: (newValue) async {
                                          Map<String, dynamic> _whereKecamatan =
                                              {
                                            'entity': 'idKabupatenKota',
                                            'value': newValue
                                          };
                                          List _decodedKecamatan =
                                              await Wilayah.getKecamatan(
                                                  where: _whereKecamatan);
                                          setState(() {
                                            _kecamatanState = _decodedKecamatan;
                                            _kotaKabupatenSelected = newValue;
                                            _kecamatanSelected = '';
                                            _kelurahanSelected = '';

                                            _kelurahanState = [];
                                          });
                                        })
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(top: _paddingTop),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        CustomForm.textFieldLabel(context,
                                            label: 'KECAMATAN',
                                            letterSpacing: 1.5,
                                            color: CustomColors.eLaporBlack),
                                        SizedBox(height: _labelAndFormSpacing),
                                        CustomForm.selectBox(context,
                                            defaultOptionText:
                                                'Pilih Kecamatan',
                                            defaultOptionValue: '',
                                            enabled: _isInputEnabled,
                                            leading: _pinGmapsIcon,
                                            leadingAndHintTextSpacing:
                                                _leadingAndHintTextSpacing,
                                            items: _kecamatan,
                                            value: _kecamatanSelected,
                                            borderColor:
                                                CustomColors.eLaporBlack,
                                            borderWidth: 1.0,
                                            onChanged: (newValue) async {
                                          Map<String, dynamic> _whereKelurahan =
                                              {
                                            'entity': 'idKecamatan',
                                            'value': newValue
                                          };
                                          List _decodedKelurahan =
                                              await Wilayah.getKelurahan(
                                                  where: _whereKelurahan);
                                          setState(() {
                                            _kelurahanState = _decodedKelurahan;
                                            _kecamatanSelected = newValue;
                                            _kelurahanSelected = '';
                                          });
                                        })
                                      ],
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(top: _paddingTop),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        CustomForm.textFieldLabel(context,
                                            label: 'DESA',
                                            letterSpacing: 1.5,
                                            color: CustomColors.eLaporBlack),
                                        SizedBox(height: _labelAndFormSpacing),
                                        CustomForm.selectBox(context,
                                            defaultOptionText:
                                                'Pilih Desa/Kelurahan',
                                            defaultOptionValue: '',
                                            enabled: _isInputEnabled,
                                            leading: _pinGmapsIcon,
                                            leadingAndHintTextSpacing:
                                                _leadingAndHintTextSpacing,
                                            items: _kelurahan,
                                            value: _kelurahanSelected,
                                            borderColor:
                                                CustomColors.eLaporBlack,
                                            borderWidth: 1.0,
                                            onChanged: (newValue) {
                                          setState(() {
                                            _kelurahanSelected = newValue;
                                          });
                                        })
                                      ],
                                    )),
                                (_showSubmitButton)
                                    ? Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Button.submitButton(context,
                                            'SISA INPUT DI EXCEL', () {},
                                            color: CustomColors.eLaporBlack,
                                            outline: true,
                                            useBorder: false))
                                    : SizedBox(),
                                (_showSubmitButton)
                                    ? Button.submitButton(
                                        context, 'KIRIM DI LAPORAN', () {},
                                        color: CustomColors.eLaporGreen,
                                        trailing: Icon(
                                            Icons.arrow_forward_ios_sharp,
                                            color: CustomColors.eLaporWhite))
                                    : SizedBox()
                              ]),
                        ),
                      ))),
            ),
          ]),
        ),
        (_state != null)
            ? CustomBottomNavigationBar(
                currenTabItem: TabItem.laporanKu,
                onTap: (tabItem) =>
                    Provider.of<GlobalState>(context, listen: false)
                        .currentTabItem = tabItem)
            : SizedBox()
      ],
    );
  }
}
