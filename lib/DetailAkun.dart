import 'package:flutter/material.dart';

import 'package:e_lapor/globalWidgets/CustomNavigation.dart';
import 'package:e_lapor/globalWidgets/CustomForm.dart';
import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/globalWidgets/CustomBottomNavigationBar.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/CustomColors.dart';

import 'package:e_lapor/UbahKataSandi.dart';

class DetailAkun extends StatefulWidget {
  _DetailAkunState createState() => _DetailAkunState();
}

class _DetailAkunState extends State<DetailAkun> {
  String _provinsiSelected = 'Sumatera Utara';

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _paddingTop = SizeConfig.horizontalBlock * 4.0;
    double _labelAndFieldSpace = 10.0;
    double _textFieldLabelFontSize = SizeConfig.horizontalBlock * 3.0;
    double _leadingAndHintTextSpacing = SizeConfig.horizontalBlock * 4.0;

    Color _borderColor = Color(0xFFCBD2D9);

    FontWeight _textFieldLabelFontWeight = FontWeight.w800;

    List<DropdownMenuItem> _provinsi = [
      DropdownMenuItem(child: Text('Sumatera Utara'), value: 'Sumatera Utara'),
      DropdownMenuItem(child: Text('Sumatera Barat'), value: 'Sumatera Barat'),
      DropdownMenuItem(
          child: Text('Sumatera Selatan'), value: 'Sumatera Selatan')
    ];

    return Scaffold(
        backgroundColor: CustomColors.eLaporWhite,
        appBar: CustomNavigation.appBar(title: 'Akun'),
        bottomNavigationBar: CustomBottomNavigationBar(),
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
                          hintText: 'NAMA LENGKAP',
                          borderColor: _borderColor,
                          leading: Icon(Icons.people_alt_outlined,
                              color: CustomColors.eLaporIconColor),
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
                          hintText: 'NOMOR HANDPHONE',
                          keyboardType: TextInputType.phone,
                          borderColor: _borderColor,
                          leading: Icon(Icons.phone,
                              color: CustomColors.eLaporIconColor),
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
                      CustomForm.selectBox(context,
                          items: _provinsi,
                          value: _provinsiSelected, onChanged: (selectedValue) {
                        print(selectedValue);
                        setState(() {
                          _provinsiSelected = selectedValue;
                        });
                      },
                          keyboardType: TextInputType.phone,
                          borderColor: _borderColor,
                          leading: Icon(Icons.pin_drop_outlined,
                              color: CustomColors.eLaporIconColor),
                          leadingAndHintTextSpacing: _leadingAndHintTextSpacing)
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
                          items: _provinsi,
                          value: _provinsiSelected, onChanged: (selectedValue) {
                        print(selectedValue);
                        setState(() {
                          _provinsiSelected = selectedValue;
                        });
                      },
                          keyboardType: TextInputType.phone,
                          borderColor: _borderColor,
                          leading: Icon(Icons.pin_drop_outlined,
                              color: CustomColors.eLaporIconColor),
                          leadingAndHintTextSpacing: _leadingAndHintTextSpacing)
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
                          items: _provinsi,
                          value: _provinsiSelected, onChanged: (selectedValue) {
                        print(selectedValue);
                        setState(() {
                          _provinsiSelected = selectedValue;
                        });
                      },
                          keyboardType: TextInputType.phone,
                          borderColor: _borderColor,
                          leading: Icon(Icons.pin_drop_outlined,
                              color: CustomColors.eLaporIconColor),
                          leadingAndHintTextSpacing: _leadingAndHintTextSpacing)
                    ]),
              ),
              UbahKataSandi(),
              Padding(
                  padding: EdgeInsets.only(top: _paddingTop),
                  child: Button.submitButton(context, 'UBAH', () {},
                      color: CustomColors.eLaporGreen)),
              Button.submitButton(context, 'KELUAR AKUN', () {},
                  color: CustomColors.eLaporRed,
                  useBorder: false,
                  outline: true)
            ]),
          ),
        ));
  }
}
