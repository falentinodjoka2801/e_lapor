import 'package:flutter/material.dart';

import 'package:e_lapor/globalWidgets/CustomForm.dart';

import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:e_lapor/libraries/CustomColors.dart';

class UbahKataSandi extends StatefulWidget {
  _UbahKataSandiState createState() => _UbahKataSandiState();
}

class _UbahKataSandiState extends State<UbahKataSandi> {
  bool _showKataSandiLama = false;
  bool _showKataSandiBaru = false;
  bool _showKonfirmasiKataSandiBaru = false;

  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    double _paddingTop = SizeConfig.horizontalBlock * 4.0;
    double _labelAndFieldSpace = 10.0;
    double _textFieldLabelFontSize = SizeConfig.horizontalBlock * 3.0;
    double _leadingAndHintTextSpacing = SizeConfig.horizontalBlock * 4.0;

    Color _borderColor = Color(0xFFCBD2D9);

    FontWeight _textFieldLabelFontWeight = FontWeight.w800;

    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: SizeConfig.horizontalBlock * 5.0),
        child: Row(children: [
          Icon(Icons.info_outline_rounded,
              color: CustomColors.eLaporRed,
              size: SizeConfig.horizontalBlock * 7.5),
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
              hintText: 'KATA SANDI LAMA',
              obsecureText: !_showKataSandiLama,
              borderColor: _borderColor,
              leading:
                  Icon(Icons.lock_outline, color: CustomColors.eLaporIconColor),
              leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    _showKataSandiLama = !_showKataSandiLama;
                  });
                },
                child: Icon(
                    (_showKataSandiLama)
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
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
              hintText: 'KATA SANDI BARU',
              obsecureText: !_showKataSandiBaru,
              borderColor: _borderColor,
              leading:
                  Icon(Icons.lock_outline, color: CustomColors.eLaporIconColor),
              leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    _showKataSandiBaru = !_showKataSandiBaru;
                  });
                },
                child: Icon(
                    (_showKataSandiBaru)
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
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
              hintText: 'KONFIRMASI KATA SANDI BARU',
              obsecureText: !_showKonfirmasiKataSandiBaru,
              borderColor: _borderColor,
              leading:
                  Icon(Icons.lock_outline, color: CustomColors.eLaporIconColor),
              leadingAndHintTextSpacing: _leadingAndHintTextSpacing,
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    _showKonfirmasiKataSandiBaru =
                        !_showKonfirmasiKataSandiBaru;
                  });
                },
                child: Icon(
                    (_showKonfirmasiKataSandiBaru)
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: CustomColors.eLaporIconColor),
              ))
        ]),
      )
    ]));
  }
}
