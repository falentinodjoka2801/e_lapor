import 'package:e_lapor/GPSGrantPermission.dart';
import 'package:flutter/material.dart';

import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/globalWidgets/DataNotFound.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';

class ListTombol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextButton(
          onPressed: () async {
            Widget _actions = Button.submitButton(context, 'OKE', () {},
                color: CustomColors.eLaporGreen,
                trailing: GestureDetector(
                  child: Icon(Icons.arrow_forward_ios_sharp,
                      color: CustomColors.eLaporWhite),
                ));
            await Alert.textComponent(context,
                isDismissible: true,
                icon: ClientPath.iconPath + '/danger.png',
                title: 'Wohooo/Whoops!',
                subTitle: 'Ini adalah pesan dari alert',
                actions: _actions);
          },
          child: Text('Alert Message')),
      TextButton(
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 350),
                    pageBuilder: (_pRBContext, _opacity, _) => FadeTransition(
                        opacity: _opacity,
                        child: Scaffold(
                            body: Center(
                                child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DataNotFound(textMessage: 'Data Tidak Ditemukan'),
                          ],
                        ))))));
          },
          child: Text('Dana Not Found')),
      TextButton(
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 350),
                    pageBuilder: (_pRBContext, opacity, _) => Scaffold(
                        backgroundColor: CustomColors.eLaporWhite,
                        body: GPSGrantPermission())));
          },
          child: Text('GPS Grant Permission')),
    ])));
  }
}
