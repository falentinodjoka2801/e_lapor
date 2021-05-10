import 'package:e_lapor/libraries/ServerPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:e_lapor/Future/OPTFuture.dart';
import 'package:e_lapor/globalWidgets/CustomForm.dart';
import 'package:e_lapor/globalWidgets/Loading.dart';
import 'package:e_lapor/globalWidgets/CustomNavigation.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';

class DetailLaporan extends StatefulWidget {
  final int idLaporan;
  DetailLaporan({@required this.idLaporan});
  _DetailLaporanState createState() => _DetailLaporanState();
}

class _DetailLaporanState extends State<DetailLaporan> {
  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _widthAndHeightImageBPTP = SizeConfig.horizontalBlock * 72.5;
    double _iconAndTitleSpace = SizeConfig.horizontalBlock * 3.15;
    double _paddingTop = SizeConfig.horizontalBlock * 4.0;
    double _labelAndFormSpacing = SizeConfig.horizontalBlock * 2.5;
    double _leadingAndHintTextSpacing = SizeConfig.horizontalBlock * 5.25;

    Color _borderColor = CustomColors.eLaporBlack;

    TextStyle _titleStyle = TextStyle(
        fontSize: SizeConfig.horizontalBlock * 5.0,
        color: CustomColors.eLaporBlack,
        fontWeight: FontWeight.w700);

    int _idLaporan = widget.idLaporan;

    Widget _pinGmapsIcon = SvgPicture.asset(ClientPath.svgPath + '/map-pin.svg',
        width: SizeConfig.horizontalBlock * 5.5,
        color: CustomColors.dangerColor);

    Widget _readOnlyTextField(value) {
      return CustomForm.readOnlyTextField(context,
          value: value,
          leading: _pinGmapsIcon,
          leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
          borderColor: _borderColor);
    }

    return Scaffold(
        appBar: CustomNavigation.appBar(
            appBarContext: context, title: 'Detail Laporan'),
        body: FutureBuilder<Map<String, dynamic>>(
            future: OPTFuture.getDetailLaporanOPT(id: _idLaporan),
            builder: (futureBuilderContext, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> _detailOPT = snapshot.data;

                String _imageNetwork =
                    ServerPath.apiBaseURL + '/elapor/' + _detailOPT['photo'];

                return Stack(children: [
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
                              image: AssetImage(
                                  ClientPath.iconPath + '/bptp.png'))),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeConfig.leftAndRightContentContainerPadding,
                        left: SizeConfig.leftAndRightContentContainerPadding),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(52, 195, 105, 0.95)),
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
                      child: Container(
                          padding: EdgeInsets.only(
                              top: SizeConfig.horizontalBlock * 5.0,
                              right: SizeConfig
                                  .leftAndRightContentContainerPadding,
                              left: SizeConfig
                                  .leftAndRightContentContainerPadding),
                          decoration:
                              BoxDecoration(color: CustomColors.eLaporWhite),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.horizontalBlock * 5.0),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(children: [
                                      _pinGmapsIcon,
                                      SizedBox(width: _iconAndTitleSpace),
                                      Text('Laporan OPT', style: _titleStyle)
                                    ]),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Container(
                                          color: CustomColors.eLaporBlack,
                                          height: 0.35,
                                        )),
                                    Column(children: [
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Container(
                                            constraints: BoxConstraints(
                                                minHeight:
                                                    SizeConfig.horizontalBlock *
                                                        45.0),
                                            padding: EdgeInsets.symmetric(
                                                vertical:
                                                    SizeConfig.horizontalBlock *
                                                        10.0),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: NetworkImage(
                                                        _imageNetwork)),
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                color: Color(0X5534C369)),
                                          )),
                                      (false)
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: _paddingTop),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  CustomForm.textFieldLabel(
                                                      context,
                                                      label: 'Tahun',
                                                      letterSpacing: 1.5,
                                                      color: CustomColors
                                                          .eLaporBlack),
                                                  SizedBox(
                                                      height:
                                                          _labelAndFormSpacing),
                                                  _readOnlyTextField(
                                                      _detailOPT['tahun'])
                                                ],
                                              ))
                                          : SizedBox(),
                                      (false)
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: _paddingTop),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  CustomForm.textFieldLabel(
                                                      context,
                                                      label: 'Bulan',
                                                      letterSpacing: 1.5,
                                                      color: CustomColors
                                                          .eLaporBlack),
                                                  SizedBox(
                                                      height:
                                                          _labelAndFormSpacing),
                                                  _readOnlyTextField(
                                                      _detailOPT['bulan'])
                                                ],
                                              ))
                                          : SizedBox(),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'PROVINSI',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['provinsi']
                                                      ['name'])
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'KOTA/KABUPATEN',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['kabupaten']
                                                      ['name'])
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'KECAMATAN',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['kecamatan']
                                                      ['name'])
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'DESA',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['desa']['name'])
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Komoditas',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['komoditas']
                                                      ['name'])
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Curah Hujan',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['curah_hujan'])
                                            ],
                                          )),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Varietas',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['varietas'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Umur Tanaman',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['umur'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Luas Tanam',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['luas'])
                                            ]),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Kriteria OPT',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['kriteria']
                                                      ['name'])
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'OPT',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['opt']['name'])
                                            ],
                                          )),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: _paddingTop),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Periode',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['periode'])
                                            ],
                                          )),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Sisa Serangan Periode Sebelumnya (Ringan)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'sisa_serangan_ringan'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Sisa Serangan Periode Sebelumnya (Sedang)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'sisa_serangan_sedang'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Sisa Serangan Periode Sebelumnya (Berat)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'sisa_serangan_berat'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Sisa Serangan Periode Sebelumnya (Puso)',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'sisa_serangan_puso'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Jumlah',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'sisa_serangan_jumlah'])
                                            ]),
                                      ),
                                      (false)
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: _paddingTop),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomForm.textFieldLabel(
                                                        context,
                                                        label: 'Luas Terkena',
                                                        letterSpacing: 1.5,
                                                        color: CustomColors
                                                            .eLaporBlack),
                                                    SizedBox(
                                                        height:
                                                            _labelAndFormSpacing),
                                                    _readOnlyTextField(
                                                        _detailOPT[
                                                            'luas_terkena'])
                                                  ]),
                                            )
                                          : SizedBox(),
                                      (false)
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: _paddingTop),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomForm.textFieldLabel(
                                                        context,
                                                        label: 'Luas Panen',
                                                        letterSpacing: 1.5,
                                                        color: CustomColors
                                                            .eLaporBlack),
                                                    SizedBox(
                                                        height:
                                                            _labelAndFormSpacing),
                                                    _readOnlyTextField(
                                                        _detailOPT[
                                                            'luas_panen'])
                                                  ]))
                                          : SizedBox(),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'LUAS TAMBAH SERANGAN PADA PERIODE LAPORAN (ha) Ringan',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_tambah_serangan_ringan'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'LUAS TAMBAH SERANGAN PADA PERIODE LAPORAN (ha) Sedang',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_tambah_serangan_sedang'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'LUAS TAMBAH SERANGAN PADA PERIODE LAPORAN (ha) Berat',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_tambah_serangan_berat'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'LUAS TAMBAH SERANGAN PADA PERIODE LAPORAN (ha) Puso',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_tambah_serangan_puso'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Jumlah',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_tambah_serangan_jumlah'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Pestisida Kimia',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_pengendalian_kimia'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Pestisida Hayati',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_pengendalian_hayati'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Eradikasi',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_pengendalian_eradiksi'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Cara Lain',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_pengendalian_cara_lain'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Jumlah',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_pengendalian_jumlah'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Keadaan Serangan Pada Periode Laporan (ha) Ringan',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_keadaan_ringan'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Keadaan Serangan Pada Periode Laporan (ha) Sedang',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_keadaan_sedang'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Keadaan Serangan Pada Periode Laporan (ha) Berat',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_keadaan_berat'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label:
                                                      'Luas Keadaan Serangan Pada Periode Laporan (ha) Puso',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_keadaan_puso'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Jumlah',
                                                  letterSpacing: 1.5,
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'luas_keadaan_jumlah'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'Periode Okmar asep',
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(_detailOPT[
                                                  'periode_okmar_asep'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'th mt',
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['th_mt'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'MT MK MH',
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['mt_mk_mh'])
                                            ]),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: _paddingTop),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomForm.textFieldLabel(context,
                                                  label: 'subround',
                                                  color:
                                                      CustomColors.eLaporBlack),
                                              SizedBox(
                                                  height: _labelAndFormSpacing),
                                              _readOnlyTextField(
                                                  _detailOPT['subround'])
                                            ]),
                                      ),
                                    ])
                                  ]),
                            ),
                          ))),
                ]);
              } else {
                return Loading(
                    loadingTitle: 'Harap Tunggu',
                    loadingSubTitle: 'Aplikasi sedang mengambil data laporan');
              }
            }));
  }
}
