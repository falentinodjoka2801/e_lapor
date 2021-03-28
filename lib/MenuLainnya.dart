import 'package:e_lapor/libraries/ClientPath.dart';
import 'package:flutter/material.dart';

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
              onButtonTap: () => null)
        ]);
  }
}
