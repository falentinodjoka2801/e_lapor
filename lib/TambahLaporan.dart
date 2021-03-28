import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/globalWidgets/CustomForm.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';

import 'package:e_lapor/globalWidgets/CustomNavigation.dart';

class TambahLaporan extends StatefulWidget {
  _TambahLaporanState createState() => _TambahLaporanState();
}

class _TambahLaporanState extends State<TambahLaporan> {
  String _provinsiSelected;

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    List<Widget> _appBarActions = [
      IconButton(
          icon: Icon(Icons.close_outlined, color: CustomColors.eLaporWhite),
          onPressed: () => null)
    ];

    double _widthAndHeightImageBPTP = SizeConfig.horizontalBlock * 72.5;
    double _iconAndTitleSpace = SizeConfig.horizontalBlock * 3.15;
    double _paddingTop = SizeConfig.horizontalBlock * 4.0;
    double _labelAndFormSpacing = SizeConfig.horizontalBlock * 2.5;
    double _leadingAndHintTextSpacing = SizeConfig.horizontalBlock * 5.25;

    TextStyle _titleStyle = TextStyle(
        fontSize: SizeConfig.horizontalBlock * 5.0,
        color: CustomColors.eLaporBlack,
        fontWeight: FontWeight.w700);

    List<DropdownMenuItem> _provinsi = [
      DropdownMenuItem(child: Text('Sumatera Utara'), value: 'Sumatera Utara'),
      DropdownMenuItem(child: Text('Sumatera Barat'), value: 'Sumatera Barat'),
      DropdownMenuItem(
          child: Text('Sumatera Selatan'), value: 'Sumatera Selatan')
    ];

    return Scaffold(
        appBar: CustomNavigation.appBar(
            title: 'Tambah Laporan',
            backgroundColor: CustomColors.eLaporGreen,
            actions: _appBarActions),
        backgroundColor: CustomColors.eLaporWhite,
        body: Stack(children: [
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
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            SizeConfig.leftAndRightContentContainerPadding,
                        vertical: SizeConfig.horizontalBlock * 5.0),
                    decoration: BoxDecoration(color: CustomColors.eLaporWhite),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(children: [
                              Icon(Icons.pin_drop_outlined,
                                  color: CustomColors.eLaporGreen),
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
                                child: Button.submitButton(
                                    context, 'PILIH FOTO DARI GALERI', () {},
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
                                        leading: Icon(Icons.pin_drop_outlined,
                                            color:
                                                CustomColors.eLaporIconColor),
                                        leadingAndHintTextSpacing:
                                            _leadingAndHintTextSpacing,
                                        items: _provinsi,
                                        value: _provinsiSelected,
                                        borderColor: CustomColors.eLaporBlack,
                                        borderWidth: 1.0,
                                        onChanged: (newValue) {
                                      setState(() {
                                        _provinsiSelected = newValue;
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
                                        leading: Icon(Icons.pin_drop_outlined,
                                            color:
                                                CustomColors.eLaporIconColor),
                                        leadingAndHintTextSpacing:
                                            _leadingAndHintTextSpacing,
                                        items: _provinsi,
                                        value: _provinsiSelected,
                                        borderColor: CustomColors.eLaporBlack,
                                        borderWidth: 1.0,
                                        onChanged: (newValue) {
                                      setState(() {
                                        _provinsiSelected = newValue;
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
                                        leading: Icon(Icons.pin_drop_outlined,
                                            color:
                                                CustomColors.eLaporIconColor),
                                        leadingAndHintTextSpacing:
                                            _leadingAndHintTextSpacing,
                                        items: _provinsi,
                                        value: _provinsiSelected,
                                        borderColor: CustomColors.eLaporBlack,
                                        borderWidth: 1.0,
                                        onChanged: (newValue) {
                                      setState(() {
                                        _provinsiSelected = newValue;
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
                                        leading: Icon(Icons.pin_drop_outlined,
                                            color:
                                                CustomColors.eLaporIconColor),
                                        leadingAndHintTextSpacing:
                                            _leadingAndHintTextSpacing,
                                        items: _provinsi,
                                        value: _provinsiSelected,
                                        borderColor: CustomColors.eLaporBlack,
                                        borderWidth: 1.0,
                                        onChanged: (newValue) {
                                      setState(() {
                                        _provinsiSelected = newValue;
                                      });
                                    })
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(top: _paddingTop),
                                child: Button.submitButton(
                                    context, 'SISA INPUT DI EXCEL', () {},
                                    color: CustomColors.eLaporBlack,
                                    outline: true,
                                    useBorder: false)),
                            Button.submitButton(
                                context, 'KIRIM DI LAPORAN', () {},
                                color: CustomColors.eLaporGreen,
                                trailing: Icon(Icons.arrow_forward_ios_sharp,
                                    color: CustomColors.eLaporWhite))
                          ]),
                    ))),
          )
        ]));
  }
}
