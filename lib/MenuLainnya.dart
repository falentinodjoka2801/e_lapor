import 'package:e_lapor/Future/BerandaFuture.dart';
import 'package:e_lapor/globalWidgets/Alert.dart';
import 'package:e_lapor/globalWidgets/Button.dart';
import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:e_lapor/libraries/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:e_lapor/LaporanItem.dart';

class MenuLainnya extends StatelessWidget {
  Widget build(BuildContext context) {
    return GridView.count(
        primary: false,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 15.0,
        children: [
          LaporanItem(
              imageAssetPath: ClientPath.iconPath + '/image10.png',
              buttonText: 'WA ADMIN PUSAT',
              onButtonTap: () async {
                String _waNumber =
                    await BerandaFuture.getAdminWhatsappContact();
                String _waLink = 'https://wa.me/$_waNumber';
                bool _urlValid = await canLaunch(_waLink);
                if (_urlValid) {
                  await launch(_waLink);
                } else {
                  Widget _actions = Button.button(context, 'OK', () {
                    Navigator.pop(context);
                  }, color: CustomColors.eLaporGreen);
                  await Alert.textComponent(context,
                      icon:
                          SvgPicture.asset(ClientPath.svgPath + '/danger.svg'),
                      title: 'URL Tidak Valid',
                      subTitle:
                          'URL Tidak dapat diakses, $_waLink, kemungkinan karena nomor kontak whatsapp salah!',
                      actions: _actions);
                }
              })
        ]);
  }
}
