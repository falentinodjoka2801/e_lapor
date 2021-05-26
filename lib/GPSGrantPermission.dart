import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:e_lapor/libraries/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

class GPSGrantPermission extends StatelessWidget {
  final void Function() abaikanOnClick;
  GPSGrantPermission({@required this.abaikanOnClick});
  Widget build(BuildContext context) {
    SizeConfig().initSize(context);

    return Scaffold(
        body: Center(
            child: Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.horizontalBlock * 5.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset(ClientPath.svgPath + '/gps.svg'),
        SizedBox(height: SizeConfig.horizontalBlock * 7.25),
        Text('Hidupkan GPS',
            style: TextStyle(
                color: CustomColors.eLaporBlack,
                fontSize: SizeConfig.horizontalBlock * 5.0,
                fontWeight: FontWeight.w700)),
        SizedBox(height: 6.0),
        Text(
            'Anda diwajibkan untuk memberikan izin kepada Aplikasi untuk menggunakan fitur pembacaan GPS pada handphone Anda.',
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 1.5,
                fontSize: SizeConfig.horizontalBlock * 4.0,
                fontWeight: FontWeight.w400)),
        SizedBox(height: SizeConfig.horizontalBlock * 8.25),
        Button.submitButton(context, 'YA, IZINKAN', () async {
          await Geolocator.openLocationSettings();
        }, color: CustomColors.eLaporGreen),
        SizedBox(height: SizeConfig.horizontalBlock * 5.0),
        Button.submitButton(context, 'ABAIKAN', abaikanOnClick,
            color: CustomColors.eLaporRed,
            outline: true,
            borderColor: CustomColors.eLaporRed)
      ]),
    )));
  }
}
