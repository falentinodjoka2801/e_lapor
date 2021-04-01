import 'package:flutter/material.dart';

import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/Button.dart';

import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';

class AkunFuture {
  static Future<bool> konfirmasiLogout(
      BuildContext konfirmasiLogoutContext) async {
    bool _konfirmasiLogout = await Alert.textComponent(konfirmasiLogoutContext,
        isDismissible: true,
        icon: ClientPath.iconPath + '/danger.png',
        subTitle: 'Apakah anda yakin untuk keluar dari aplikasi?',
        title: null,
        useRouteNavigator: false,
        actions: Column(children: [
          Button.submitButton(konfirmasiLogoutContext, 'YA, KELUARKAN SAYA',
              () {
            Navigator.pop(konfirmasiLogoutContext, true);
          },
              color: CustomColors.eLaporGreen,
              trailing: IconButton(
                  color: CustomColors.eLaporWhite,
                  icon: Icon(Icons.arrow_forward_ios_sharp),
                  onPressed: () => null)),
          SizedBox(height: 5.0),
          Button.submitButton(konfirmasiLogoutContext, 'BATAL', () {
            Navigator.pop(konfirmasiLogoutContext, false);
          }, outline: true, useBorder: false, color: CustomColors.eLaporRed)
        ]));
    return _konfirmasiLogout;
  }
}
