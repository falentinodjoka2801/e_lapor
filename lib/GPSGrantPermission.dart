import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:flutter/material.dart';

class GPSGrantPermission extends StatelessWidget {
  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    return Center(
        child: Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.horizontalBlock * 5.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(ClientPath.iconPath + '/gps.png'),
        SizedBox(height: SizeConfig.horizontalBlock * 7.25),
        Text('Hidupkan GPS',
            style: TextStyle(
                color: CustomColors.eLaporBlack,
                fontSize: SizeConfig.horizontalBlock * 5.0,
                fontWeight: FontWeight.w700)),
        SizedBox(height: 6.0),
        Text(
            'Anda diwajibkan untuk memberikan izinkan kepada Aplikasi untuk menggunakan fitur pembacaan GPS pada handphone Anda.',
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 1.5,
                fontSize: SizeConfig.horizontalBlock * 4.0,
                fontWeight: FontWeight.w400)),
        SizedBox(height: SizeConfig.horizontalBlock * 8.25),
        Button.submitButton(context, 'YA, IZINKAN', () {},
            color: CustomColors.eLaporGreen),
        SizedBox(height: SizeConfig.horizontalBlock * 5.0),
        Button.submitButton(context, 'ABAIKAN', () {},
            color: CustomColors.eLaporRed,
            outline: true,
            borderColor: CustomColors.eLaporRed)
      ]),
    ));
  }
}
